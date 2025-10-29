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
            LazyVStack(spacing: 16) {
                ForEach(sessions) { session in
                    NavigationLink {
                        SessionView(session: session)
                    } label: {
                        TimelineCard(
                            isCommonSession: session.sessionFormat.isEmpty && session.sessionLevel.isEmpty && session.sessionCategory.isEmpty,
                            session: session
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    TestTab(sessions: SessionEntity.sampleSessions)
}
