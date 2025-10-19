//
//  SponsorEntity.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import Foundation

struct SponsorEntity: Codable {
    var id: Int = 0
    var name: String?
    var tagline: String?
    var link: String?
    var logo: String?
    var sponsorType: String?
    var createdAt: String
}
