//
//  SessionRepo.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import Foundation

protocol SessionRepoProtocol {
    func fetchRemoteSessions() async throws -> [SessionEntity]
    func fetchLocalSessions() -> [SessionEntity]
    func saveSessions(_ sessions: [SessionEntity])
    func clearAllSessions()
}

class SessionRepo: SessionRepoProtocol {
    private let apiService: ApiServiceProtocol
    private let sessionDm: SessionDataManager
    
    init(
        apiService: ApiServiceProtocol,
        sessionDm: SessionDataManager
    ) {
        self.apiService = apiService
        self.sessionDm = sessionDm
    }
    
    func fetchRemoteSessions() async throws -> [SessionEntity] {
        let response: SessionsRespDTO = try await apiService.fetch(
            endpoint: .sessions(eventSlug: AppSecrets.droidcon_slug)
        )
        
        var allSessions: [SessionEntity] = []
        
        for (date, sessions) in response.data {
            let sessionEntities = sessions.map { dto in
                SessionMapper.dtoToEntity(dto, date: date, isDroidcon: true)
            }
            allSessions.append(contentsOf: sessionEntities)
        }
        
        return allSessions
    }

    func fetchLocalSessions() -> [SessionEntity] {
        let sessions = sessionDm.fetchSessions()
        return sessions.sorted {
            // Sort by date first, then by start time
            if $0.date == $1.date {
                return $0.startTime < $1.startTime
            }
            return $0.date < $1.date
        }
    }
    
    func saveSessions(_ sessions: [SessionEntity]) {
        sessionDm.saveSessions(sessions)
    }
    
    func clearAllSessions() {
        sessionDm.deleteAllSessions()
    }
    
}
