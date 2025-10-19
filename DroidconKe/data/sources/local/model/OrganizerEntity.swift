//
//  OrganizerEntity.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import Foundation

struct OrganizerEntity: Identifiable, Codable {
    var id: Int = 0
    var name: String?
    var tagline: String?
    var link: String?
    var type: String?
    var photo: String?
    var bio: String?
    var twitterHandle: String?
    var designation: String?
    var createdAt: String
}
