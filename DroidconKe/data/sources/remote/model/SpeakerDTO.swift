//
//  SpeakerDTO.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import Foundation

struct SpeakerDTO: Codable {
    let name: String
    let tagline: String
    let biography: String
    let avatar: String
    let twitter: String?
    let linkedin: String?
    let blog: String?
    let companyWebsite: String?
    
    private enum CodingKeys: String, CodingKey {
        case name, tagline, biography, avatar, twitter, linkedin, blog
        case companyWebsite = "company_website"
    }
}

struct SpeakersRespDTO: Codable {
    let data: [SpeakerDTO]
    let meta: MetaDTO
}
