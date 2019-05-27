//
//  Category.swift
//  MoVision
//
//  Created by SDK on 5/25/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

class CategoryMovie {
    
    let name: String
    var movies: [Movie]
    
    init(name: String, movies: [Movie]){
        self.name = name
        self.movies = movies
    }
}
