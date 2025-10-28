//
//  SessionsSection.swift
//  DroidconKe
//
//  Created by @sirodevs on 23/10/2025.
//

import SwiftUI

struct SessionsSection: View {
    let sessions: [SessionEntity]
    @Binding var selectedTab: Tabbed
    
    private var randomSessions: [SessionEntity] {
        let filteredSessions = sessions.filter { $0.sessionFormat.isEmpty == false }
        
        
        let sessionsToUse = filteredSessions.isEmpty ? sessions : filteredSessions
        
        return Array(sessionsToUse.shuffled().prefix(5))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Sessions")
                    .font(.title3.bold())
                    .foregroundColor(.onPrimary)

                Spacer()

                if !sessions.isEmpty {
                    Button(action: {
                        selectedTab = .sessions
                    }) {
                        HStack(spacing: 6) {
                            Text("View All")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.onPrimary)
                            Text("+\(sessions.count)")
                                .font(.subheadline)
                                .foregroundColor(.onPrimary)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(.onPrimaryContainer)
                                .clipShape(Capsule())
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(randomSessions) { session in
                        NavigationLink {
                            SessionView(session: session)
                        } label: {
                            SessionCard(session: session)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
//    SessionsSection(
//        sessions: SessionEntity.sampleSessions, selectedTab: 2
//    )
}
