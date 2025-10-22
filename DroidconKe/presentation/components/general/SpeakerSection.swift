//
//  SpeakerSection.swift
//  DroidconKe
//
//  Created by @sirodevs on 23/10/2025.
//

import SwiftUI

struct SpeakerSection: View {
    let title: String
    let speakers: [SpeakerEntity]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.title3.bold())
                    .foregroundColor(.onPrimary)

                Spacer()

                if !speakers.isEmpty {
                    Button(action: {
                    }) {
                        HStack(spacing: 6) {
                            Text("View All")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.onPrimary)
                            Text("+\(speakers.count)")
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
                    ForEach(speakers) { speaker in
                        SpeakerCard(speaker: speaker)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    SpeakerSection(
        title: "Speakers",
        speakers: SpeakerEntity.sampleSpeakers
    )
}
