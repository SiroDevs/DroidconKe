//
//  HomeTab.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import SwiftUI

struct TestTab: View {
    @State private var barHidden = true
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    DroidconHeader(showFeedback: false)
                    
                    Text(L10n.welcomeToDroidconKe)
                        .font(.system(size: 20, weight: .bold))
                    
                    SessionSection(
                        sessions: SessionEntity.sampleSessions
                    )
                    
                    SpeakerSection(
                        speakers: SpeakerEntity.sampleSpeakers
                    )
                    
                    SponsorsSection(sponsors: SponsorEntity.sampleSponsors)
                    
                    OrganizersSection(organizers: OrganizerEntity.sampleOrganizers)
                }
            }
        }
    }
}

#Preview {
    TestTab()
}
