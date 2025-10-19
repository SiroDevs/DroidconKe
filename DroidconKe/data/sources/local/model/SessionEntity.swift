//
//  SessionEntity.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import Foundation

struct SessionEntity: Codable {
    var id: Int = 0
    var remoteId: String?
    var sessionDescription: String?
    var sessionFormat: String?
    var sessionLevel: String?
    var slug: String?
    var title: String?
    var endDateTime: String?
    var endTime: String?
    var isBookmarked: Bool
    var isKeynote: Bool
    var isServiceSession: Bool
    var sessionImage: String?
    var startDateTime: String?
    var startTime: String?
    var rooms: String?
    var speakers: String?
    var startTimestamp: String?
    var sessionImageUrl: String?
}
