//
//  SpeakerSection.swift
//  DroidconKe
//
//  Created by @sirodevs on 23/10/2025.
//

import SwiftUI

struct SpeakerSection: View {
    let speakers: [SpeakerEntity]
    
    private var randomSpeakers: [SpeakerEntity] {
        Array(speakers.shuffled().prefix(7))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Speakers")
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
                    ForEach(randomSpeakers) { speaker in
                        NavigationLink {
                            SpeakerView(speaker: speaker)
                        } label: {
                            SpeakerCard(speaker: speaker)
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
    SpeakerSection(
        speakers: SpeakerEntity.sampleSpeakers
    )
}
