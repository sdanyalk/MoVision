//
//  Endpoints.swift
//  MoVision
//
//  Created by SDK on 5/25/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

enum Endpoints {
    
    static let tmdbBaseUrl = "https://api.themoviedb.org/3"
    static let movie = "/movie"
    static let topRated = "/top_rated"
    static let apiKey = "?api_key=905709cfa9a7ae09553359bacc85b23b"
    
    case topRatedMovies
    
    var stringValue: String {
        switch self {
        case .topRatedMovies:
            return Endpoints.tmdbBaseUrl + Endpoints.movie + Endpoints.topRated + Endpoints.apiKey
        }
    }
    
    var url: URL {
        return URL(string: stringValue)!
    }
}
