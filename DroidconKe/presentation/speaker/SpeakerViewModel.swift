//
//  SpeakerViewModel.swift
//  DroidconKe
//
//  Created by @sirodevs on 23/10/2025.
//

import Foundation

final class SpeakerViewModel: ObservableObject {
    private let sessionRepo: SessionRepoProtocol
    private let speakerRepo: SpeakerRepoProtocol
    
//    @Published var speaker: SpeakerEntity
//    @Published var sessions: [SessionEntity]
    @Published var uiState: UiState = .idle
    @Published var isBookmarked: Bool = false

    init(
        sessionRepo: SessionRepoProtocol,
        speakerRepo: SpeakerRepoProtocol
    ) {
        self.sessionRepo = sessionRepo
        self.speakerRepo = speakerRepo
    }

    @MainActor
    func fetchSpeakerDetails(speakerId: Int) async {
        uiState = .loading
        uiState = .loaded
    }
    
    func toggleBookmark() {
        isBookmarked.toggle()
    }

}
