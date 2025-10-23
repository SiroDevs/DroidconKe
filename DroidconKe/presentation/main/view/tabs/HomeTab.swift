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
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .center, spacing: 10) {
                    DroidconHeader(showFeedback: false)
                    
                    Text(L10n.welcomeToDroidconKe)
                        .font(.system(size: 20, weight: .bold))
                    
                    SessionSection(sessions: viewModel.sessions)
                    
                    SpeakerSection(speakers: viewModel.speakers)
                    
                    SponsorsSection(sponsors: viewModel.sponsors)
                    
                    OrganizersSection(organizers: viewModel.organizers)
                }
            }
        }
        .animation(.default, value: barHidden)
        .edgesIgnoringSafeArea(.all)
    }
}
