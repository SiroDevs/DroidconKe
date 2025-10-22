//
//  SponsorRepo.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

protocol SponsorRepoProtocol {
    func fetchRemoteData() async throws -> [SponsorEntity]
    func fetchLocalData() async throws -> [SponsorEntity]
    func saveSponsors(_ sponsors: [SponsorEntity])
    func clearAllSponsors()
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
        return try await apiService.fetch(endpoint: .sponsors(orgSlug: "", perPage: 100))
    }
    
    func fetchLocalData() -> [SponsorEntity] {
        let sponsors = sponsorDm.fetchSponsors()
        return sponsors.sorted { $0.id < $1.id }
    }
    
    func saveSponsors(_ sponsors: [SponsorEntity]) {
        sponsorDm.saveSponsors(sponsors)
    }
    
    func clearAllSponsors() {
        sponsorDm.deleteAllSponsors()
    }
}
