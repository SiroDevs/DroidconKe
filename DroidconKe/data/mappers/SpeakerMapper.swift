//
//  SpeakerMapper.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

struct SpeakerMapper {
    static func cdToEntity(_ cd: CDSpeaker) -> SpeakerEntity {
        SpeakerEntity(
//            id: Int(cd.id),
            name: cd.name ?? "",
            tagline: cd.tagline ?? "",
            bio: cd.bio ?? "",
            avatar: cd.avatar ?? "",
            twitter: cd.twitter ?? ""
        )
    }
    
    static func entityToCd(_ entity: SpeakerEntity, _ cd: CDSpeaker) {
//        cd.id = Int32(entity.id)
        cd.name = entity.name ?? ""
        cd.tagline = entity.tagline ?? ""
        cd.tagline = entity.tagline ?? ""
        cd.avatar = entity.avatar ?? ""
        cd.twitter = entity.twitter
    }
    
    static func dtoToEntity(_ dto: SpeakerDTO) -> SpeakerEntity {
        SpeakerEntity(
            name: dto.name ?? "",
            tagline: dto.tagline ?? "",
            bio: dto.bio ?? "",
            avatar: dto.avatar ?? "",
            twitter: dto.twitter
        )
    }
    
    static func entityToDto(_ entity: SpeakerEntity) -> SpeakerDTO {
        SpeakerDTO(            name: entity.name ?? "",
            tagline: entity.tagline ?? "",
            bio: entity.bio ?? "",
            avatar: entity.avatar ?? "",
            twitter: entity.twitter
        )
    }
}
