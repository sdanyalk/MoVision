//
//  Movie.swift
//  MoVision
//
//  Created by SDK on 5/25/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

struct Movie: Codable {
    
    let id: Int
    let title: String
    let video: Bool
    let originalLanguage: String
    let originalTitle: String
    let voteCount: Int
    let voteAverage: Float
    let popularity: Float
    var posterPath: String?
    let backdropPath: String?
    let genreIds: [Int]
    let adult: Bool
    let overview: String
    let releaseDate: String
    var posterImageData: Data?
}

extension Movie {
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case video
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case popularity
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case adult
        case overview
        case releaseDate = "release_date"
        case posterImageData
    }
}
