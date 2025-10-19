//
//  SessionMapper.swift
//  DroremoteIdconKe
//
//  Created by @sirodevs on 20/10/2025.
//

struct SessionMapper {
    static func cdToEntity(_ cd: CDSession) -> SessionEntity {
        SessionEntity(
            remoteId: cd.remoteId,
            sessionDescription: cd.sessionDescription ?? "",
            sessionFormat: cd.sessionFormat ?? "",
            sessionLevel: cd.sessionLevel ?? "",
            slug: cd.slug ?? "",
            title: cd.title ?? "",
            endDateTime: cd.endDateTime ?? "",
            endTime: cd.endTime ?? "",
            isBookmarked: cd.isBookmarked,
            isKeynote: cd.isKeynote,
            isServiceSession: cd.isServiceSession,
            sessionImage: cd.sessionImage ?? "",
            rooms: cd.rooms ?? "",
            speakers: cd.speakers ?? "",
            startTimestamp: cd.startTimestamp,
            sessionImageUrl: cd.sessionImageUrl ?? "",
        )
    }
    
    static func entityToCd(_ entity: SessionEntity, _ cd: CDSession) {
        cd.remoteId = entity.remoteId
        cd.sessionDescription = entity.sessionDescription ?? ""
        cd.sessionFormat = entity.sessionFormat ?? ""
        cd.sessionLevel = entity.sessionLevel ?? ""
        cd.sessionLevel = entity.sessionLevel ?? ""
        cd.slug = entity.slug ?? ""
        cd.title = entity.title ?? ""
        cd.endDateTime = entity.endDateTime ?? ""
        cd.endTime = entity.endTime ?? ""
        cd.isBookmarked = entity.isBookmarked
        cd.isKeynote = entity.isKeynote
        cd.isServiceSession = entity.isServiceSession
        cd.sessionImage = entity.sessionImage ?? ""
        cd.startDateTime = entity.startDateTime ?? ""
        cd.rooms = entity.rooms ?? ""
        cd.speakers = entity.speakers ?? ""
        cd.startTimestamp = entity.startTimestamp ?? ""
        cd.sessionImageUrl = entity.sessionImageUrl ?? ""
    }
    
    static func dtoToEntity(_ dto: SessionDTO) -> SessionEntity {
        SessionEntity(
            remoteId: dto.remoteId,
            sessionDescription: dto.sessionDescription ?? "",
            sessionFormat: dto.sessionFormat ?? "",
            sessionLevel: dto.sessionLevel ?? "",
            slug: dto.slug ?? "",
            title: dto.title ?? "",
            endDateTime: dto.endDateTime ?? "",
            endTime: dto.endTime ?? "",
            isBookmarked: dto.isBookmarked,
            isKeynote: dto.isKeynote,
            isServiceSession: dto.isServiceSession,
            sessionImage: dto.sessionImage ?? "",
            startDateTime: dto.startDateTime ?? "",
            rooms: dto.rooms ?? "",
            speakers: dto.speakers ?? "",
            startTimestamp: dto.startTimestamp ?? "",
            sessionImageUrl: dto.sessionImageUrl ?? "",
        )
    }
    
    static func entityToDto(_ entity: SessionEntity) -> SessionDTO {
        SessionDTO(
            remoteId: entity.remoteId ?? "",
            sessionDescription: entity.sessionDescription ?? "",
            sessionFormat: entity.sessionFormat ?? "",
            sessionLevel: entity.sessionLevel ?? "",
            slug: entity.slug ?? "",
            title: entity.title ?? "",
            endDateTime: entity.endDateTime ?? "",
            endTime: entity.endTime ?? "",
            isBookmarked: entity.isBookmarked,
            isKeynote: entity.isKeynote,
            isServiceSession: entity.isServiceSession,
            sessionImage: entity.sessionImage ?? "",
            startDateTime: entity.startDateTime ?? "",
            startTime: entity.startTime ?? "",
            rooms: entity.rooms ?? "",
            speakers: entity.speakers ?? "",
            startTimestamp: entity.startTimestamp ?? "",
            sessionImageUrl: entity.sessionImageUrl ?? ""
        )
    }
}
