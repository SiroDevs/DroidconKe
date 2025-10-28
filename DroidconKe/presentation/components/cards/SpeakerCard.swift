//
//  SpeakerCard.swift
//  DroidconKe
//
//  Created by @sirodevs on 23/10/2025.
//

import SwiftUI

struct SpeakerCard: View {
    let speaker: SpeakerEntity
    var borderColor: Color = .cyan
    var size: CGFloat = 70
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: speaker.avatar)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color(.surface)
            }
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 2)
            )
            
            Text(speaker.name)
                .font(.system(size: 13, weight: .medium))
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .lineLimit(2)
                .frame(width: size + 10, height: size/2)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    SpeakerSection(
        speakers: SpeakerEntity.sampleSpeakers
    )
}
