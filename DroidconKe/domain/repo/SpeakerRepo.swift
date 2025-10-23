//
//  SpeakerRepo.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

protocol SpeakerRepoProtocol {
    func fetchRemoteData() async throws -> [SpeakerEntity]
    func fetchLocalData() -> [SpeakerEntity]
    func saveData(_ speakers: [SpeakerEntity])
    func clearAllData()
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
        let response: SpeakersRespDTO = try await apiService.fetch(
            endpoint: .speakers(eventSlug: AppSecrets.droidcon_slug, perPage: 100)
        )
        return response.data.map { dto in
            SpeakerMapper.dtoToEntity(dto, session: "", isDroidcon: true)
        }
    }

    func fetchLocalData() -> [SpeakerEntity] {
        let speakers = speakerDm.fetchSpeakers()
        let uniqueSpeakers = Array(
            Dictionary(grouping: speakers, by: { $0.name })
                .compactMap { $0.value.first }
        )
        return uniqueSpeakers.sorted { $0.name < $1.name }
    }
    
    func saveData(_ speakers: [SpeakerEntity]) {
        speakerDm.saveSpeakers(speakers)
    }
    
    func clearAllData() {
        speakerDm.deleteAllSpeakers()
    }
}
