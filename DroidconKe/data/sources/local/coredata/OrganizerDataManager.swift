//
//  OrganizerDataManager.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import CoreData

class OrganizerDataManager {
    private let cdManager: CoreDataManager
    
    init(cdManager: CoreDataManager = .shared) {
        self.cdManager = cdManager
    }
    
    private var context: NSManagedObjectContext {
        cdManager.viewContext
    }
    
    func saveOrganizers(_ organizers: [OrganizerEntity]) {
        context.perform {
            do {
                for entity in organizers {
                    let cd = self.findOrCreateCd(by: entity.id)
                    OrganizerMapper.entityToCd(entity, cd)
                }
                try self.context.save()
                print("✅ Organizers saved successfully")
            } catch {
                print("❌ Failed to save organizers: \(error)")
            }
        }
    }
    
    func saveOrganizer(_ entity: OrganizerEntity) {
        context.perform {
            do {
                let cd = self.findOrCreateCd(by: entity.id)
                OrganizerMapper.entityToCd(entity, cd)
                try self.context.save()
            } catch {
                print("❌ Failed to save entity: \(error)")
            }
        }
    }
    
    func fetchOrganizers() -> [OrganizerEntity] {
        let request: NSFetchRequest<CDOrganizer> = CDOrganizer.fetchRequest()
        do {
            return try context.fetch(request).map(OrganizerMapper.cdToEntity(_:))
        } catch {
            print("❌ Failed to fetch organizers: \(error)")
            return []
        }
    }
    
    func fetchOrganizer(withId id: Int) -> OrganizerEntity? {
        fetchCd(by: id).map(OrganizerMapper.cdToEntity(_:))
    }

    private func fetchCd(by id: Int) -> CDOrganizer? {
        let request: NSFetchRequest<CDOrganizer> = CDOrganizer.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        request.fetchLimit = 1
        return try? context.fetch(request).first
    }

    private func findOrCreateCd(by id: Int) -> CDOrganizer {
        if let existing = fetchCd(by: id) {
            return existing
        } else {
            let new = CDOrganizer(context: context)
            new.id = Int32(id)
            return new
        }
    }
    
    func deleteAllOrganizers() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDOrganizer.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
            try context.save()
            print("🗑️ All organizers deleted successfully")
        } catch {
            print("❌ Failed to delete organizers: \(error)")
        }
    }

}
