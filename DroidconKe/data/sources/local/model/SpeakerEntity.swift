//
//  SpeakerEntity.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import Foundation

struct SpeakerEntity: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let tagline: String
    let biography: String
    let avatar: String
    let twitter: String?
    let linkedin: String?
    let blog: String?
    let companyWebsite: String?
    let isDroidcon: Bool
    
    var twitterHandle: String? {
        guard let twitter = twitter else { return nil }
        return twitter.components(separatedBy: "/").last
    }
    
    var hasSocialLinks: Bool {
        twitter != nil || linkedin != nil || blog != nil || companyWebsite != nil
    }
}
