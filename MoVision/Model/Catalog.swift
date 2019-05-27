//
//  Catalog.swift
//  MoVision
//
//  Created by SDK on 5/25/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

class Catalog {
    
    static let sharedInstance = Catalog()
    let categoriesMovie: [CategoryMovie]
    let categoriesTV: [CategoryTV]
    
    init(){
        let topRatedMovies = CategoryMovie(name: "Top Rated", movies: [])
        let upComingMovies = CategoryMovie(name: "Up Coming", movies: [])
        let nowPlayingMovies = CategoryMovie(name: "Now Playing", movies: [])

        let topRatedTVShows = CategoryTV(name: "Top Rated", tvShows: [])
        let upComingTVShows = CategoryTV(name: "Up Coming", tvShows: [])
        let nowPlayingTVShows = CategoryTV(name: "Now Playing", tvShows: [])

        categoriesMovie = [topRatedMovies, upComingMovies, nowPlayingMovies]
        categoriesTV = [topRatedTVShows, upComingTVShows, nowPlayingTVShows]
    }
}
