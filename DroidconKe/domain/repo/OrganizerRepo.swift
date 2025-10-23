//
//  OrganizerRepo.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

protocol OrganizerRepoProtocol {
    func fetchRemoteData() async throws -> [OrganizerEntity]
    func fetchLocalData() async throws -> [OrganizerEntity]
    func saveData(_ organizers: [OrganizerEntity])
    func clearAllData()
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
        let response: OrganizersRespDTO = try await apiService.fetch(
            endpoint: .organizers(perPage: 100)
        )
        return response.data.map { dto in
            OrganizerMapper.dtoToEntity(dto)
        }
    }
    
    func fetchLocalData() -> [OrganizerEntity] {
        let organizers = organizerDm.fetchOrganizers()
        return organizers.sorted { $0.id < $1.id }
    }
    
    func saveData(_ organizers: [OrganizerEntity]) {
        organizerDm.saveOrganizers(organizers)
    }
    
    func clearAllData() {
        organizerDm.deleteAllOrganizers()
    }
}
