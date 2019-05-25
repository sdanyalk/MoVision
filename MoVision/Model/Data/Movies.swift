//
//  MoviesResponse.swift
//  MoVision
//
//  Created by SDK on 5/24/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

struct Movies: Codable {
    
    let page: Int
    let totalResults: Int
    let totalPages: Int
    var results: [Movie]
}

extension Movies {
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
