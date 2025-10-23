//
//  SpeakerView.swift
//  DroidconKe
//
//  Created by @sirodevs on 23/10/2025.
//

import SwiftUI

struct SpeakerView: View {
    @StateObject private var viewModel: SpeakerViewModel
    let speaker: SpeakerEntity
    @Environment(\.dismiss) private var dismiss
    
    init(speaker: SpeakerEntity) {
        self.speaker = speaker
        _viewModel = StateObject(wrappedValue: DiContainer.shared.resolve(SpeakerViewModel.self))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                headerSection
                speakerProfileSection
                
                if !speaker.biography.isEmpty {
                    biographySection
                }
                
                if speaker.hasSocialLinks {
                    socialLinksSection
                }
            }
            .padding(.horizontal)
        }
        .navigationBarHidden(true)
        .background(Color(.systemBackground))
        .onAppear {
//            viewModel.fetchSpeakerDetails(speakerId: speaker.id)
        }
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
            
            Text("Speaker")
                .font(.headline)
                .fontWeight(.semibold)
            
            Spacer()
            
            Button(action: { viewModel.toggleBookmark() }) {
                Image(systemName: viewModel.isBookmarked ? "bookmark.fill" : "bookmark")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(viewModel.isBookmarked ? .blue : .primary)
                    .padding(8)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
            }
        }
        .padding(.top, 8)
    }
    
    private var speakerProfileSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Speaker:")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
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
                            .lineLimit(3)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                Spacer()
            }
        }
    }
    
    private var biographySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("About")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text(speaker.biography)
                .font(.body)
                .foregroundColor(.primary)
                .lineSpacing(6)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    private var socialLinksSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Connect")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            VStack(alignment: .leading, spacing: 12) {
                if let twitter = speaker.twitter, let twitterHandle = speaker.twitterHandle {
                    socialLinkRow(
                        icon: "bird.fill",
                        title: "Twitter Handle",
                        value: twitterHandle,
                        url: "https://twitter.com/\(twitterHandle)"
                    )
                }
                
                if let linkedin = speaker.linkedin {
                    socialLinkRow(
                        icon: "person.fill",
                        title: "LinkedIn",
                        value: linkedin.components(separatedBy: "/").last ?? "LinkedIn",
                        url: linkedin
                    )
                }
                
                if let blog = speaker.blog {
                    socialLinkRow(
                        icon: "globe",
                        title: "Blog",
                        value: blog,
                        url: blog
                    )
                }
                
                if let companyWebsite = speaker.companyWebsite {
                    socialLinkRow(
                        icon: "building.2",
                        title: "Company Website",
                        value: companyWebsite,
                        url: companyWebsite
                    )
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
    
    private func socialLinkRow(icon: String, title: String, value: String, url: String) -> some View {
        Button(action: {
            if let url = URL(string: url) {
                UIApplication.shared.open(url)
            }
        }) {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: icon)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .frame(width: 20)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    
                    Text(value)
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        .lineLimit(2)
                }
                
                Spacer()
                
                Image(systemName: "arrow.up.right")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
