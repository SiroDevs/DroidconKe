//
//  DependencyMap.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import Swinject

struct DependencyMap {
    static func registerDependencies(in container: Container) {
        container.register(PrefsRepo.self) { _ in PrefsRepo() }.inObjectScope(.container)

        container.register(ApiServiceProtocol.self) { _ in ApiService() }.inObjectScope(.container)

        container.register(AnalyticsServiceProtocol.self) { _ in AnalyticsService() }.inObjectScope(.container)

        container.register(LoggerProtocol.self) { _ in Logger() }.inObjectScope(.container)
        
        container.register(NetworkUtils.self) { _ in NetworkUtils.shared}.inObjectScope(.container)
        
        container.register(CoreDataManager.self) { _ in CoreDataManager.shared}.inObjectScope(.container)
        
        container.register(BookmarkDataManager.self) { resolver in
            BookmarkDataManager(cdManager: resolver.resolve(CoreDataManager.self)!)
        }.inObjectScope(.container)
        
        container.register(FeedDataManager.self) { resolver in
            FeedDataManager(cdManager: resolver.resolve(CoreDataManager.self)!)
        }.inObjectScope(.container)
        
        container.register(OrganizerDataManager.self) { resolver in
            OrganizerDataManager(cdManager: resolver.resolve(CoreDataManager.self)!)
        }.inObjectScope(.container)
        
        container.register(SessionDataManager.self) { resolver in
            SessionDataManager(cdManager: resolver.resolve(CoreDataManager.self)!)
        }.inObjectScope(.container)
        
        container.register(SpeakerDataManager.self) { resolver in
            SpeakerDataManager(cdManager: resolver.resolve(CoreDataManager.self)!)
        }.inObjectScope(.container)
        
        container.register(SponsorDataManager.self) { resolver in
            SponsorDataManager(cdManager: resolver.resolve(CoreDataManager.self)!)
        }.inObjectScope(.container)
        
        container.register(BookmarkRepoProtocol.self) { resolver in
            BookmarkRepo(
                bookmarkDm: resolver.resolve(BookmarkDataManager.self)!,
            )
        }.inObjectScope(.container)
        
        container.register(FeedRepoProtocol.self) { resolver in
            FeedRepo(
                apiService: resolver.resolve(ApiServiceProtocol.self)!,
                feedDm: resolver.resolve(FeedDataManager.self)!,
            )
        }.inObjectScope(.container)
        
        container.register(OrganizerRepoProtocol.self) { resolver in
            OrganizerRepo(
                apiService: resolver.resolve(ApiServiceProtocol.self)!,
                organizerDm: resolver.resolve(OrganizerDataManager.self)!,
            )
        }.inObjectScope(.container)
        
        container.register(PrefsRepoProtocol.self) { resolver in PrefsRepo() }.inObjectScope(.container)
        
        container.register(SessionRepoProtocol.self) { resolver in
            SessionRepo(
                apiService: resolver.resolve(ApiServiceProtocol.self)!,
                sessionDm: resolver.resolve(SessionDataManager.self)!,
            )
        }.inObjectScope(.container)
        
        container.register(SpeakerRepoProtocol.self) { resolver in
            SpeakerRepo(
                apiService: resolver.resolve(ApiServiceProtocol.self)!,
                speakerDm: resolver.resolve(SpeakerDataManager.self)!,
            )
        }.inObjectScope(.container)
        
        container.register(SponsorRepoProtocol.self) { resolver in
            SponsorRepo(
                apiService: resolver.resolve(ApiServiceProtocol.self)!,
                sponsorDm: resolver.resolve(SponsorDataManager.self)!,
            )
        }.inObjectScope(.container)

        container.register(MainViewModel.self) { resolver in
            MainViewModel(
                feedRepo: resolver.resolve(FeedRepoProtocol.self)!,
                organizerRepo: resolver.resolve(OrganizerRepoProtocol.self)!,
                sessionRepo: resolver.resolve(SessionRepoProtocol.self)!,
                speakerRepo: resolver.resolve(SpeakerRepoProtocol.self)!,
            )
        }.inObjectScope(.container)

    }
}

