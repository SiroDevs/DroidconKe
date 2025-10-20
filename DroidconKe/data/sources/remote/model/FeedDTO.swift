//
//  FeedDTO.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import Foundation

struct FeedDTO: Codable {
    let title: String?
    let body: String?
    let topic: String?
    let url: String?
    let image: String?
    let createdAt: String
}
