//
//  SessionTabGridFilters.swift
//  DroidconKe
//
//  Created by @sirodevs on 23/10/2025.
//

import SwiftUI

struct SessionTabGridFilters: View {
    let availableLevels: [String]
    let availableTopics: [String]
    let availableRooms: [String]
    let availableSessionTypes: [String]
    @Binding var selectedLevel: String?
    @Binding var selectedTopic: String?
    @Binding var selectedRoom: String?
    @Binding var selectedSessionType: String?
    
    public init(
        availableLevels: [String],
        availableTopics: [String],
        availableRooms: [String],
        availableSessionTypes: [String],
        selectedLevel: Binding<String?>,
        selectedTopic: Binding<String?>,
        selectedRoom: Binding<String?>,
        selectedSessionType: Binding<String?>
    ) {
        self.availableLevels = availableLevels
        self.availableTopics = availableTopics
        self.availableRooms = availableRooms
        self.availableSessionTypes = availableSessionTypes
        self._selectedLevel = selectedLevel
        self._selectedTopic = selectedTopic
        self._selectedRoom = selectedRoom
        self._selectedSessionType = selectedSessionType
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            if !availableLevels.isEmpty {
                FilterGridSection(
                    title: "Level",
                    items: availableLevels,
                    selectedItem: $selectedLevel
                )
            }
            
            if !availableTopics.isEmpty {
                FilterGridSection(
                    title: "Topic",
                    items: availableTopics,
                    selectedItem: $selectedTopic
                )
            }
            
            if !availableRooms.isEmpty {
                FilterGridSection(
                    title: "Rooms",
                    items: availableRooms,
                    selectedItem: $selectedRoom
                )
            }
            
            if !availableSessionTypes.isEmpty {
                FilterGridSection(
                    title: "Session Type",
                    items: availableSessionTypes,
                    selectedItem: $selectedSessionType
                )
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
