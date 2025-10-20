//
//  SpeakerRepo.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

protocol SpeakerRepoProtocol {
    func fetchRemoteData() async throws -> [SpeakerEntity]
    func fetchLocalData() async throws -> [SpeakerEntity]
    func saveSpeakers(_ speakers: [SpeakerEntity])
    func deleteLocalData()
}

class SpeakerRepo: SpeakerRepoProtocol {
    private let apiService: ApiServiceProtocol
    private let speakerDm: SpeakerDataManager
    
    init(
        apiService: ApiServiceProtocol,
        speakerDm: SpeakerDataManager,
    ) {
        self.apiService = apiService
        self.speakerDm = speakerDm
    }
    
    func fetchRemoteData() async throws -> [SpeakerEntity] {
        return try await apiService.fetch(endpoint: .speakers(perPage: 100))
    }
    
    func fetchLocalData() -> [SpeakerEntity] {
        let speakers = speakerDm.fetchSpeakers()
        return speakers.sorted { $0.id < $1.id }
    }
    
    func saveSpeakers(_ speakers: [SpeakerEntity]) {
        speakerDm.saveSpeakers(speakers)
    }
    
    func deleteLocalData() {
        speakerDm.deleteAllSpeakers()
    }
}
