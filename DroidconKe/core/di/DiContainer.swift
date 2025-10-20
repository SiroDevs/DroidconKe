//
//  DiContainer.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import Swinject

final class DiContainer {
    static let shared = DiContainer()
    let container: Container

    private init() {
        container = Container()
        DependencyMap.registerDependencies(in: container)
        validateDependencies()
    }

    private func validateDependencies() {
        let dependencies: [() -> Any?] = [
            { self.container.resolve(AnalyticsServiceProtocol.self) },
            { self.container.resolve(LoggerProtocol.self) },
            { self.container.resolve(ApiServiceProtocol.self) },
            { self.container.resolve(NetworkUtils.self) },
            { self.container.resolve(CoreDataManager.self) },
            { self.container.resolve(BookmarkDataManager.self) },
            { self.container.resolve(FeedDataManager.self) },
            { self.container.resolve(OrganizerDataManager.self) },
            { self.container.resolve(SessionDataManager.self) },
            { self.container.resolve(SpeakerDataManager.self) },
            { self.container.resolve(SponsorDataManager.self) },
            { self.container.resolve(BookmarkRepo.self) },
            { self.container.resolve(OrganizerRepo.self) },
            { self.container.resolve(PrefsRepo.self) },
            { self.container.resolve(SessionRepo.self) },
            { self.container.resolve(SpeakerRepo.self) },
            { self.container.resolve(SponsorRepo.self) },
//            { self.container.resolve(MainViewModel.self) },
        ]

        for resolve in dependencies {
            guard resolve() != nil else {
                fatalError("One or more dependencies are not registered in the container.")
            }
        }
        print("All dependencies are successfully registered.")
    }
}

extension DiContainer {
    func resolve<T>(_ type: T.Type) -> T {
        guard let dependency = container.resolve(type) else {
            fatalError("Failed to resolve dependency: \(type)")
        }
        return dependency
    }

    func resolve<T, Arg>(_ type: T.Type, argument: Arg) -> T {
        guard let dependency = container.resolve(type, argument: argument) else {
            fatalError("Failed to resolve dependency: \(type) with argument: \(argument)")
        }
        return dependency
    }
}
