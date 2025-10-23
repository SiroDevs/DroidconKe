//
//  SponsorDTO.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import Foundation

struct SponsorDTO: Codable {
    let name: String?
    let tagline: String?
    let link: String?
    let logo: String?
    let sponsorType: String?
    let createdAt: String
    
    private enum CodingKeys: String, CodingKey {
        case name, tagline,link, logo
        case sponsorType = "sponsor_type"
        case createdAt = "created_at"
    }
}

struct SponsorsRespDTO: Codable {
    let data: [SponsorDTO]
}
