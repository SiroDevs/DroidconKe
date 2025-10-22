//
//  SessionTab.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import SwiftUI

struct SessionTab: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var selectedDate = "Day 1"
    @State private var searchText = ""
    
    private var availableDates: [String] {
        let dates = Set(viewModel.sessions.map { $0.date })
        return Array(dates).sorted()
    }
    
    private var filteredSessions: [SessionEntity] {
        viewModel.sessions.filter { session in
            let matchesDate = session.date == selectedDate
            let matchesSearch = searchText.isEmpty ||
                session.title.localizedCaseInsensitiveContains(searchText) ||
                session.speakerNames.localizedCaseInsensitiveContains(searchText) ||
                session.sessionCategory.localizedCaseInsensitiveContains(searchText)
            
            return matchesDate && matchesSearch
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    DroidconHeader(showFeedback: true)
                    // Date Picker Section
                    if !availableDates.isEmpty {
                        datePickerSection
                    }
                    
                    // Search and Filter Section
                    searchFilterSection
                    
                    // Sessions Timeline
                    if filteredSessions.isEmpty {
                        emptyStateView
                    } else {
                        sessionsTimelineView
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Sessions")
            .toolbarBackground(.regularMaterial, for: .navigationBar)
            .refreshable {
                await viewModel.syncData()
            }
        }
    }
    
    private var datePickerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Conference Days")
                .font(.headline)
                .padding(.horizontal, 4)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(availableDates, id: \.self) { date in
                        DateChip(title: date, isSelected: selectedDate == date) {
                            selectedDate = date
                        }
                    }
                }
            }
        }
    }
    
    private var searchFilterSection: some View {
        HStack {
            Text("Filter ▼")
                .font(.subheadline)
                .foregroundColor(.blue)
            
            Spacer()
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .font(.caption)
                
                TextField("Search sessions...", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.subheadline)
                
                if !searchText.isEmpty {
                    Button(action: { searchText = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                }
            }
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .frame(maxWidth: 200)
        }
    }
    
    private var sessionsTimelineView: some View {
        LazyVStack(alignment: .leading, spacing: 24) {
            ForEach(groupedSessions, id: \.key) { timeSlot, sessions in
                TimeSlotSection(timeSlot: timeSlot, sessions: sessions)
            }
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "calendar.badge.exclamationmark")
                .font(.system(size: 50))
                .foregroundColor(.gray)
            
            Text("No sessions found")
                .font(.headline)
                .foregroundColor(.primary)
            
            if !searchText.isEmpty {
                Text("Try adjusting your search or try a different day")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Button("Clear Search") {
                    searchText = ""
                }
                .buttonStyle(.bordered)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
    }
    
    private var groupedSessions: [(key: String, value: [SessionEntity])] {
        let grouped = Dictionary(grouping: filteredSessions) { session in
            session.startTime
        }
        return grouped.sorted { $0.key < $1.key }
    }
}
