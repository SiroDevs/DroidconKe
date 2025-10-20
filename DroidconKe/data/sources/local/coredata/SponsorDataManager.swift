//
//  FeedMappers.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import CoreData

class SponsorDataManager {
    private let cdManager: CoreDataManager
    
    init(cdManager: CoreDataManager = .shared) {
        self.cdManager = cdManager
    }
    
    private var context: NSManagedObjectContext {
        cdManager.viewContext
    }
    
    func saveSponsors(_ sponsors: [SponsorEntity]) {
        context.perform {
            do {
                for entity in sponsors {
                    let cd = self.findOrCreateCd(by: entity.id)
                    SponsorMapper.entityToCd(entity, cd)
                }
                try self.context.save()
                print("✅ Sponsors saved successfully")
            } catch {
                print("❌ Failed to save sponsors: \(error)")
            }
        }
    }
    
    func saveSponsor(_ entity: SponsorEntity) {
        context.perform {
            do {
                let cd = self.findOrCreateCd(by: entity.id)
                SponsorMapper.entityToCd(entity, cd)
                try self.context.save()
            } catch {
                print("❌ Failed to save entity: \(error)")
            }
        }
    }
    
    func fetchSponsors() -> [SponsorEntity] {
        let request: NSFetchRequest<CDSponsor> = CDSponsor.fetchRequest()
        do {
            return try context.fetch(request).map(SponsorMapper.cdToEntity(_:))
        } catch {
            print("❌ Failed to fetch sponsors: \(error)")
            return []
        }
    }
    
    func fetchSponsor(withId id: Int) -> SponsorEntity? {
        fetchCd(by: id).map(SponsorMapper.cdToEntity(_:))
    }

    private func fetchCd(by id: Int) -> CDSponsor? {
        let request: NSFetchRequest<CDSponsor> = CDSponsor.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        request.fetchLimit = 1
        return try? context.fetch(request).first
    }

    private func findOrCreateCd(by id: Int) -> CDSponsor {
        if let existing = fetchCd(by: id) {
            return existing
        } else {
            let new = CDSponsor(context: context)
            new.id = Int32(id)
            return new
        }
    }
    
    func deleteAllSponsors() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDSponsor.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
            try context.save()
            print("🗑️ All sponsors deleted successfully")
        } catch {
            print("❌ Failed to delete sponsors: \(error)")
        }
    }

}
