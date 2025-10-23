//
//  OrganizerMapper.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

struct OrganizerMapper {
    static func cdToEntity(_ cd: CDOrganizer) -> OrganizerEntity {
        OrganizerEntity(
            name: cd.name ?? "",
            email: cd.email ?? "",
            description: cd.descriptionTxt ?? "",
            twitter: cd.twitter ?? "",
            logo: cd.logo ?? "",
            slug: cd.slug ?? "",
            status: cd.status ?? "",
            createdAt: cd.createdAt ?? "",
            upcomingEventsCount: Int(cd.upcomingEventsCount),
            totalEventsCount: Int(cd.totalEventsCount)
        )
    }
    
    static func entityToCd(_ entity: OrganizerEntity, _ cd: CDOrganizer) {
        cd.id = Int32(entity.id)
        cd.name = entity.name ?? ""
        cd.email = entity.email ?? ""
        cd.descriptionTxt = entity.description ?? ""
        cd.twitter = entity.twitter ?? ""
        cd.logo = entity.logo ?? ""
        cd.slug = entity.slug ?? ""
        cd.status = entity.status ?? ""
        cd.createdAt = entity.createdAt ?? ""
        cd.upcomingEventsCount = Int32(entity.upcomingEventsCount)
        cd.totalEventsCount = Int32(entity.totalEventsCount)
    }
    
    static func dtoToEntity(_ dto: OrganizerDTO) -> OrganizerEntity {
        OrganizerEntity(
            name: dto.name ?? "",
            email: dto.email ?? "",
            description: dto.description ?? "",
            twitter: dto.twitter ?? "",
            logo: dto.logo ?? "",
            slug: dto.slug ?? "",
            status: dto.status ?? "",
            createdAt: dto.createdAt ?? "",
            upcomingEventsCount: dto.upcomingEventsCount,
            totalEventsCount: dto.totalEventsCount
        )
    }
    
    static func entityToDto(_ entity: OrganizerEntity) -> OrganizerDTO {
        OrganizerDTO(
            id: entity.id,
            name: entity.name ?? "",
            email: entity.email ?? "",
            description: entity.description ?? "",
            twitter: entity.twitter ?? "",
            logo: entity.logo ?? "",
            slug: entity.slug ?? "",
            status: entity.status ?? "",
            createdAt: entity.createdAt ?? "",
            upcomingEventsCount: entity.upcomingEventsCount,
            totalEventsCount: entity.totalEventsCount
        )
    }
}
