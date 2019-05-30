//
//  TV.swift
//  MoVision
//
//  Created by SDK on 5/26/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

struct TVShow: Codable {
    
    let id: Int
    let name: String
    let voteCount: Int
    let voteAverage: Float
    let originalName: String
    let originalLanguage: String
    let originCountry: [String]
    let popularity: Float
    var posterPath: String?
    let backdropPath: String?
    let genreIds: [Int]
    let overview: String
    let firstAirDate: String
    var posterImageData: Data?
}

extension TVShow {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case originalName = "original_name"
        case originalLanguage = "original_language"
        case originCountry = "origin_country"
        case popularity
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
        case overview
        case firstAirDate = "first_air_date"
        case posterImageData
    }
}
