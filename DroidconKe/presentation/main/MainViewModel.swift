//
//  MainViewModel.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import Foundation

final class MainViewModel: ObservableObject {
    @Published var feeds: [FeedEntity] = []
    @Published var organizers: [OrganizerEntity] = []
    @Published var sessions: [SessionEntity] = []

    @Published var uiState: UiState = .idle

    private let feedRepo: FeedRepoProtocol
    private let organizerRepo: OrganizerRepoProtocol
    private let sessionRepo: SessionRepoProtocol
    private let speakerRepo: SpeakerRepoProtocol

    init(
        feedRepo: FeedRepoProtocol,
        organizerRepo: OrganizerRepoProtocol,
        sessionRepo: SessionRepoProtocol,
        speakerRepo: SpeakerRepoProtocol
    ) {
        self.feedRepo = feedRepo
        self.organizerRepo = organizerRepo
        self.sessionRepo = sessionRepo
        self.speakerRepo = speakerRepo
    }

    func initializeData() {
        Task {
            await syncData()
        }
    }

    func syncData() async {
        await MainActor.run {
            self.uiState = .loading
        }

        do {
            let remoteSessions = try await sessionRepo.fetchRemoteSessions()

            await MainActor.run {
                self.sessions = remoteSessions.sorted { $0.id < $1.id }
            }
            
            try await saveData()

            await MainActor.run {
                self.uiState = .loaded
            }

            print("✅ Data synced successfully.")
        } catch {
            await MainActor.run {
                self.uiState = .error("Failed: \(error.localizedDescription)")
            }
            if sessions.isEmpty {
                fetchSessionsLocally()
            }

            print("❌ Syncing failed: \(error)")
        }
    }

    private func fetchSessionsLocally() {
        let localSessions = sessionRepo.fetchLocalSessions()
        if !localSessions.isEmpty {
            self.sessions = localSessions
        } else {
            print("No sessions found")
        }
    }
    
    private func saveData() async throws {
        sessionRepo.saveSessions(sessions)
    }

}
