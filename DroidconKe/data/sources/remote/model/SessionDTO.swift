//
//  SessionDTO.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import Foundation

struct SessionDTO: Codable {
    let remoteId: String?
    let sessionDescription: String?
    let sessionFormat: String?
    let sessionLevel: String?
    let slug: String?
    let title: String?
    let endDateTime: String?
    let endTime: String?
    let isBookmarked: Bool
    let isKeynote: Bool
    let isServiceSession: Bool
    let sessionImage: String?
    let startDateTime: String?
    let startTime: String?
    let rooms: String?
    let speakers: String?
    let startTimestamp: String?
    let sessionImageUrl: String?
}
