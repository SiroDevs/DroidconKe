//
//  HomeTab.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import SwiftUI

struct HomeTab: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var barHidden = true
    @Binding var selectedTab: Tabbed
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .center) {
                    DroidconHeader(showFeedback: false)
                    
                    if viewModel.isOnline {
                        VideoCard()
                    }
                    
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
        .animation(.default, value: barHidden)
        .edgesIgnoringSafeArea(.all)
    }
}
