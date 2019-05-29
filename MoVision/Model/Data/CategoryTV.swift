//
//  CategoryTV.swift
//  MoVision
//
//  Created by SDK on 5/26/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

class CategoryTV {
    
    let name: String
    var tvShows: [TVShow]
    
    init(name: String, tvShows: [TVShow]){
        self.name = name
        self.tvShows = tvShows
    }
}
