//
//  SessionRepo.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

protocol SessionRepoProtocol {
    func fetchRemoteData() async throws -> [SessionEntity]
    func fetchLocalData() async throws -> [SessionEntity]
    func saveSessions(_ sessions: [SessionEntity])
    func deleteLocalData()
}

class SessionRepo: SessionRepoProtocol {
    private let apiService: ApiServiceProtocol
    private let sessionDm: SessionDataManager
    
    init(
        apiService: ApiServiceProtocol,
        sessionDm: SessionDataManager,
    ) {
        self.apiService = apiService
        self.sessionDm = sessionDm
    }
    
    func fetchRemoteData() async throws -> [SessionEntity] {
        return try await apiService.fetch(endpoint: .sessions)
    }
    
    func fetchLocalData() -> [SessionEntity] {
        let sessions = sessionDm.fetchSessions()
        return sessions.sorted { $0.id < $1.id }
    }
    
    func saveSessions(_ sessions: [SessionEntity]) {
        sessionDm.saveSessions(sessions)
    }
    
    func deleteLocalData() {
        sessionDm.deleteAllSessions()
    }
}
