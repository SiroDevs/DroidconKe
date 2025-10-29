//
//  SpeakerGridCard.swift
//  DroidconKe
//
//  Created by @sirodevs on 28/10/2025.
//

import SwiftUI

struct SpeakerGridCard: View {
    let speaker: SpeakerEntity
    
    var body: some View {
        VStack(spacing: 12) {
            AsyncImage(url: URL(string: speaker.avatar)) { phase in
                switch phase {
                case .empty:
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.secondary)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.secondary)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.primary.opacity(0.1), lineWidth: 1)
            )
            
            VStack(spacing: 4) {
                Text(speaker.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
                if !speaker.tagline.isEmpty {
                    Text(speaker.tagline)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
    }
}
