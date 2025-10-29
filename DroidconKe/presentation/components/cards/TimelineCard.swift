//
//  TimelineCard.swift
//  DroidconKe
//
//  Created by @sirodevs on 23/10/2025.
//

import SwiftUI

struct TimelineCard: View {
    let isCommonSession: Bool
    let session: SessionEntity
    
    @State private var isBookmarked: Bool = false
    
    init(isCommonSession: Bool, session: SessionEntity) {
        self.isCommonSession = isCommonSession
        self.session = session
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack(alignment: .top, spacing: 16) {
                SessionTimeView(
                    session: session,
                    isCommonSession: isCommonSession
                )
                SessionInfoView(session: session)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            
            BookmarkButton(isBookmarked: $isBookmarked)
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.08), radius: 3, x: 0, y: 1)
        .onAppear {
            isBookmarked = session.isBookmarked
        }
    }
}

struct SessionTimeView: View {
    let session: SessionEntity
    let isCommonSession: Bool
    
    var body: some View {
        VStack {
            Text(DateUtils.formatTime(session.startTime))
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.primary)
            
            if !isCommonSession {
                Image(session.isDroidcon ? .droid : .dash)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 75)
            }
        }
        .frame(width: 50)
    }
}

struct SessionFormatBadge: View {
    let sessionFormat: String
    
    var body: some View {
        if !sessionFormat.isEmpty {
            Text(sessionFormat.uppercased())
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.blue)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(4)
        }
    }
}

struct SessionSpeakersView: View {
    let speakers: [SpeakerEntity]
    
    private var displayedSpeakers: ArraySlice<SpeakerEntity> {
        speakers.prefix(3)
    }
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(displayedSpeakers) { speaker in
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
            
            if speakers.count > displayedSpeakers.count {
                Text("+\(speakers.count - displayedSpeakers.count)")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct SessionInfoView: View {
    let session: SessionEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            SessionFormatBadge(sessionFormat: session.sessionFormat)
            
            Text(session.title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.primary)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
            
            Text("\(DateUtils.formatTime(session.startTime)) - \(DateUtils.formatTime(session.endTime)) | \(session.roomNames)")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.secondary)
            
            if session.hasSpeakers {
                SessionSpeakersView(speakers: session.speakers)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct BookmarkButton: View {
    @Binding var isBookmarked: Bool
    
    var body: some View {
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
}

#Preview {
    TestTab(sessions: SessionEntity.sampleSessions)
}

//#Preview {
//    TimelineCard(
//        session: SessionEntity.sampleSessions[0],
//        isCommonSession: false,
//        isCompact: true,
//    )
//}
