//
//  SettingsSection.swift
//  DroidconKe
//
//  Created by @sirodevs on 22/10/2025.
//

import SwiftUI

struct SettingsSection<Content: View>: View {
    let header: String
    @ViewBuilder let content: Content
    
    var body: some View {
        Section(header: Text(header)) {
            content
        }
    }
}

struct SettingsRow<Content: View>: View {
    let title: String
    let subtitle: String?
    let foregroundColor: Color
    let action: (() -> Void)?
    let icon: String?
    @ViewBuilder let trailing: Content
    
    init(
        title: String,
        subtitle: String? = nil,
        foregroundColor: Color = .primary,
        action: (() -> Void)? = nil,
        icon: String? = nil,
        @ViewBuilder trailing: () -> Content = { EmptyView() }
    ) {
        self.title = title
        self.subtitle = subtitle
        self.foregroundColor = foregroundColor
        self.action = action
        self.icon = icon
        self.trailing = trailing()
    }
    
    var body: some View {
        let row = HStack {
            if let icon = icon {
                Image(systemName: icon)
                    .frame(width: 24, height: 24)
                    .foregroundColor(foregroundColor)
            }
            
            VStack(alignment: .leading) {
                Text(title).font(.headline).foregroundColor(foregroundColor)
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            trailing
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
        
        if let action = action {
            Button(action: action) { row }
                .buttonStyle(.plain)
        } else {
            row
        }
    }
}
