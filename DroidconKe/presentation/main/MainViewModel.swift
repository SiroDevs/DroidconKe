//
//  MainViewModel.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import Foundation

final class MainViewModel: ObservableObject {
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
    @Published var isOnline: Bool = false


    init(
        netUtils: NetworkUtils = .shared,
        feedRepo: FeedRepoProtocol,
        organizerRepo: OrganizerRepoProtocol,
        sessionRepo: SessionRepoProtocol,
        speakerRepo: SpeakerRepoProtocol,
        sponsorRepo: SponsorRepoProtocol
    ) {
        self.netUtils = netUtils
        self.feedRepo = feedRepo
        self.organizerRepo = organizerRepo
        self.sessionRepo = sessionRepo
        self.speakerRepo = speakerRepo
        self.sponsorRepo = sponsorRepo
    }

    func initialize() {
        Task { @MainActor in
            isOnline = await netUtils.checkNetworkAvailability()
            if isOnline {
                await syncData()
            } else {
                await fetchSessionsLocally()
            }
        }
    }
    
    @MainActor
    func syncData() async {
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
                await fetchSessionsLocally()
            }

        }
    }

    private func fetchSessionsLocally() async {
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
