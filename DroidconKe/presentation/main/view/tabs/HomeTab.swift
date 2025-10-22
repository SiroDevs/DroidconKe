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
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Droidcon")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Freshback")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    
                    // Conference Description
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Droidcon is a global conference focused on the engineering of Android applications. Droidcon provides a forum for developers to network with other developers, share techniques, announce apps and products, and to learn and teach.")
                            .font(.body)
                            .foregroundColor(.primary)
                        
                        Text("It will have workshops and codelabs focused on the building of Android applications and will have participants an excellent chance to learn about the local Android development ecosystem, opportunities and services as well as meet the engineers and companies who work on them.")
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal)
                    
                    // Organizing Team Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Organizing Team")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 16) {
                            ForEach(0..<9) { index in
                                TeamMemberCard(index: index)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationBarHidden(true)
        }
    }
}
