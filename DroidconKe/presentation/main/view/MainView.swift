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
                LottieView(name: "Success").frame(width: 300, height: 300)
                ProgressView()
                    .scaleEffect(1.5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            case .error(let msg):
                ErrorState(message: msg) {
                    Task { await viewModel.syncData() }
                }
                
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
                    
                    SettingsTab(viewModel: viewModel)
                        .tabItem {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                }
                .accentColor(.blue)
                .environment(\.horizontalSizeClass, .compact)
                
            default:
                EmptyState()
        }
    }
}
