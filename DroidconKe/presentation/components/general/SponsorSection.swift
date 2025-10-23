//
//  SponsorSection.swift
//  DroidconKe
//
//  Created by @sirodevs on 23/10/2025.
//

import SwiftUI

struct SponsorsSection: View {
    let sponsors: [SponsorEntity]
    
    private var groupedSponsors: [String: [SponsorEntity]] {
        Dictionary(grouping: sponsors) { $0.sponsorType?.lowercased() ?? "other" }
    }
    
    private let sponsorTypeOrder = ["platinum", "gold", "silver", "bronze", "other"]
    
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Text("Sponsors")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.horizontal)
                .foregroundColor(.onPrimary)
            
            LazyVStack(alignment: .leading, spacing: 32) {
                ForEach(sponsorTypeOrder, id: \.self) { sponsorType in
                    if let sponsorsOfType = groupedSponsors[sponsorType], !sponsorsOfType.isEmpty {
                        SponsorTypeSection(
                            sponsors: sponsorsOfType,
                            type: sponsorType
                        )
                    }
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

struct SponsorTypeSection: View {
    let sponsors: [SponsorEntity]
    let type: String
    
    private var displayName: String {
        type.capitalized
    }
    
    private var isPlatinum: Bool {
        type.lowercased() == "platinum"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if isPlatinum {
                platinumSponsorsView
            } else {
                otherSponsorsView
            }
        }
    }
    
    private var platinumSponsorsView: some View {
        LazyVStack(spacing: 20) {
            ForEach(sponsors, id: \.id) { sponsor in
                SponsorLogo(
                    sponsor: sponsor,
                    size: CGSize(width: 160, height: 120)
                )
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal)
    }
    
    private var otherSponsorsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(sponsors, id: \.id) { sponsor in
                    SponsorLogo(
                        sponsor: sponsor,
                        size: CGSize(width: 80, height: 60)
                    )
                }
            }
            .padding(.horizontal)
        }
    }
}

struct SponsorTypeGridSection: View {
    let sponsors: [SponsorEntity]
    let type: String
    let columns: [GridItem]
    
    init(sponsors: [SponsorEntity], type: String, columnsCount: Int = 3) {
        self.sponsors = sponsors
        self.type = type
        self.columns = Array(repeating: GridItem(.flexible()), count: columnsCount)
    }
    
    private var isPlatinum: Bool {
        type.lowercased() == "platinum"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if isPlatinum {
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 20) {
                    ForEach(sponsors, id: \.id) { sponsor in
                        SponsorLogo(
                            sponsor: sponsor,
                            size: CGSize(width: 160, height: 120)
                        )
                    }
                }
                .padding(.horizontal)
            } else {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(sponsors, id: \.self) { sponsor in
                        SponsorLogo(
                            sponsor: sponsor,
                            size: CGSize(width: 80, height: 60)
                        )
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct SponsorLogo: View {
    let sponsor: SponsorEntity
    let size: CGSize
    
    var body: some View {
        Group {
            if let logoUrl = sponsor.logo, let url = URL(string: logoUrl) {
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
                Text(sponsor.name?.first?.uppercased() ?? "S")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
            )
            .cornerRadius(12)
    }
}

#Preview{
    SponsorsSection(sponsors: SponsorEntity.sampleSponsors)
}
