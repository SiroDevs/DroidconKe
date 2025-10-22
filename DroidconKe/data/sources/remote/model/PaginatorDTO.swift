//
//  PaginatorDTO.swift
//  DroidconKe
//
//  Created by @sirodevs on 22/10/2025.
//

struct MetaDTO: Codable {
    let paginator: PaginatorDTO
}

struct PaginatorDTO: Codable {
    let count: Int
    let perPage: Int
    let currentPage: Int
    let nextPage: String?
    let hasMorePages: Bool
    let nextPageUrl: String?
    let previousPageUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case count, perPage = "per_page", currentPage = "current_page", nextPage = "next_page"
        case hasMorePages = "has_more_pages", nextPageUrl = "next_page_url", previousPageUrl = "previous_page_url"
    }
}
