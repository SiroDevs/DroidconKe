//
//  FeedMapper.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

struct FeedMapper {
    static func cdToEntity(_ cd: CDFeed) -> FeedEntity {
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
    
    static func entityToCd(_ entity: FeedEntity, _ cd: CDFeed) {
        cd.id = Int32(entity.id)
        cd.title = entity.title ?? ""
        cd.body = entity.body ?? ""
        cd.topic = entity.topic ?? ""
        cd.topic = entity.topic ?? ""
        cd.image = entity.image ?? ""
        cd.createdAt = entity.createdAt
    }
    
    static func dtoToEntity(_ dto: FeedDTO) -> FeedEntity {
        FeedEntity(
//            id: Int(dto.id),
            title: dto.title ?? "",
            body: dto.body ?? "",
            topic: dto.topic ?? "",
            url: dto.url ?? "",
            image: dto.image ?? "",
            createdAt: dto.createdAt
        )
    }
    
    static func entityToDto(_ entity: FeedEntity) -> FeedDTO {
        FeedDTO(
            title: entity.title ?? "",
            body: entity.body ?? "",
            topic: entity.topic ?? "",
            url: entity.url ?? "",
            image: entity.image ?? "",
            createdAt: entity.createdAt
        )
    }
}
