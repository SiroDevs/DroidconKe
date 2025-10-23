//
//  SessionTimeline.swift
//  DroidconKe
//
//  Created by @sirodevs on 23/10/2025.
//

import SwiftUI

struct SessionsTimeline: View {
    let groupedSessions: [(key: String, value: [SessionEntity])]
    
    public init(groupedSessions: [(key: String, value: [SessionEntity])]) {
        self.groupedSessions = groupedSessions
    }
    
    public var body: some View {
        LazyVStack(alignment: .leading, spacing: 32) {
            ForEach(groupedSessions, id: \.key) { timeSlot, sessions in
                TimeSlotSection(timeSlot: timeSlot, sessions: sessions)
            }
        }
    }
}

struct TimeSlotSection: View {
    let timeSlot: String
    let sessions: [SessionEntity]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(formatTime(timeSlot))
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
                    .padding(.leading, 8)
            }
            
            LazyVStack(spacing: 16) {
                ForEach(sessions) { session in
                    SessionCard(session: session)
                }
            }
        }
    }
    
    private func formatTime(_ timeString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        if let date = formatter.date(from: timeString) {
            formatter.dateFormat = "h:mm a"
            return formatter.string(from: date)
        }
        
        return timeString
    }
}
