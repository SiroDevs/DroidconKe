//
//  FeedMapper.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

struct FeedMapper {
    static func toEntity(_ cd: CDFeed) -> FeedEntity {
        FeedEntity(
            id: Int(cd.id),
            title: cd.title ?? "",
            body: cd.body ?? "",
            topic: cd.topic ?? "",
            url: cd.url ?? "",
            image: cd.image ?? "",
            createdAt: cd.createdAt ?? ""
        )
    }
}
