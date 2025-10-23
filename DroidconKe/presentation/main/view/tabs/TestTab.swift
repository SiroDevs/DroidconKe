//
//  HomeTab.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import SwiftUI

struct TestTab: View {
    let sessions: [SessionEntity]
    @State private var selectedDate = ""
    @State private var showFilters = false
    @State private var selectedLevel: String?
    @State private var selectedTopic: String?
    @State private var selectedRoom: String?
    @State private var selectedSessionType: String?
    
    private var availableDates: [String] {
        let dates = Set(sessions.map { $0.date })
        return Array(dates).sorted()
    }
    
    private var availableLevels: [String] {
        Array(Set(sessions.map { $0.sessionLevel })).sorted()
    }
    
    private var availableTopics: [String] {
        Array(Set(sessions.map { $0.sessionCategory })).sorted()
    }
    
    private var availableRooms: [String] {
        Array(Set(sessions.flatMap { $0.rooms.map { $0.title } })).sorted()
    }
    
    private var availableSessionTypes: [String] {
        Array(Set(sessions.map { $0.sessionFormat })).sorted()
    }
    
    private var filteredSessions: [SessionEntity] {
        sessions.filter { session in
            let matchesDate = selectedDate.isEmpty || session.date == selectedDate
            let matchesLevel = selectedLevel == nil || session.sessionLevel == selectedLevel
            let matchesTopic = selectedTopic == nil || session.sessionCategory == selectedTopic
            let matchesRoom = selectedRoom == nil || session.rooms.contains { $0.title == selectedRoom }
            let matchesSessionType = selectedSessionType == nil || session.sessionFormat == selectedSessionType
            
            return matchesDate && matchesLevel && matchesTopic && matchesRoom && matchesSessionType
        }
    }
    
    private var hasActiveFilters: Bool {
        selectedLevel != nil || selectedTopic != nil || selectedRoom != nil || selectedSessionType != nil
    }
    
    private var groupedSessions: [(key: String, value: [SessionEntity])] {
        let grouped = Dictionary(grouping: filteredSessions) { session in
            session.startTime
        }
        return grouped.sorted { $0.key < $1.key }
    }
    
    private func setDefaultDate() {
        if selectedDate.isEmpty && !availableDates.isEmpty {
            selectedDate = availableDates.first ?? ""
        }
    }
    
    private func clearAllFilters() {
        selectedLevel = nil
        selectedTopic = nil
        selectedRoom = nil
        selectedSessionType = nil
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 10) {
                    SessionTabHeader(
                        showFilters: $showFilters,
                        hasActiveFilters: hasActiveFilters,
                        selectedLevel: $selectedLevel,
                        selectedTopic: $selectedTopic,
                        selectedRoom: $selectedRoom,
                        selectedSessionType: $selectedSessionType,
                        onClearAll: clearAllFilters
                    )
                    
                    if !availableDates.isEmpty {
                        SessionTabDates(
                            availableDates: availableDates,
                            selectedDate: $selectedDate
                        )
                    }
                    
                    Text("All Sessions")
                        .font(.title2.bold())
                        .foregroundColor(.onPrimary)
                    
                    
                    if showFilters {
                        SessionTabGridFilters(
                            availableLevels: availableLevels,
                            availableTopics: availableTopics,
                            availableRooms: availableRooms,
                            availableSessionTypes: availableSessionTypes,
                            selectedLevel: $selectedLevel,
                            selectedTopic: $selectedTopic,
                            selectedRoom: $selectedRoom,
                            selectedSessionType: $selectedSessionType
                        )
                    }
                    
                    if filteredSessions.isEmpty {
                        EmptySessionFilterView(
                            hasActiveFilters: hasActiveFilters,
                            onClearAll: clearAllFilters
                        )
                    } else {
                        SessionsTimeline(groupedSessions: groupedSessions)
                    }
                }
                .padding(.horizontal)
            }
            .onAppear {
                setDefaultDate()
            }
            .onChange(of: sessions) { _ in
                setDefaultDate()
            }
        }
    }
}

#Preview {
    TestTab(sessions: SessionEntity.sampleSessions)
}
