//
//  SponsorMapper.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

struct SponsorMapper {
    static func cdToEntity(_ cd: CDSponsor) -> SponsorEntity {
        SponsorEntity(
//            id: Int(cd.id),
            name: cd.name ?? "",
            tagline: cd.tagline ?? "",
            link: cd.link ?? "",
            logo: cd.logo ?? "",
            sponsorType: cd.sponsorType ?? "",
            createdAt: cd.createdAt ?? ""
        )
    }
    
    static func entityToCd(_ entity: SponsorEntity, _ cd: CDSponsor) {
//        cd.id = Int32(entity.id)
        cd.name = entity.name ?? ""
        cd.tagline = entity.tagline ?? ""
        cd.link = entity.link ?? ""
        cd.link = entity.link ?? ""
        cd.sponsorType = entity.sponsorType ?? ""
        cd.createdAt = entity.createdAt
    }
    
    static func dtoToEntity(_ dto: SponsorDTO) -> SponsorEntity {
        SponsorEntity(
//            id: Int(dto.id),
            name: dto.name ?? "",
            tagline: dto.tagline ?? "",
            link: dto.link ?? "",
            logo: dto.logo ?? "",
            sponsorType: dto.sponsorType ?? "",
            createdAt: dto.createdAt
        )
    }
    
    static func entityToDto(_ entity: SponsorEntity) -> SponsorDTO {
        SponsorDTO(
            name: entity.name ?? "",
            tagline: entity.tagline ?? "",
            link: entity.link ?? "",
            logo: entity.logo ?? "",
            sponsorType: entity.sponsorType ?? "",
            createdAt: entity.createdAt
        )
    }
}
