//
//  SpeakerDataManager.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import CoreData

class SpeakerDataManager {
    private let cdManager: CoreDataManager
    
    init(cdManager: CoreDataManager = .shared) {
        self.cdManager = cdManager
    }
    
    private var context: NSManagedObjectContext {
        cdManager.viewContext
    }
    
    func saveSpeakers(_ speakers: [SpeakerEntity]) {
        context.perform {
            do {
                for entity in speakers {
                    let cd = self.findOrCreateCd(by: entity.id)
                    SpeakerMapper.entityToCd(entity, cd)
                }
                try self.context.save()
                print("✅ Speakers saved successfully")
            } catch {
                print("❌ Failed to save speakers: \(error)")
            }
        }
    }
    
    func saveSpeaker(_ entity: SpeakerEntity) {
        context.perform {
            do {
                let cd = self.findOrCreateCd(by: entity.id)
                SpeakerMapper.entityToCd(entity, cd)
                try self.context.save()
            } catch {
                print("❌ Failed to save entity: \(error)")
            }
        }
    }
    
    func fetchSpeakers() -> [SpeakerEntity] {
        let request: NSFetchRequest<CDSpeaker> = CDSpeaker.fetchRequest()
        do {
            return try context.fetch(request).map(SpeakerMapper.cdToEntity(_:))
        } catch {
            print("❌ Failed to fetch speakers: \(error)")
            return []
        }
    }
    
    func fetchSpeaker(withId id: Int) -> SpeakerEntity? {
        fetchCd(by: id).map(SpeakerMapper.cdToEntity(_:))
    }

    private func fetchCd(by id: Int) -> CDSpeaker? {
        let request: NSFetchRequest<CDSpeaker> = CDSpeaker.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        request.fetchLimit = 1
        return try? context.fetch(request).first
    }

    private func findOrCreateCd(by id: Int) -> CDSpeaker {
        if let existing = fetchCd(by: id) {
            return existing
        } else {
            let new = CDSpeaker(context: context)
            new.id = Int32(id)
            return new
        }
    }
    
    func deleteAllSpeakers() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDSpeaker.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
            try context.save()
            print("🗑️ All speakers deleted successfully")
        } catch {
            print("❌ Failed to delete speakers: \(error)")
        }
    }

}
