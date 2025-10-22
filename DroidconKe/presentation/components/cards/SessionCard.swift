//
//  SessionCard.swift
//  DroidconKe
//
//  Created by @sirodevs on 23/10/2025.
//

import SwiftUI

struct SessionCard: View {
    let session: SessionEntity

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .bottomLeading) {
                Color(hex: session.backgroundColor ?? "#0041FF")
                    .cornerRadius(12, corners: [.topLeft, .topRight])

                VStack(alignment: .leading, spacing: 10) {
                    if session.hasSpeakers {
                        HStack(spacing: 12) {
                            ForEach(session.speakers.prefix(2)) { speaker in
                                VStack(spacing: 4) {
                                    if !speaker.avatar.isEmpty,
                                       let url = URL(string: speaker.avatar) {
                                        AsyncImage(url: url) { image in
                                            image.resizable()
                                        } placeholder: {
                                            Circle().fill(Color.white.opacity(0.3))
                                        }
                                        .scaledToFill()
                                        .frame(width: 36, height: 36)
                                        .clipShape(Circle())
                                    } else {
                                        Circle()
                                            .fill(Color.white.opacity(0.3))
                                            .frame(width: 36, height: 36)
                                    }

                                    Text(speaker.name)
                                        .font(.caption2)
                                        .foregroundColor(.white)
                                        .lineLimit(1)
                                }
                            }
                        }
                    }

                    // Session title
                    Text(session.title)
                        .font(.subheadline.bold())
                        .foregroundColor(.white)
                        .lineLimit(2)
                }
                .padding()
            }
            .frame(height: 140)

            // MARK: - Bottom Section
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 6) {
                    Label(session.startTime, systemImage: "clock")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    if !session.roomNames.isEmpty {
                        Text("|")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(session.roomNames)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 10)
            .background(Color(.systemGray6))
            .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
        }
        .frame(width: 260)
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
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
