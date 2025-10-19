//
//  OrganizerMapper.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

struct OrganizerMapper {
    static func cdToEntity(_ cd: CDOrganizer) -> OrganizerEntity {
        OrganizerEntity(
            id: Int(cd.id),
            name: cd.name ?? "",
            tagline: cd.tagline ?? "",
            link: cd.link ?? "",
            type: cd.type ?? "",
            photo: cd.photo ?? "",
            bio: cd.bio ?? "",
            twitterHandle: cd.twitterHandle ?? "",
            designation: cd.designation ?? "",
            createdAt: cd.createdAt ?? ""
        )
    }
    
    static func entityToCd(_ entity: OrganizerEntity, _ cd: CDOrganizer) {
        cd.id = Int32(entity.id)
        cd.name = entity.name ?? ""
        cd.tagline = entity.tagline ?? ""
        cd.link = entity.link ?? ""
        cd.link = entity.link ?? ""
        cd.photo = entity.photo ?? ""
        cd.bio = entity.bio ?? ""
        cd.twitterHandle = entity.twitterHandle ?? ""
        cd.designation = entity.designation ?? ""
        cd.createdAt = entity.createdAt
    }
    
    static func dtoToEntity(_ dto: OrganizerDTO) -> OrganizerEntity {
        OrganizerEntity(
//            id: Int(dto.id),
            name: dto.name ?? "",
            tagline: dto.tagline ?? "",
            link: dto.link ?? "",
            type: dto.type ?? "",
            photo: dto.photo ?? "",
            bio: dto.bio ?? "",
            twitterHandle: dto.twitterHandle ?? "",
            designation: dto.designation ?? "",
            createdAt: dto.createdAt
        )
    }
    
    static func entityToDto(_ entity: OrganizerEntity) -> OrganizerDTO {
        OrganizerDTO(
            name: entity.name ?? "",
            tagline: entity.tagline ?? "",
            link: entity.link ?? "",
            type: entity.type ?? "",
            photo: entity.photo ?? "",
            bio: entity.bio ?? "",
            twitterHandle: entity.twitterHandle ?? "",
            designation: entity.designation ?? "",
            createdAt: entity.createdAt
        )
    }
}
