//
//  BookmarkDataManager.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import CoreData

class BookmarkDataManager {
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    
    // Access to the view context
    private var context: NSManagedObjectContext {
        return coreDataManager.viewContext
    }
    
    // Save records to Core Data
    func saveBookmark(_ bookmark: BookmarkEntity) {
        context.perform {
            do {
                let fetchRequest: NSFetchRequest<CDBookmark> = CDBookmark.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %d", bookmark.id)
                fetchRequest.fetchLimit = 1

                let existingRecords = try self.context.fetch(fetchRequest)
                let cdBookmark: CDBookmark

                if let existingRecord = existingRecords.first {
                    cdBookmark = existingRecord
                } else {
                    cdBookmark = CDBookmark(context: self.context)
                }

                // Safely set values
                cdBookmark.id = Int32(bookmark.id)
                cdBookmark.sessionId = bookmark.sessionId

                try self.context.save()
            } catch {
                print("Failed to save bookmarks: \(error)")
            }
        }
    }
    
    // Fetch all bookmarks for a specific item
    func fetchBookmarks() -> [BookmarkEntity] {
        let fetchRequest: NSFetchRequest<CDBookmark> = CDBookmark.fetchRequest()
        do {
            let cdBookmarks = try context.fetch(fetchRequest)
            return cdBookmarks.map { cdBookmark in
                return BookmarkEntity(
                    id: Int(cdBookmark.id),
                    sessionId: cdBookmark.sessionId,
                )
            }
        } catch {
            print("Failed to fetch bookmarks: \(error)")
            return []
        }
    }
    
    // Fetch a single record by ID
    func fetchBookmark(withId id: Int) -> BookmarkEntity? {
        let fetchRequest: NSFetchRequest<CDBookmark> = CDBookmark.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        fetchRequest.fetchLimit = 1
        
        do {
            let results = try context.fetch(fetchRequest)
            guard let cdBookmark = results.first else { return nil }
            
            return BookmarkEntity(
                id: Int(cdBookmark.id),
                sessionId: cdBookmark.sessionId,
            )
        } catch {
            print("Failed to fetch bookmark: \(error)")
            return nil
        }
    }
    
    func deleteBookmark(withId id: Int) {
        let fetchRequest: NSFetchRequest<CDBookmark> = CDBookmark.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let bookmarkToDelete = results.first {
                context.delete(bookmarkToDelete)
                try context.save()
            }
        } catch {
            print("Failed to delete bookmark: \(error)")
        }
    }
    
    func deleteAllBookmarks() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDBookmark.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
            try context.save()
            print("🗑️ All bookmarks deleted successfully")
        } catch {
            print("❌ Failed to delete bookmark: \(error)")
        }
    }

}
