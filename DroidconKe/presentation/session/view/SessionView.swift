//
//  SessionView.swift
//  DroidconKe
//
//  Created by @sirodevs on 23/10/2025.
//

import SwiftUI

struct SessionView: View {
    @StateObject private var viewModel: SessionViewModel = {
        DiContainer.shared.resolve(SessionViewModel.self)
    }()
    
    let session: SessionEntity
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                headerSection
                
                if let mainSpeaker = session.speakers.first {
                    NavigationLink {
                        SpeakerView(speaker: mainSpeaker)
                    } label: {
                        speakerSection(speaker: mainSpeaker)
                    }
                }
                
                sessionTitleSection
                
                if !session.description.isEmpty {
                    descriptionSection
                }
                
                sessionDetailsSection
                
                if let speaker = session.speakers.first, speaker.hasSocialLinks {
                    socialLinksSection(speaker: speaker)
                }
            }
            .padding(.horizontal)
        }
        .navigationBarHidden(true)
        .background(Color(.systemBackground))
    }
    
    private var headerSection: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.primary)
                    .padding(8)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
            }
            
            Spacer()
            
            Text("Session Details")
                .font(.headline)
                .fontWeight(.semibold)
            
            Spacer()
            
            Circle()
                .fill(Color.clear)
                .frame(width: 32, height: 32)
        }
        .padding(.top, 8)
    }
    
    private func speakerSection(speaker: SpeakerEntity) -> some View {
        HStack(spacing: 16) {
            if !speaker.avatar.isEmpty, let url = URL(string: speaker.avatar) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                }
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            } else {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 80)
                    .overlay(
                        Text(speaker.name.prefix(1).uppercased())
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                    )
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(speaker.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                if !speaker.tagline.isEmpty {
                    Text(speaker.tagline)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
            
            Spacer()
        }
    }
    
    private var sessionTitleSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(session.title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
            
            if !session.sessionFormat.isEmpty {
                Text(session.sessionFormat.uppercased())
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(16)
            }
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("About this session")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text(session.description)
                .font(.body)
                .foregroundColor(.primary)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    private var sessionDetailsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Session Details")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            VStack(spacing: 12) {
                detailRow(icon: "clock", title: "Time", value: "\(DateUtils.formatTime(session.startTime)) - \(DateUtils.formatTime(session.endTime))")
                
                detailRow(icon: "mappin.and.ellipse", title: "Room", value: session.roomNames)
                
                detailRow(icon: "timer", title: "Duration", value: session.duration)
                
                if !session.sessionLevel.isEmpty {
                    detailRow(icon: "chart.bar", title: "Level", value: session.sessionLevel)
                }
                
                if !session.sessionCategory.isEmpty {
                    detailRow(icon: "folder", title: "Category", value: session.sessionCategory)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
    
    // MARK: - Social Links Section
    private func socialLinksSection(speaker: SpeakerEntity) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Connect")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            HStack(spacing: 16) {
                if let twitter = speaker.twitter, let twitterHandle = speaker.twitterHandle {
                    Button(action: {
                        // Open Twitter
                        if let url = URL(string: "https://twitter.com/\(twitterHandle)") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "bird.fill")
                                .font(.caption)
                            Text("Twitter")
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                        .foregroundColor(.blue)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
                
                if let linkedin = speaker.linkedin {
                    Button(action: {
                        // Open LinkedIn
                        if let url = URL(string: linkedin) {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "person.fill")
                                .font(.caption)
                            Text("LinkedIn")
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                        .foregroundColor(.blue)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
                
                if let blog = speaker.blog {
                    Button(action: {
                        // Open blog
                        if let url = URL(string: blog) {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "globe")
                                .font(.caption)
                            Text("Blog")
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                        .foregroundColor(.blue)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
            }
        }
    }
    
    private func detailRow(icon: String, title: String, value: String) -> some View {
        HStack {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(width: 20)
                
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
