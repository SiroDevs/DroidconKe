
//
//  OrganizersSection.swift
//  DroidconKe
//
//  Created by @sirodevs on 23/10/2025.
//

import SwiftUI

struct OrganizersSection: View {
    let organizers: [OrganizerEntity]
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Organized by")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.onPrimary)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(organizers, id: \.id) { organizer in
                    OrganizerLogo(organizer: organizer)
                }
            }
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.15))
        )
        .padding(.horizontal)
    }
}

struct OrganizerLogo: View {
    let organizer: OrganizerEntity
    
    var body: some View {
        Group {
            if let logoUrl = organizer.logo, let url = URL(string: logoUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 60)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 60)
                    case .failure:
                        placeholderLogo
                    @unknown default:
                        placeholderLogo
                    }
                }
            } else {
                placeholderLogo
            }
        }
    }
    
    private var placeholderLogo: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .frame(height: 60)
            .overlay(
                Text(organizer.name?.first?.uppercased() ?? "O")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
            )
            .cornerRadius(12)
    }
}

#Preview{
    OrganizersSection(organizers: OrganizerEntity.sampleOrganizers)
}
