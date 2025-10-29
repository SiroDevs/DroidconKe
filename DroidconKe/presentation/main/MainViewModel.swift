//
//  MainViewModel.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import Foundation

final class MainViewModel: ObservableObject {
    private let prefsRepo: PrefsRepo
    private let netUtils: NetworkUtils
    private let feedRepo: FeedRepoProtocol
    private let organizerRepo: OrganizerRepoProtocol
    private let sessionRepo: SessionRepoProtocol
    private let speakerRepo: SpeakerRepoProtocol
    private let sponsorRepo: SponsorRepoProtocol
    
    @Published var feeds: [FeedEntity] = []
    @Published var organizers: [OrganizerEntity] = []
    @Published var sessions: [SessionEntity] = []
    @Published var speakers: [SpeakerEntity] = []
    @Published var sponsors: [SponsorEntity] = []
    @Published var uiState: UiState = .idle
    @Published var selectedConFilter: ConFilter = .droidcon

    init(
        prefsRepo: PrefsRepo,
        netUtils: NetworkUtils = .shared,
        feedRepo: FeedRepoProtocol,
        organizerRepo: OrganizerRepoProtocol,
        sessionRepo: SessionRepoProtocol,
        speakerRepo: SpeakerRepoProtocol,
        sponsorRepo: SponsorRepoProtocol
    ) {
        self.prefsRepo = prefsRepo
        self.netUtils = netUtils
        self.feedRepo = feedRepo
        self.organizerRepo = organizerRepo
        self.sessionRepo = sessionRepo
        self.speakerRepo = speakerRepo
        self.sponsorRepo = sponsorRepo
        self.selectedConFilter = ConFilter(rawValue: prefsRepo.conType) ?? .droidcon
    }

    func syncData() async {
        Task { @MainActor in
            let isOnline = await netUtils.checkNetworkAvailability()
            if isOnline {
                await fetchRemoteData()
            } else {
                await fetchLocalData()
            }
        }
    }
    
    func updateConFilter(_ filter: ConFilter) {
        selectedConFilter = filter
        prefsRepo.conType = filter.rawValue
        prefsRepo.conTypeSet = true
        
        Task { @MainActor in
            await syncData()
        }
    }

    @MainActor
    func fetchRemoteData() async {
        uiState = .loading

        do {
            async let organizersTask = organizerRepo.fetchRemoteData()
            async let sessionsTask = sessionRepo.fetchRemoteData()
            async let sponsorsTask = sponsorRepo.fetchRemoteData()

            let (remoteOrganizers, remoteSessions, remoteSponsors) = try await (
                organizersTask,
                sessionsTask,
                sponsorsTask
            )

            organizers = remoteOrganizers.sorted { $0.id < $1.id }
            sessions = remoteSessions.sorted { $0.id < $1.id }
            sponsors = remoteSponsors.sorted { $0.id < $1.id }

            try await saveData()

            uiState = .loaded
            print("✅ Data synced successfully.")
        } catch {
            uiState = .error("Failed: \(error.localizedDescription)")

            print("❌ Syncing failed: \(error)")
            if sessions.isEmpty {
                await fetchLocalData()
            }

        }
    }

    private func fetchLocalData() async {
        uiState = .loading
        let localSessions = await Task.detached { self.sessionRepo.fetchLocalData() }.value
        let localSpeakers = await Task.detached { self.speakerRepo.fetchLocalData() }.value

        if !localSessions.isEmpty {
            sessions = localSessions
            speakers = localSpeakers
            uiState = .loaded
        } else {
            print("No sessions found")
        }
    }
    
    private func saveData() async throws {
        await Task.detached {
            self.organizerRepo.saveData(self.organizers)
            self.sessionRepo.saveData(self.sessions)
            self.sponsorRepo.saveData(self.sponsors)
        }.value

        let localSpeakers = await Task.detached { self.speakerRepo.fetchLocalData() }.value
        speakers = localSpeakers
    }
}

enum ConFilter: String, CaseIterable, Identifiable {
    case all = "All Sessions"
    case droidcon = "Droidcon Sessions"
    case fluttercon = "FlutterCon Sessions"
    
    var id: String { rawValue }
}
