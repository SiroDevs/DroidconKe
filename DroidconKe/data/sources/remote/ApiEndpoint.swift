
//
//  ApiEndpoint.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import Foundation

enum ApiEndpoint {
    case schedule(eventSlug: String)
    case feeds(eventSlug: String, page: Int = 1, perPage: Int = 100)
    case feedback(eventSlug: String, sessionId: Int)
    case organizers(orgSlug: String, type: String, page: Int = 1, perPage: Int = 100)
    case sessions(eventSlug: String)
    case speakers(eventSlug: String, perPage: Int = 100)
    case sponsors(orgSlug: String, perPage: Int = 100)
    
    var url: URL? {
        let baseURL = AppConstants.baseUrl
        
        switch self {
            case .schedule(let eventSlug):
                var components = URLComponents(string: "\(baseURL)/events/\(eventSlug)/schedule")
                components?.queryItems = [URLQueryItem(name: "grouped", value: "true")]
                return components?.url
                
            case .feeds(let eventSlug, let page, let perPage):
                var components = URLComponents(string: "\(baseURL)/events/\(eventSlug)/feeds")
                components?.queryItems = [
                    URLQueryItem(name: "page", value: "\(page)"),
                    URLQueryItem(name: "per_page", value: "\(perPage)")
                ]
                return components?.url
                
            case .feedback(let eventSlug, let sessionId):
                return URL(string: "\(baseURL)/events/\(eventSlug)/feedback/sessions/\(sessionId)")
                
            case .organizers(let orgSlug, let type, let page, let perPage):
                var components = URLComponents(string: "\(baseURL)/organizers/\(orgSlug)/team")
                components?.queryItems = [
                    URLQueryItem(name: "type", value: type),
                    URLQueryItem(name: "page", value: "\(page)"),
                    URLQueryItem(name: "per_page", value: "\(perPage)")
                ]
                return components?.url
                
            case .sessions(let eventSlug):
                var components = URLComponents(string: "\(baseURL)/events/\(eventSlug)/schedule")
                components?.queryItems = [URLQueryItem(name: "grouped", value: "true")]
                return components?.url
                
            case .speakers(let eventSlug, let perPage):
                var components = URLComponents(string: "\(baseURL)/events/\(eventSlug)/speakers")
                components?.queryItems = [URLQueryItem(name: "per_page", value: "\(perPage)")]
                return components?.url
                
            case .sponsors(let orgSlug, let perPage):
                var components = URLComponents(string: "\(baseURL)/events/\(orgSlug)/sponsors")
                components?.queryItems = [URLQueryItem(name: "per_page", value: "\(perPage)")]
                return components?.url
        }
    }
}
