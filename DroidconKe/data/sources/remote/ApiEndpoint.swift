
//
//  ApiEndpoint.swift
//  DroidconKe
//
//  Created by @sirodevs on 20/10/2025.
//

import Foundation

enum ApiEndpoint {
    case feeds(page: Int = 1, perPage: Int = 100)
    case feedback(sessionId: Int)
    case organizers(type: String, page: Int = 1, perPage: Int = 100)
    case sessions
    case speakers(perPage: Int = 100)
    case sponsors(perPage: Int = 100)
    
    var url: URL? {
        guard var components = URLComponents(string: AppConstants.baseUrl) else { return nil }
        
        switch self {
        case .feeds(let page, let perPage):
            components.path = "/events/\(AppConstants.eventSlug)/feeds"
            components.queryItems = [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "per_page", value: "\(perPage)")
            ]
            
        case .feedback(let sessionId):
            components.path = "/events/\(AppConstants.eventSlug)/feedback/sessions/\(sessionId)"
            
        case .organizers(let type, let page, let perPage):
            components.path = "/organizers/\(AppConstants.orgSlug)/team"
            components.queryItems = [
                URLQueryItem(name: "type", value: type),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "per_page", value: "\(perPage)")
            ]
            
        case .sessions:
            components.path = "/events/\(AppConstants.eventSlug)/schedule"
            components.queryItems = [URLQueryItem(name: "grouped", value: "true")]
            
        case .speakers(let perPage):
            components.path = "/events/\(AppConstants.orgSlug)/speakers"
            components.queryItems = [URLQueryItem(name: "per_page", value: "\(perPage)")]
            
        case .sponsors(let perPage):
            components.path = "/events/\(AppConstants.orgSlug)/sponsors"
            components.queryItems = [URLQueryItem(name: "per_page", value: "\(perPage)")]
        }
        
        return components.url
    }
}
