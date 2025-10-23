
//
//  OrganizersSection.swift
//  DroidconKe
//
//  Created by @sirodevs on 23/10/2025.
//

import SwiftUI

struct OrganizersSection: View {
    let organizers: [OrganizerEntity]
    
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Text("Organized by;")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.horizontal)
                .foregroundColor(.onPrimary)
            
            LazyVStack(alignment: .leading, spacing: 32) {
                ForEach(organizers, id: \.id) { organizer in
                    OrganizerLogo(
                        organizer: organizer,
                        size: CGSize(width: 80, height: 60)
                    )
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.15))
        )
        .padding(.horizontal)
    }
}

struct OrganizerLogo: View {
    let organizer: OrganizerEntity
    let size: CGSize
    
    var body: some View {
        Group {
            if let logoUrl = organizer.logo, let url = URL(string: logoUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: size.width, height: size.height)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: size.width, height: size.height)
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
            .frame(width: size.width, height: size.height)
            .overlay(
                Text(organizer.name?.first?.uppercased() ?? "o")
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
