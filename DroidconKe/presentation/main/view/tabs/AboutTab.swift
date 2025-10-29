//
//  AboutTab.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import SwiftUI

struct AboutTab: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .center, spacing: 10) {
                    DroidconHeader(showFeedback: true)
                    Text("About")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                            .padding(.horizontal)
                                        
                    
                    Text(L10n.aboutDroidconKe1)
                        .font(.body)
                        .foregroundColor(.primary)
                    
                    Text(L10n.aboutDroidconKe2)
                        .font(.body)
                        .foregroundColor(.primary)
                    
                    Text(L10n.aboutDroidconKe3)
                        .font(.body)
                        .foregroundColor(.primary)
                    
//                    Text("Organizing Team")
//                        .font(.title2)
//                        .fontWeight(.semibold)
//                        .padding(.horizontal)
//                    
//                    LazyVGrid(columns: [
//                        GridItem(.flexible()),
//                        GridItem(.flexible())
//                    ], spacing: 16) {
//                        ForEach(0..<9) { index in
//                            TeamMemberCard(index: index)
//                        }
//                    }
                }
                .padding(.horizontal)
            }
            .background(Color(.surfaceTint))
        }
    }
}
