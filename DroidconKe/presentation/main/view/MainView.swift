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
                .scaleEffect(1.5)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        case .loaded:
            TabView {
                HomeTab(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                FeedTab(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Feed")
                    }
                
                SessionTab(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("Sessions")
                    }
                
                AboutTab(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "info.circle.fill")
                        Text("About")
                    }
            }
            .accentColor(.blue)
            .environment(\.horizontalSizeClass, .compact)
            
        case .error(let msg):
            ErrorState(message: msg) {
                Task { await viewModel.syncData() }
            }
            
        default:
            ProgressView()
                .scaleEffect(1.5)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
