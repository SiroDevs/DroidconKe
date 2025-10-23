//
//  SessionCard.swift
//  DroidconKe
//
//  Created by @sirodevs on 23/10/2025.
//

import SwiftUI

struct SessionCard: View {
    let session: SessionEntity
    
    private var hasSessionImage: Bool {
        guard let sessionImage = session.sessionImage else { return false }
        return !sessionImage.isEmpty
    }
    
    private var sessionImageURL: URL? {
        guard let sessionImage = session.sessionImage else { return nil }
        return URL(string: sessionImage)
    }
    
    private var backgroundColor: Color {
        Color(hex: session.backgroundColor ?? "#0041FF")
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            sessionContentView
                .frame(height: 140)
                .cornerRadius(12, corners: [.topLeft, .topRight])
            
            sessionInfoView
                .background(Color(.systemGray6))
                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
        }
        .frame(width: 260)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    private var sessionContentView: some View {
        ZStack(alignment: .bottomLeading) {
            if hasSessionImage, let url = sessionImageURL {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    backgroundColor
                }
            } else {
                backgroundColor
                sessionTextContent
            }
        }
    }
    
    private var sessionTextContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(session.title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
            
            if !session.sessionFormat.isEmpty {
                Text(session.sessionFormat)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
                    .lineLimit(2)
            }
            
            if session.hasSpeakers {
                speakersView
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var speakersView: some View {
        HStack(spacing: 8) {
            ForEach(session.speakers.prefix(2)) { speaker in
                speakerView(speaker)
            }
            
            if session.speakers.count > 2 {
                Text("+\(session.speakers.count - 2)")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
    }
    
    private func speakerView(_ speaker: SpeakerEntity) -> some View {
        HStack(spacing: 4) {
            if !speaker.avatar.isEmpty, let url = URL(string: speaker.avatar) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Circle()
                        .fill(Color.white.opacity(0.3))
                }
                .frame(width: 20, height: 20)
                .clipShape(Circle())
            }
            
            Text(speaker.name)
                .font(.caption)
                .foregroundColor(.white)
                .lineLimit(1)
        }
    }
    
    private var sessionInfoView: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(session.title)
                .font(.headline)
                .fontWeight(.bold)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            Text("@ \(session.startTime) | \(session.roomNames)")
                    .font(.caption)
                    .fontWeight(.medium)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension Color {
    init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexString.hasPrefix("#") { hexString.removeFirst() }

        var rgb: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = 12
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    SessionCard(
        session: SessionEntity.sampleSessions[0]
    )
}
