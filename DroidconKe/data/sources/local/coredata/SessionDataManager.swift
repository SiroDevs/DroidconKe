//
//  SessionDataManager.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import CoreData

class SessionDataManager {
    private let cdManager: CoreDataManager
    
    init(cdManager: CoreDataManager = .shared) {
        self.cdManager = cdManager
    }
    
    private var context: NSManagedObjectContext {
        cdManager.viewContext
    }
    
    func saveSessions(_ sessions: [SessionEntity]) {
        context.perform {
            do {
                for entity in sessions {
                    let cd = self.findOrCreateCd(by: entity.remoteId!)
                    SessionMapper.entityToCd(entity, cd)
                }
                try self.context.save()
                print("✅ Sessions saved successfully")
            } catch {
                print("❌ Failed to save sessions: \(error)")
            }
        }
    }
    
    func saveSession(_ entity: SessionEntity) {
        context.perform {
            do {
                let cd = self.findOrCreateCd(by: entity.remoteId!)
                SessionMapper.entityToCd(entity, cd)
                try self.context.save()
            } catch {
                print("❌ Failed to save entity: \(error)")
            }
        }
    }
    
    func fetchSessions() -> [SessionEntity] {
        let request: NSFetchRequest<CDSession> = CDSession.fetchRequest()
        do {
            return try context.fetch(request).map(SessionMapper.cdToEntity(_:))
        } catch {
            print("❌ Failed to fetch sessions: \(error)")
            return []
        }
    }
    
    func fetchSession(withId remoteId: String) -> SessionEntity? {
        fetchCd(by: remoteId).map(SessionMapper.cdToEntity(_:))
    }

    private func fetchCd(by remoteId: String) -> CDSession? {
        let request: NSFetchRequest<CDSession> = CDSession.fetchRequest()
        request.predicate = NSPredicate(format: "remoteId == %d", remoteId)
        request.fetchLimit = 1
        return try? context.fetch(request).first
    }

    private func findOrCreateCd(by remoteId: String) -> CDSession {
        if let existing = fetchCd(by: remoteId) {
            return existing
        } else {
            let new = CDSession(context: context)
            new.remoteId = remoteId
            return new
        }
    }
    
    func deleteAllSessions() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDSession.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
            try context.save()
            print("🗑️ All sessions deleted successfully")
        } catch {
            print("❌ Failed to delete sessions: \(error)")
        }
    }

}
