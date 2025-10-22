//
//  SessionSection.swift
//  DroidconKe
//
//  Created by @sirodevs on 23/10/2025.
//

import SwiftUI

struct SessionSection: View {
    let title: String
    let sessions: [SessionEntity]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.title3.bold())
                    .foregroundColor(.onPrimary)

                Spacer()

                if !sessions.isEmpty {
                    Button(action: {
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

            // MARK: - Sessions List
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(sessions) { session in
                        SessionCard(session: session)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    SessionSection(
        title: "Sessions",
        sessions: SessionEntity.sampleSessions
    )
}
