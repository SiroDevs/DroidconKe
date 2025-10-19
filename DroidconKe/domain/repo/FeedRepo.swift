//
//  FeedRepo.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

protocol FeedRepoProtocol {
    func fetchRemoteData() async throws -> [FeedEntity]
    func fetchLocalData() async throws -> [FeedEntity]
    func saveFeeds(_ feeds: [FeedEntity])
    func deleteLocalData()
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
        return try await apiService.fetch(endpoint: .feeds(page: 1, perPage: 100))
    }
    
    func fetchLocalData() -> [FeedEntity] {
        let feeds = feedDm.fetchFeeds()
        return feeds.sorted { $0.id < $1.id }
    }
    
    func saveFeeds(_ feeds: [FeedEntity]) {
        feedDm.saveFeeds(feeds)
    }
    
    func deleteLocalData() {
        feedDm.deleteAllFeeds()
    }
}
