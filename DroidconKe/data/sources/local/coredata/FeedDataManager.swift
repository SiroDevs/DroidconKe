//
//  FeedDataManager.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import CoreData

class FeedDataManager {
    private let cdManager: CoreDataManager
    
    init(cdManager: CoreDataManager = .shared) {
        self.cdManager = cdManager
    }
    
    private var context: NSManagedObjectContext {
        cdManager.viewContext
    }
    
    func saveFeeds(_ feeds: [FeedEntity]) {
        context.perform {
            do {
                for entity in feeds {
                    let cd = self.findOrCreateCd(by: entity.id)
                    FeedMapper.entityToCd(entity, cd)
                }
                try self.context.save()
                print("✅ Feeds saved successfully")
            } catch {
                print("❌ Failed to save feeds: \(error)")
            }
        }
    }
    
    func saveFeed(_ entity: FeedEntity) {
        context.perform {
            do {
                let cd = self.findOrCreateCd(by: entity.id)
                FeedMapper.entityToCd(entity, cd)
                try self.context.save()
            } catch {
                print("❌ Failed to save entity: \(error)")
            }
        }
    }
    
    func fetchFeeds() -> [FeedEntity] {
        let request: NSFetchRequest<CDFeed> = CDFeed.fetchRequest()
        do {
            return try context.fetch(request).map(FeedMapper.cdToEntity(_:))
        } catch {
            print("❌ Failed to fetch feeds: \(error)")
            return []
        }
    }
    
    func fetchFeed(withId id: Int) -> FeedEntity? {
        fetchCd(by: id).map(FeedMapper.cdToEntity(_:))
    }

    private func fetchCd(by id: Int) -> CDFeed? {
        let request: NSFetchRequest<CDFeed> = CDFeed.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        request.fetchLimit = 1
        return try? context.fetch(request).first
    }

    private func findOrCreateCd(by id: Int) -> CDFeed {
        if let existing = fetchCd(by: id) {
            return existing
        } else {
            let new = CDFeed(context: context)
            new.id = Int32(id)
            return new
        }
    }
    
    func deleteAllFeeds() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDFeed.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
            try context.save()
            print("🗑️ All feeds deleted successfully")
        } catch {
            print("❌ Failed to delete feeds: \(error)")
        }
    }

}
