//
//  OrganizerEntity.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import Foundation

struct OrganizerEntity: Identifiable, Codable {
    var id: Int = 0
    var name: String?
    var email: String?
    var description: String?
    var twitter: String?
    var logo: String?
    var slug: String?
    var status: String?
    var createdAt: String?
    var upcomingEventsCount: Int
    var totalEventsCount: Int
}
