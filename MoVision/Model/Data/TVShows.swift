//
//  TVShows.swift
//  MoVision
//
//  Created by SDK on 5/26/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

struct TVShows: Codable {
    
    let page: Int
    let totalResults: Int
    let totalPages: Int
    var results: [TVShow]
}

extension TVShows {
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
