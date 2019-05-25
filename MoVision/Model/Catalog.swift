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
    let categories:[Category]
    
    init(){
        let topRated = Category(name: "Top Rated", movies: [])
        let upComing = Category(name: "Up Coming", movies: [])
        let nowPlaying = Category(name: "Now Playing", movies: [])

        categories = [topRated, upComing, nowPlaying]
    }
}
