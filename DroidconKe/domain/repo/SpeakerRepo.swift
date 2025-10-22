//
//  SpeakerRepo.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

protocol SpeakerRepoProtocol {
    func fetchRemoteSpeakers() async throws -> [SpeakerEntity]
    func fetchLocalSpeakers() throws -> [SpeakerEntity]
    func saveSpeakers(_ speakers: [SpeakerEntity])
    func clearAllSpeakers()
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
    
    func fetchRemoteSpeakers() async throws -> [SpeakerEntity] {
        let response: SpeakersRespDTO = try await apiService.fetch(
            endpoint: .speakers(eventSlug: AppSecrets.droidcon_slug, perPage: 100)
        )
        return response.data.map { dto in
            SpeakerMapper.dtoToEntity(dto, session: "", isDroidcon: true)
        }
    }

    func fetchLocalSpeakers() -> [SpeakerEntity] {
        let speakers = speakerDm.fetchSpeakers()
        return speakers.sorted { $0.name < $1.name }
    }
    
    func saveSpeakers(_ speakers: [SpeakerEntity]) {
        speakerDm.saveSpeakers(speakers)
    }
    
    func clearAllSpeakers() {
        speakerDm.deleteAllSpeakers()
    }
}
