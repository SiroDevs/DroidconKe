//
//  BookmarkRepo.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import Foundation

protocol BookmarkRepoProtocol {
    func fetchBookmarks() -> [BookmarkEntity]
    func saveBookmark(_ entity: BookmarkEntity)
    func deleteBookmark(withId id: Int)
    func deleteBookmarks()
}

class BookmarkRepo: BookmarkRepoProtocol {
    private let bookmarkDm: BookmarkDataManager
    
    init(bookmarkDm: BookmarkDataManager) {
        self.bookmarkDm = bookmarkDm
    }
    
    func fetchBookmarks() -> [BookmarkEntity] {
        let bookmarks = bookmarkDm.fetchBookmarks()
        return bookmarks.sorted { $1.id < $0.id }
    }
    
    func saveBookmark(_ entity: BookmarkEntity) {
        bookmarkDm.saveBookmark(entity)
    }
    
    func deleteBookmark(withId id: Int) {
        bookmarkDm.deleteBookmark(withId: id)
    }
    
    func deleteBookmarks() {
        bookmarkDm.deleteAllBookmarks()
    }
}
