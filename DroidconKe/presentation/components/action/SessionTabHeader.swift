//
//  SessionTabHeader.swift
//  DroidconKe
//
//  Created by @sirodevs on 23/10/2025.
//

import SwiftUI

struct SessionTabHeader: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var showFilters: Bool
    let hasActiveFilters: Bool
    @Binding var selectedLevel: String?
    @Binding var selectedTopic: String?
    @Binding var selectedRoom: String?
    @Binding var selectedSessionType: String?
    let onClearAll: () -> Void
    
    public init(
        showFilters: Binding<Bool>,
        hasActiveFilters: Bool,
        selectedLevel: Binding<String?>,
        selectedTopic: Binding<String?>,
        selectedRoom: Binding<String?>,
        selectedSessionType: Binding<String?>,
        onClearAll: @escaping () -> Void
    ) {
        self._showFilters = showFilters
        self.hasActiveFilters = hasActiveFilters
        self._selectedLevel = selectedLevel
        self._selectedTopic = selectedTopic
        self._selectedRoom = selectedRoom
        self._selectedSessionType = selectedSessionType
        self.onClearAll = onClearAll
    }
    
    public var body: some View {
        HStack {
            Image(colorScheme == .dark ? .droidconLogoWhite : .droidconLogo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 35)
            
            Spacer()
            
            // Right-aligned content
            VStack(alignment: .trailing, spacing: 8) {
                // Filter button
                Button(action: { showFilters.toggle() }) {
                    HStack(spacing: 6) {
                        Text("Filters")
                        Image(systemName: showFilters ? "chevron.up" : "chevron.down")
                    }
                    .font(.subheadline.bold())
                    .foregroundColor(.blue)
                }
                
                if hasActiveFilters {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            if let level = selectedLevel {
                                FilterChip(title: level, systemImage: "chart.bar") {
                                    selectedLevel = nil
                                }
                            }
                            
                            if let topic = selectedTopic {
                                FilterChip(title: topic, systemImage: "folder") {
                                    selectedTopic = nil
                                }
                            }
                            
                            if let room = selectedRoom {
                                FilterChip(title: room, systemImage: "mappin.and.ellipse") {
                                    selectedRoom = nil
                                }
                            }
                            
                            if let sessionType = selectedSessionType {
                                FilterChip(title: sessionType, systemImage: "doc.text") {
                                    selectedSessionType = nil
                                }
                            }
                            
                            Button("Clear All") {
                                onClearAll()
                            }
                            .font(.caption)
                            .foregroundColor(.red)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    TestTab(sessions: SessionEntity.sampleSessions)
}
