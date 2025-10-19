//
//  FeedEntity.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import Foundation

struct FeedEntity: Identifiable, Codable {
    var id: Int = 0
    var title: String?
    var body: String?
    var topic: String?
    var url: String?
    var image: String?
    var createdAt: String
}
