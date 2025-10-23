//
//  SponsorEntity.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import Foundation

struct SponsorEntity: Codable, Hashable {
    var id: Int = 0
    var name: String?
    var tagline: String?
    var link: String?
    var logo: String?
    var sponsorType: String?
    var createdAt: String
    
    static func == (lhs: SponsorEntity, rhs: SponsorEntity) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
