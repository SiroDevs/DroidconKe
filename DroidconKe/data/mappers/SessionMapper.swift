//
//  SessionMapper.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import Foundation
import CoreData

struct SessionMapper {
    static func cdToEntity(_ cd: CDSession) -> SessionEntity {
        let speakers = (cd.speakers?.allObjects as? [CDSpeaker] ?? []).map { cdSpeaker in
            SpeakerMapper.cdToEntity(cdSpeaker)
        }
        
        let rooms = (cd.rooms?.allObjects as? [CDRoom] ?? []).map { cdRoom in
            RoomEntity(
                id: Int(cdRoom.id),
                title: cdRoom.title ?? ""
            )
        }
        
        return SessionEntity(
            id: Int(cd.id),
            title: cd.title ?? "",
            description: cd.descriptionTxt ?? "",
            slug: cd.slug ?? "",
            sessionFormat: cd.sessionFormat ?? "",
            sessionLevel: cd.sessionLevel ?? "",
            sessionCategory: cd.sessionCategory ?? "",
            sessionImage: cd.sessionImage,
            backgroundColor: cd.backgroundColor,
            borderColor: cd.borderColor,
            isServiceSession: cd.isServiceSession,
            isKeynote: cd.isKeynote,
            isBookmarked: cd.isBookmarked,
            startDateTime: cd.startDateTime ?? "",
            startTime: cd.startTime ?? "",
            endDateTime: cd.endDateTime ?? "",
            endTime: cd.endTime ?? "",
            speakers: speakers,
            rooms: rooms,
            isDroidcon: cd.isDroidcon,
            date: cd.date ?? ""
        )
    }
    
    static func entityToCd(_ entity: SessionEntity, _ cd: CDSession, context: NSManagedObjectContext) {
        cd.id = Int32(entity.id)
        cd.title = entity.title
        cd.descriptionTxt = entity.description
        cd.slug = entity.slug
        cd.sessionFormat = entity.sessionFormat
        cd.sessionLevel = entity.sessionLevel
        cd.sessionCategory = entity.sessionCategory
        cd.sessionImage = entity.sessionImage
        cd.backgroundColor = entity.backgroundColor
        cd.borderColor = entity.borderColor
        cd.isServiceSession = entity.isServiceSession
        cd.isKeynote = entity.isKeynote
        cd.isBookmarked = entity.isBookmarked
        cd.startDateTime = entity.startDateTime
        cd.startTime = entity.startTime
        cd.endDateTime = entity.endDateTime
        cd.endTime = entity.endTime
        cd.isDroidcon = entity.isDroidcon
        cd.date = entity.date
        
        if let existingSpeakers = cd.speakers {
            cd.removeFromSpeakers(existingSpeakers)
        }
        if let existingRooms = cd.rooms {
            cd.removeFromRooms(existingRooms)
        }
        
        for speaker in entity.speakers {
            let cdSpeaker = CDSpeaker(context: context)
            SpeakerMapper.entityToCd(speaker, cdSpeaker)
            cd.addToSpeakers(cdSpeaker)
        }
        
        for room in entity.rooms {
            let cdRoom = CDRoom(context: context)
            cdRoom.id = Int32(room.id)
            cdRoom.title = room.title
            cd.addToRooms(cdRoom)
        }
    }
    
    static func dtoToEntity(_ dto: SessionDTO, date: String, isDroidcon: Bool = true) -> SessionEntity {
        let speakerEntities = dto.speakers.map { speakerDTO in
            SpeakerMapper.dtoToEntity(speakerDTO, session: dto.title, isDroidcon: isDroidcon)
        }
        
        let roomEntities = dto.rooms.map { roomDTO in
            RoomEntity(id: roomDTO.id, title: roomDTO.title)
        }
        
        return SessionEntity(
            id: dto.id,
            title: dto.title,
            description: dto.description,
            slug: dto.slug,
            sessionFormat: dto.sessionFormat,
            sessionLevel: dto.sessionLevel,
            sessionCategory: dto.sessionCategory,
            sessionImage: dto.sessionImage,
            backgroundColor: dto.backgroundColor,
            borderColor: dto.borderColor,
            isServiceSession: dto.isServiceSession,
            isKeynote: dto.isKeynote,
            isBookmarked: dto.isBookmarked,
            startDateTime: dto.startDateTime,
            startTime: dto.startTime,
            endDateTime: dto.endDateTime,
            endTime: dto.endTime,
            speakers: speakerEntities,
            rooms: roomEntities,
            isDroidcon: isDroidcon,
            date: date
        )
    }
    
    static func entityToDto(_ entity: SessionEntity) -> SessionDTO {
        let speakerDTOs = entity.speakers.map { speakerEntity in
            SpeakerMapper.entityToDto(speakerEntity)
        }
        
        let roomDTOs = entity.rooms.map { roomEntity in
            RoomDTO(title: roomEntity.title, id: roomEntity.id)
        }
        
        return SessionDTO(
            id: entity.id,
            title: entity.title,
            description: entity.description,
            slug: entity.slug,
            sessionFormat: entity.sessionFormat,
            sessionLevel: entity.sessionLevel,
            sessionCategory: entity.sessionCategory,
            sessionImage: entity.sessionImage,
            backgroundColor: entity.backgroundColor,
            borderColor: entity.borderColor,
            isServiceSession: entity.isServiceSession,
            isKeynote: entity.isKeynote,
            isBookmarked: entity.isBookmarked,
            startDateTime: entity.startDateTime,
            startTime: entity.startTime,
            endDateTime: entity.endDateTime,
            endTime: entity.endTime,
            speakers: speakerDTOs,
            rooms: roomDTOs
        )
    }
}
