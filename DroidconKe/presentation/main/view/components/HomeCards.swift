//
//  HomeCards.swift
//  DroidconKe
//
//  Created by @sirodevs on 22/10/2025.
//

import SwiftUI

struct FeaturedSessionCard: View {
    let session: SessionEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack(alignment: .topTrailing) {
                Rectangle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 280, height: 120)
                    .cornerRadius(12)
                
                if session.hasImage, let imageUrl = session.sessionImage {
                    Rectangle()
                        .fill(Color.blue.opacity(0.2))
                        .frame(width: 280, height: 120)
                        .cornerRadius(12)
                }
                
                Button(action: {
                }) {
                    Image(systemName: session.isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundColor(session.isBookmarked ? .blue : .white)
                        .padding(8)
                        .background(Color.black.opacity(0.3))
                        .clipShape(Circle())
                }
                .padding(8)
            }
            .frame(width: 280, height: 120)
            
            // Session Info
            VStack(alignment: .leading, spacing: 6) {
                Text(session.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .foregroundColor(.primary)
                
                Text("Using Android in Kenya")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                
                HStack {
                    Text("T03.0 | Room 1")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    if session.hasSpeakers {
                        Text("Speakers")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                }
            }
            .frame(width: 280)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

struct SpeakerCard: View {
    let speaker: SpeakerEntity
    
    var body: some View {
        VStack(spacing: 8) {
//            ZStack {
//                Circle()
//                    .fill(Color.blue.opacity(0.1))
//                    .frame(width: 70, height: 70)
//                
//                if let avatar = speaker.avatar, !avatar.isEmpty {
//                    Circle()
//                        .fill(Color.blue.opacity(0.2))
//                        .frame(width: 60, height: 60)
//                } else {
//                    Text(speaker.name.prefix(1))
//                        .font(.title2)
//                        .fontWeight(.bold)
//                        .foregroundColor(.blue)
//                }
//            }
            
            Text(speaker.name)
                .font(.caption)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
    }
}

struct SponsorCard: View {
    let sponsor: SponsorEntity
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
                    .frame(height: 80)
                
                Text(sponsor.name!)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
        }
    }
}
