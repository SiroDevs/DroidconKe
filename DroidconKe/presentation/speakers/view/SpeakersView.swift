//
//  SpeakersView.swift
//  DroidconKe
//
//  Created by @sirodevs on 28/10/2025.
//

import SwiftUI

struct SpeakersView: View {
    let speakers: [SpeakerEntity]
    @State private var searchText = ""
    @Environment(\.dismiss) private var dismiss
    
    private var filteredSpeakers: [SpeakerEntity] {
        if searchText.isEmpty {
            return speakers.sorted { $0.name < $1.name }
        } else {
            return speakers.filter { speaker in
                speaker.name.localizedCaseInsensitiveContains(searchText)
            }
            .sorted { $0.name < $1.name }
        }
    }
    
    private var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 160, maximum: 200), spacing: 16)]
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    
                    TextField("Search speakers...", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                
                Text("\(filteredSpeakers.count) Speakers")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(filteredSpeakers) { speaker in
                        NavigationLink {
                            SpeakerView(speaker: speaker)
                        } label: {
                            SpeakerGridCard(speaker: speaker)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
            .background(Color.surface)
        }
        .navigationTitle("Speakers")
        .navigationBarTitleDisplayMode(.large)
    }
}
