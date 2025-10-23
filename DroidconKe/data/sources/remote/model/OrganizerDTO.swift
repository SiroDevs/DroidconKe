//
//  OrganizerDTO.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import Foundation

struct OrganizerDTO: Codable {
    let id: Int
    let name: String?
    let email: String?
    let description: String?
    let twitter: String?
    let logo: String?
    let slug: String?
    let status: String?
    let createdAt: String?
    let upcomingEventsCount: Int
    let totalEventsCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case id, name, email, description, twitter, logo, slug, status
        case createdAt = "created_at"
        case upcomingEventsCount = "upcoming_events_count"
        case totalEventsCount = "total_events_count"
    }
}

struct OrganizersRespDTO: Codable {
    let data: [OrganizerDTO]
    let meta: MetaDTO
}
