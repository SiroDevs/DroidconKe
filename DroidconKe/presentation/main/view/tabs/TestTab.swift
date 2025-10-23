//
//  HomeTab.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import SwiftUI

struct TestTab: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    DroidconHeader(showFeedback: true)
                    heroSection
                    SessionSection(
                        sessions: SessionEntity.sampleSessions
                    )
                    SpeakerSection(
                        speakers: SpeakerEntity.sampleSpeakers
                    )
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var heroSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Welcome to the largest Android Focused Developer community in Africa.")
                .font(.system(size: 20, weight: .bold))
        }
    }
    
}

#Preview {
    TestTab()
}
