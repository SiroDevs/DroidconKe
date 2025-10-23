//
//  SessionFilters.swift
//  DroidconKe
//
//  Created by @sirodevs on 22/10/2025.
//

import SwiftUI

struct FilterGridSection: View {
    let title: String
    let items: [String]
    @Binding var selectedItem: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                ForEach(items, id: \.self) { item in
                    FilterOptionButton(
                        title: item,
                        isSelected: selectedItem == item
                    ) {
                        if selectedItem == item {
                            selectedItem = nil
                        } else {
                            selectedItem = item
                        }
                    }
                }
            }
        }
    }
}

struct FilterOptionButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .white : .primary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(isSelected ? Color.blue : Color(.systemBackground))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct FilterChip: View {
    let title: String
    let systemImage: String?
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                if let systemImage = systemImage {
                    Image(systemName: systemImage)
                        .font(.caption2)
                }
                
                Text(title)
                    .font(.caption)
                    .lineLimit(1)
                
                Image(systemName: "xmark.circle.fill")
                    .font(.caption2)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.blue.opacity(0.2))
            .foregroundColor(.blue)
            .cornerRadius(16)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
