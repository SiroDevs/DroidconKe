//
//  SessionEntity.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import Foundation

struct SessionEntity: Identifiable, Equatable {
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
    let speakers: [SpeakerEntity]
    let rooms: [RoomEntity]
    let isDroidcon: Bool
    let date: String
    
    var duration: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        guard let start = formatter.date(from: startTime),
              let end = formatter.date(from: endTime) else {
            return "N/A"
        }
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: start, to: end)
        
        if let hours = components.hour, let minutes = components.minute {
            if hours > 0 {
                return "\(hours)h \(minutes)m"
            } else {
                return "\(minutes)m"
            }
        }
        return "N/A"
    }
    
    var roomNames: String {
        rooms.map { $0.title }.joined(separator: ", ")
    }
    
    var speakerNames: String {
        speakers.map { $0.name }.joined(separator: ", ")
    }
    
    var hasSpeakers: Bool {
        !speakers.isEmpty
    }
    
    var hasImage: Bool {
        sessionImage != nil && !sessionImage!.isEmpty
    }
}
