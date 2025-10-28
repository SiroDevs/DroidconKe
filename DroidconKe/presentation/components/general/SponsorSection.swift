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
    
    private var platinumSponsor: SponsorEntity? {
        groupedSponsors["platinum"]?.first
    }
    
    private var otherSponsors: [SponsorEntity] {
        let excludedTypes = ["platinum"]
        return sponsors.filter { sponsor in
            guard let type = sponsor.sponsorType?.lowercased() else { return true }
            return !excludedTypes.contains(type)
        }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Sponsors")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.onPrimary)
            
            if let platinumSponsor = platinumSponsor {
                SponsorCard(
                    sponsor: platinumSponsor,
                    size: CGSize(width: 200, height: 100)
                )
            }
            
            if !otherSponsors.isEmpty {
                VStack(alignment: .center) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 5) {
                            ForEach(otherSponsors, id: \.id) { sponsor in
                                SponsorCard(
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
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.15))
        )
        .padding(.horizontal)
    }
}

#Preview{
    SponsorsSection(sponsors: SponsorEntity.sampleSponsors)
}
