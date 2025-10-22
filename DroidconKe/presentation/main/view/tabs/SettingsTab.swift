//
//  SettingsTab.swift
//  DroidconKe
//
//  Created by @sirodevs on 22/10/2025.
//

import SwiftUI

struct SettingsTab: View {
    @ObservedObject var viewModel: MainViewModel
    @EnvironmentObject var themeManager: ThemeManager
    
    @State private var showPaywall: Bool = false
    @State private var showResetAlert: Bool = false
    @State private var restartTheApp = false

    var body: some View {
        NavigationStack {
            Form {
                SettingsSection(header: "App Theme") {
                    Picker("Choose Theme", selection: $themeManager.selectedTheme) {
                        ForEach(AppThemeMode.allCases) { mode in
                            Text(mode.displayName).tag(mode)
                        }
                    }
                    .pickerStyle(.inline)
                }

//                SettingsSection(header: "Maoni") {
//                    SettingsRow(
//                        systemImage: "text.badge.star",
//                        title: L10n.leaveReview,
//                        subtitle: L10n.leaveReviewDesc,
//                        action: viewModel.promptReview
//                    )
//                    SettingsRow(
//                        systemImage: "envelope",
//                        title: L10n.contactUs,
//                        subtitle: L10n.contactUsDesc,
//                        action: AppUtilities.sendEmail
//                    )
//                }

            }
            .navigationTitle("Settings")
            .toolbarBackground(.regularMaterial, for: .navigationBar)
        }
    }
}
