//
//  HomeViewModel.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var feeds: [FeedEntity] = []
    @Published var organizers: [OrganizerEntity] = []
    @Published var sessions: [SessionEntity] = []
    @Published var speakers: [SpeakerEntity] = []

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
            let fetchedFeeds = try await feedRepo.fetchRemoteData()
            let fetchedOrganizers = try await organizerRepo.fetchRemoteData()
            let fetchedSessions = try await sessionRepo.fetchRemoteData()
            let fetchedSpeakers = try await speakerRepo.fetchRemoteData()

            await MainActor.run {
                self.feeds = fetchedFeeds
                self.organizers = fetchedOrganizers
                self.sessions = fetchedSessions
                self.speakers = fetchedSpeakers
            }
            
            print("Now saving data")
            try await saveData()

            await MainActor.run {
                self.uiState = .loaded
            }

            print("✅ Data synced successfully.")
        } catch {
            await MainActor.run {
                self.uiState = .error("Failed: \(error.localizedDescription)")
            }
            print("❌ Syncying failed: \(error)")
        }
    }

    private func saveData() async throws {
        feedRepo.saveFeeds(feeds)
        organizerRepo.saveOrganizers(organizers)
        sessionRepo.saveSessions(sessions)
        speakerRepo.saveSpeakers(speakers)
    }

}
