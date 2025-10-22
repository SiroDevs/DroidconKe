//
//  SessionCard.swift
//  DroidconKe
//
//  Created by @sirodevs on 22/10/2025.
//

import SwiftUI

struct DateChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color(.systemGray6))
                .cornerRadius(20)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct TimeSlotSection: View {
    let timeSlot: String
    let sessions: [SessionEntity]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(formatTime(timeSlot))
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
                    .padding(.leading, 8)
            }
            
            LazyVStack(spacing: 16) {
                ForEach(sessions) { session in
                    SessionCard1(session: session)
                }
            }
        }
    }
    
    private func formatTime(_ timeString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        if let date = formatter.date(from: timeString) {
            formatter.dateFormat = "h:mm a"
            return formatter.string(from: date)
        }
        
        return timeString
    }
}

struct SessionCard1: View {
    let session: SessionEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    if session.isKeynote {
                        Text("Keynote")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(4)
                    }
                    
                    Text(session.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                Button(action: {
                }) {
                    Image(systemName: session.isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundColor(session.isBookmarked ? .blue : .gray)
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            if session.hasSpeakers {
                Text(session.speakerNames)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            HStack {
                Label {
                    Text("\(formatTime(session.startTime)) - \(formatTime(session.endTime)) • \(session.duration)")
                } icon: {
                    Image(systemName: "clock")
                        .font(.caption)
                }
                
                Spacer()
                
                if !session.roomNames.isEmpty {
                    Label {
                        Text(session.roomNames)
                            .lineLimit(1)
                    } icon: {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.caption)
                    }
                }
            }
            .font(.caption)
            .foregroundColor(.secondary)
            
            if !session.sessionCategory.isEmpty {
                Text(session.sessionCategory.uppercased())
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(4)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
        )
    }
    
    private func formatTime(_ timeString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        if let date = formatter.date(from: timeString) {
            formatter.dateFormat = "h:mm a"
            return formatter.string(from: date)
        }
        
        return timeString
    }
}
