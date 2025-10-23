//
//  EmptyState.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import SwiftUI

struct EmptyState: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Image(.emptyIcon)
                .resizable()
                .frame(width: 200, height: 200)

            Text("Nothing here")
                .font(.title2)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .padding(.horizontal)

        }
        .padding()
    }
}

struct EmptySessionFilterView: View {
    let hasActiveFilters: Bool
    let onClearAll: () -> Void
    
    public init(hasActiveFilters: Bool, onClearAll: @escaping () -> Void) {
        self.hasActiveFilters = hasActiveFilters
        self.onClearAll = onClearAll
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "calendar.badge.exclamationmark")
                .font(.system(size: 50))
                .foregroundColor(.gray)
            
            Text("No sessions found")
                .font(.headline)
                .foregroundColor(.primary)
            
            if hasActiveFilters {
                Text("Try adjusting your filters or search criteria")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Button("Clear All Filters") {
                    onClearAll()
                }
                .buttonStyle(.bordered)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
    }
}

#Preview {
    EmptyState()
}
