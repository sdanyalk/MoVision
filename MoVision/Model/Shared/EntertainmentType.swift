//
//  EntertainmentType.swift
//  MoVision
//
//  Created by SDK on 5/29/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

enum EntertainmentType: String {
    
    case movie
    case tvShow
    
    func description() -> String{
        return self.rawValue
    }
}
