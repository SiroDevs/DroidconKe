//
//  HomeTab.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import SwiftUI

struct HomeTab: View {
    @ObservedObject var viewModel: MainViewModel
    @Binding var selectedTab: Tabbed
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .center) {
                    DroidconHeader(showFeedback: false)
                    
                    VideoCard()
                    
                    SessionsSection(
                        sessions: viewModel.sessions,
                        selectedTab: $selectedTab
                    )
                    
                    SpeakersSection(speakers: viewModel.speakers)
                    
                    SponsorsSection(sponsors: viewModel.sponsors)
                    
                    OrganizersSection(organizers: viewModel.organizers)
                }
            }
            .background(Color(.surfaceTint))
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct HomeTabPreview: View {
    @Binding var selectedTab: Tabbed
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .center) {
                    DroidconHeader(showFeedback: false)
                    
                    VideoCard()
                    
                    SessionsSection(
                        sessions: SessionEntity.sampleSessions,
                        selectedTab: $selectedTab
                    )
                    
                    SpeakersSection(speakers: SpeakerEntity.sampleSpeakers)
                    
                    SponsorsSection(sponsors: SponsorEntity.sampleSponsors)
                    
                    OrganizersSection(organizers: OrganizerEntity.sampleOrganizers)
                }
            }
            .background(Color(.surfaceTint))
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    HomeTabPreview(selectedTab: .constant(.home))
}
