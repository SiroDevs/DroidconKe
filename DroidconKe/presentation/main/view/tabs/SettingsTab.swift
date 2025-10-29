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
    @State private var selectedConFilter: ConFilter = .all
    @Environment(\.dismiss) private var dismiss
    let isPresentedAsSheet: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                SettingsSection(header: "Select Session Types") {
                    ForEach(ConFilter.allCases) { filter in
                        SettingsRow(
                            title: filter.rawValue,
                            foregroundColor: .primary
                        ) {
                            viewModel.updateConFilter(filter)
                        } trailing: {
                            if viewModel.selectedConFilter == filter {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }

                SettingsSection(header: "Select an App Theme") {
                    Picker("Choose Theme", selection: $themeManager.selectedTheme) {
                        ForEach(AppThemeMode.allCases) { mode in
                            Text(mode.displayName).tag(mode)
                        }
                    }
                    .pickerStyle(.inline)
                }
            }
            .background(Color(.surfaceTint))
            .navigationTitle("Settings")
            .toolbarBackground(.regularMaterial, for: .navigationBar)
            .toolbar {
                if isPresentedAsSheet {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}
