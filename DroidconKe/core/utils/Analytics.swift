//
//  Analytics.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

protocol AnalyticsServiceProtocol {
    func trackEvent(_ event: String)
}

final class AnalyticsService: AnalyticsServiceProtocol {
    func trackEvent(_ event: String) {
        print("Tracked event: \(event)")
    }
}
