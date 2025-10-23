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
                    DroidconHeader(showFeedback: false)
                    
                    Text("Welcome to the largest Android Focused Developer community in Africa.")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.onPrimaryContainer)
                    
                    SessionSection(sessions: viewModel.sessions)
                    
                    SpeakerSection(speakers: viewModel.speakers)
                    
                    SponsorsSection(sponsors: viewModel.sponsors)
                    
                    OrganizersSection(organizers: viewModel.organizers)
                }
                .padding(.horizontal)
            }
        }
    }
}
