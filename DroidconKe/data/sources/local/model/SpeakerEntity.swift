//
//  SpeakerEntity.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import Foundation

struct SpeakerEntity: Identifiable, Codable {
    var id: Int = 0
    var name: String?
    var tagline: String?
    var bio: String?
    var avatar: String?
    var twitter: String?
}
