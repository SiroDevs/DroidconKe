//
//  OrganizerRepo.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

protocol OrganizerRepoProtocol {
    func fetchRemoteData() async throws -> [OrganizerEntity]
    func fetchLocalData() async throws -> [OrganizerEntity]
    func saveOrganizers(_ organizers: [OrganizerEntity])
    func deleteLocalData()
}

class OrganizerRepo: OrganizerRepoProtocol {
    private let apiService: ApiServiceProtocol
    private let organizerDm: OrganizerDataManager
    
    init(
        apiService: ApiServiceProtocol,
        organizerDm: OrganizerDataManager,
    ) {
        self.apiService = apiService
        self.organizerDm = organizerDm
    }
    
    func fetchRemoteData() async throws -> [OrganizerEntity] {
        return try await apiService.fetch(endpoint: .organizers(type: "", page: 1, perPage: 100))
    }
    
    func fetchLocalData() -> [OrganizerEntity] {
        let organizers = organizerDm.fetchOrganizers()
        return organizers.sorted { $0.id < $1.id }
    }
    
    func saveOrganizers(_ organizers: [OrganizerEntity]) {
        organizerDm.saveOrganizers(organizers)
    }
    
    func deleteLocalData() {
        organizerDm.deleteAllOrganizers()
    }
}
