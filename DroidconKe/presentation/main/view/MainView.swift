//
//  MainView.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel: MainViewModel = {
        DiContainer.shared.resolve(MainViewModel.self)
    }()
    
    var body: some View {
        stateContent
            .edgesIgnoringSafeArea(.bottom)
            .task { await viewModel.syncData() }
    }
    
    @ViewBuilder
    private var stateContent: some View {
        switch viewModel.uiState {
        case .loading:
            ProgressView()
            
        case .loaded:
            TabView {
                HomeTab(viewModel: viewModel)
                    .tabItem {
                        Label("Home", systemImage: "magnifyingglass")
                    }
                
                FeedTab(viewModel: viewModel)
                    .tabItem {
                        Label("sessions", systemImage: "heart.fill")
                    }
            }
            .environment(\.horizontalSizeClass, .compact)
            
        case .error(let msg):
            ErrorState(message: msg) {
                Task { await viewModel.syncData() }
            }
            
        default:
            ProgressView()
        }
    }
}
