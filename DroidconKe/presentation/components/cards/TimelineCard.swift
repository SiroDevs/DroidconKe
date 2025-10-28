//
//  TimelineCard.swift
//  DroidconKe
//
//  Created by @sirodevs on 23/10/2025.
//

import SwiftUI

struct TimelineCard: View {
    let session: SessionEntity
    @State private var isBookmarked: Bool = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack(alignment: .top, spacing: 16) {
                VStack {
                    Text(formatTime(session.startTime))
                        .font(.system(size: 14, weight: .semibold, design: .default))
                        .foregroundColor(.primary)
                    
                }
                .frame(width: 50)
                
                VStack(alignment: .leading, spacing: 6) {
                    if !session.sessionFormat.isEmpty {
                        Text(session.sessionFormat.uppercased())
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.blue)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(4)
                    }
                    
                    Text(session.title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.primary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                    Text("\(formatTime(session.startTime)) - \(formatTime(session.endTime)) | \(session.roomNames)")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.secondary)
                    
                    if session.hasSpeakers {
                        HStack(spacing: 12) {
                            ForEach(session.speakers.prefix(3)) { speaker in
                                HStack(spacing: 4) {
                                    if !speaker.avatar.isEmpty, let url = URL(string: speaker.avatar) {
                                        AsyncImage(url: url) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            Circle()
                                                .fill(Color.gray.opacity(0.3))
                                        }
                                        .frame(width: 20, height: 20)
                                        .clipShape(Circle())
                                    }
                                    
                                    Text(speaker.name)
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.primary)
                                        .lineLimit(1)
                                }
                            }
                            
                            if session.speakers.count > 3 {
                                Text("+\(session.speakers.count - 3)")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            
            Button(action: {
                isBookmarked.toggle()
            }) {
                Image(systemName: isBookmarked ? "star.fill" : "star")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(isBookmarked ? .yellow : .gray)
                    .padding(8)
                    .background(Color(.systemBackground))
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
            }
            .offset(x: -8, y: 8)
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.08), radius: 3, x: 0, y: 1)
        .onAppear {
            isBookmarked = session.isBookmarked
        }
    }
    
    private func formatTime(_ timeString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        guard let date = formatter.date(from: timeString) else { return timeString }
        
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
}

#Preview {
    TimelineCard(
        session: SessionEntity.sampleSessions[0]
    )
}
