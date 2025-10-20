//
//  DroidconKeApp.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import SwiftUI

@main
struct DroidconKeApp: App {
    @StateObject private var themeManager = ThemeManager()
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = UIColor.label
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(themeManager)
            .preferredColorScheme({
                switch themeManager.selectedTheme {
                case .system: return nil
                case .light: return .light
                case .dark: return .dark
                }
            }())
        }
    }
}
