//
//  MainViewModel.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import Foundation
import SwiftUI

final class MainViewModel: ObservableObject {
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
//            let remoteFeeds = try await feedRepo.fetchRemoteData()
//            let remoteOrganizers = try await organizerRepo.fetchRemoteData()
//            let remoteSessions = try await sessionRepo.fetchRemoteData()
            let remoteSpeakers = try await speakerRepo.fetchRemoteSpeakers()

            await MainActor.run {
//                self.feeds = remoteFeeds
//                self.organizers = remoteOrganizers
//                self.sessions = remoteSessions
                self.speakers = remoteSpeakers.sorted { $0.name < $1.name }
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
            if speakers.isEmpty {
                fetchSpeakersLocally()
            }

            print("❌ Syncying failed: \(error)")
        }
    }

    private func fetchSpeakersLocally() {
        do {
            let localSpeakers = try speakerRepo.fetchLocalSpeakers()
            if !localSpeakers.isEmpty {
                self.speakers = localSpeakers
            }
        } catch {
            print("❌ Fetching speakers failed: \(error)")
        }
    }
    
    private func saveData() async throws {
//        feedRepo.saveFeeds(feeds)
//        organizerRepo.saveOrganizers(organizers)
//        sessionRepo.saveSessions(sessions)
        speakerRepo.saveSpeakers(speakers)
    }

}
