//
//  FeedRepo.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

protocol FeedRepoProtocol {
    func fetchRemoteData() async throws -> [FeedEntity]
    func fetchLocalData() async throws -> [FeedEntity]
    func saveData(_ feeds: [FeedEntity])
    func clearAllData()
}

class FeedRepo: FeedRepoProtocol {
    private let apiService: ApiServiceProtocol
    private let feedDm: FeedDataManager
    
    init(
        apiService: ApiServiceProtocol,
        feedDm: FeedDataManager,
    ) {
        self.apiService = apiService
        self.feedDm = feedDm
    }
    
    func fetchRemoteData() async throws -> [FeedEntity] {
        return try await apiService.fetch(endpoint: .feeds(eventSlug: "", page: 1, perPage: 100))
    }
    
    func fetchLocalData() -> [FeedEntity] {
        let feeds = feedDm.fetchFeeds()
        return feeds.sorted { $0.id < $1.id }
    }
    
    func saveData(_ feeds: [FeedEntity]) {
        feedDm.saveFeeds(feeds)
    }
    
    func clearAllData() {
        feedDm.deleteAllFeeds()
    }
}
 
