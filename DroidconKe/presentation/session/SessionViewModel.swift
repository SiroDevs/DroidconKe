//
//  SessionViewModel.swift
//  DroidconKe
//
//  Created by @sirodevs on 23/10/2025.
//

import Foundation

final class SessionViewModel: ObservableObject {
    private let sessionRepo: SessionRepoProtocol
    
//    @Published var session: SessionEntity
//    @Published var uiState: UiState = .idle

    init(
        sessionRepo: SessionRepoProtocol
    ) {
        self.sessionRepo = sessionRepo
    }

    func initializeData() {
        Task {
            await loadSession()
        }
    }

    @MainActor
    func loadSession() async {
//        uiState = .loading
//        uiState = .loaded
    }

}
