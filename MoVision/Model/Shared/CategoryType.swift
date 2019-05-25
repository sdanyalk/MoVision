//
//  CategoryType.swift
//  MoVision
//
//  Created by SDK on 5/25/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

enum CategoryType: Int {
    
    case topRated
    case upComing
    case nowPlaying
    
    func index() -> Int {
        return self.rawValue
    }
}
