//
//  ContentView.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//


import SwiftUI

struct ContentView: View {
    
    @State private var navigateToNextScreen = false
    
    var body: some View {
        Group {
            if navigateToNextScreen {
                MainView()
            } else {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            navigateToNextScreen = true
                        }
                    }
            }
        }
        .animation(.easeInOut, value: navigateToNextScreen)
    }
}
