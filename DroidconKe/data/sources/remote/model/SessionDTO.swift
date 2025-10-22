//
//  SessionDTO.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import Foundation

struct SessionDTO: Codable {
    let id: Int
    let title: String
    let description: String
    let slug: String
    let sessionFormat: String
    let sessionLevel: String
    let sessionCategory: String
    let sessionImage: String?
    let backgroundColor: String?
    let borderColor: String?
    let isServiceSession: Bool
    let isKeynote: Bool
    let isBookmarked: Bool
    let startDateTime: String
    let startTime: String
    let endDateTime: String
    let endTime: String
    let speakers: [SpeakerDTO]
    let rooms: [RoomDTO]
    
    private enum CodingKeys: String, CodingKey {
        case id, title, description, slug
        case sessionFormat = "session_format"
        case sessionLevel = "session_level"
        case sessionCategory = "session_category"
        case sessionImage = "session_image"
        case backgroundColor, borderColor
        case isServiceSession = "is_serviceSession"
        case isKeynote = "is_keynote"
        case isBookmarked = "is_bookmarked"
        case startDateTime = "start_date_time"
        case startTime = "start_time"
        case endDateTime = "end_date_time"
        case endTime = "end_time"
        case speakers, rooms
    }
}

struct SessionsRespDTO: Codable {
    let data: [String: [SessionDTO]]
    
    var allSessions: [SessionDTO] {
        data.values.flatMap { $0 }
    }
    
    func sessions(for date: String) -> [SessionDTO] {
        data[date] ?? []
    }
    
    // Helper to get all dates
    var allDates: [String] {
        data.keys.sorted()
    }
}
