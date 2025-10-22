//
//  SpeakerMapper.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

struct SpeakerMapper {
    static func cdToEntity(_ cd: CDSpeaker) -> SpeakerEntity {
        SpeakerEntity(
            name: cd.name ?? "",
            tagline: cd.tagline ?? "",
            biography: cd.biography ?? "",
            avatar: cd.avatar ?? "",
            twitter: cd.twitter,
            linkedin: cd.linkedin,
            blog: cd.blog,
            companyWebsite: cd.companyWebsite,
            isDroidcon: cd.isDroidcon
        )
    }
    
    static func entityToCd(_ entity: SpeakerEntity, _ cd: CDSpeaker) {
        cd.name = entity.name
        cd.tagline = entity.tagline
        cd.biography = entity.biography
        cd.avatar = entity.avatar
        cd.twitter = entity.twitter
        cd.linkedin = entity.linkedin
        cd.blog = entity.blog
        cd.companyWebsite = entity.companyWebsite
        cd.isDroidcon = entity.isDroidcon
    }
    
    static func dtoToEntity(_ dto: SpeakerDTO, isDroidcon: Bool = true) -> SpeakerEntity {
        SpeakerEntity(
            name: dto.name,
            tagline: dto.tagline,
            biography: dto.biography,
            avatar: dto.avatar,
            twitter: dto.twitter,
            linkedin: dto.linkedin,
            blog: dto.blog,
            companyWebsite: dto.companyWebsite,
            isDroidcon: isDroidcon
        )
    }
    
    static func entityToDto(_ entity: SpeakerEntity) -> SpeakerDTO {
        SpeakerDTO(
            name: entity.name,
            tagline: entity.tagline,
            biography: entity.biography,
            avatar: entity.avatar,
            twitter: entity.twitter,
            linkedin: entity.twitter,
            blog: entity.twitter,
            companyWebsite: entity.twitter
        )
    }
}
