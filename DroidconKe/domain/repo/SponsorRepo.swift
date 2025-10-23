//
//  SponsorRepo.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

protocol SponsorRepoProtocol {
    func fetchRemoteData() async throws -> [SponsorEntity]
    func fetchLocalData() async throws -> [SponsorEntity]
    func saveData(_ sponsors: [SponsorEntity])
    func clearAllData()
}

class SponsorRepo: SponsorRepoProtocol {
    private let apiService: ApiServiceProtocol
    private let sponsorDm: SponsorDataManager
    
    init(
        apiService: ApiServiceProtocol,
        sponsorDm: SponsorDataManager,
    ) {
        self.apiService = apiService
        self.sponsorDm = sponsorDm
    }
    
    func fetchRemoteData() async throws -> [SponsorEntity] {
        let response: SponsorsRespDTO = try await apiService.fetch(
            endpoint: .sponsors(eventSlug: AppSecrets.droidcon_slug)
        )
        return response.data.map { dto in
            SponsorMapper.dtoToEntity(dto)
        }
    }
    
    func fetchLocalData() -> [SponsorEntity] {
        let sponsors = sponsorDm.fetchSponsors()
        return sponsors.sorted { $0.id < $1.id }
    }
    
    func saveData(_ sponsors: [SponsorEntity]) {
        sponsorDm.saveSponsors(sponsors)
    }
    
    func clearAllData() {
        sponsorDm.deleteAllSponsors()
    }
}
