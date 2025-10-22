//
//  HomeTab.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import SwiftUI

struct HomeTab: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    headerSection
                    featuredSessionsSection
                    speakersSection
//                    sponsorsSection
                    organizedBySection
                }
                .padding(.horizontal)
            }
            .navigationTitle("DroiconKe")
            .toolbarBackground(.regularMaterial, for: .navigationBar)
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("droidconke")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text("Feedback")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "bell.fill")
                    .font(.title3)
                    .foregroundColor(.gray)
            }
            
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 1)
        }
    }
    
    private var featuredSessionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Sessions")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button("View All") {
                    // Navigate to all sessions
                }
                .font(.subheadline)
                .foregroundColor(.blue)
            }
            
            // Featured Sessions ScrollView
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(featuredSessions.prefix(3)) { session in
                        FeaturedSessionCard(session: session)
                    }
                }
            }
        }
    }
    
    private var speakersSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Section Header
            HStack {
                Text("Speakers")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button("View All") {
                    // Navigate to all speakers
                }
                .font(.subheadline)
                .foregroundColor(.blue)
            }
            
//            LazyVGrid(columns: [
//                GridItem(.flexible()),
//                GridItem(.flexible()),
//                GridItem(.flexible())
//            ], spacing: 20) {
//                ForEach(featuredSpeakers.prefix(6)) { speaker in
//                    SpeakerCard(speaker: speaker)
//                }
//            }
        }
    }
    
//    private var sponsorsSection: some View {
//        VStack(alignment: .leading, spacing: 16) {
//            Text("Sponsors")
//                .font(.title2)
//                .fontWeight(.bold)
//            
//            LazyVGrid(columns: [
//                GridItem(.flexible()),
//                GridItem(.flexible())
//            ], spacing: 20) {
//                ForEach(sponsors) { sponsor in
//                    SponsorCard(sponsor: sponsor)
//                }
//            }
//        }
//    }
    
    private var organizedBySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Organised by:")
                .font(.headline)
                .foregroundColor(.secondary)
            
            HStack {
                Image(systemName: "k.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                
                Text("Android Kenya Community")
                    .font(.subheadline)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
    
    private var featuredSessions: [SessionEntity] {
        viewModel.sessions.filter { $0.isKeynote || $0.isServiceSession }
            .sorted { $0.id < $1.id }
    }
    
//    private var featuredSpeakers: [SpeakerEntity] {
//        let allSpeakers = viewModel.sessions.flatMap { $0.speakers }
//        return Array(Set(allSpeakers)).sorted { $0.name < $1.name }
//    }
//    
//    private var sponsors: [SponsorEntity] {
//        return [
//            SponsorEntity(id: 1, name: "Google", logo: "google-logo", tier: "platinum"),
//            SponsorEntity(id: 2, name: "Andela", logo: "andela-logo", tier: "gold"),
//            SponsorEntity(id: 3, name: "HOVER", logo: "hover-logo", tier: "silver")
//        ]
//    }
}
