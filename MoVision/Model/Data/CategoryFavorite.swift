//
//  CategoryFavorite.swift
//  MoVision
//
//  Created by SDK on 5/27/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

class CategoryFavorite {
    
    let name: String
    var favorites: [Favorite]
    
    init(name: String, favorites: [Favorite]){
        self.name = name
        self.favorites = favorites
    }
}
