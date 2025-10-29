//
//  SpeakersSection.swift
//  DroidconKe
//
//  Created by @sirodevs on 23/10/2025.
//

import SwiftUI

struct SpeakersSection: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    let speakers: [SpeakerEntity]
    
    let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    private var randomSpeakers: [SpeakerEntity] {
        Array(speakers.shuffled().prefix(isIpad ? 10 : 5))
    }
    
    private var isLandscape: Bool {
        verticalSizeClass == .compact
    }
    
    private var size: CGFloat {
        if isIpad {
            return 200
        } else {
            return isLandscape ? 120 : 85
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Speakers")
                    .font(.title3.bold())
                    .foregroundColor(.onPrimary)

                Spacer()

                if !speakers.isEmpty {
                    NavigationLink(
                        destination: SpeakersView(speakers: speakers))
                    {
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
                            SpeakerCard(
                                speaker: speaker, size: size
                            )
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
    SpeakersSection(
        speakers: SpeakerEntity.sampleSpeakers
    )
}
