//
//  TVCollectionViewCell.swift
//  MoVision
//
//  Created by SDK on 5/26/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import UIKit
import Kingfisher

class TVCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tvPosterImageView: UIImageView!
    
    var tv: TVShow? = nil {
        didSet {
            if let tv = tv, let posterPath = tv.posterPath, let url = URL(string: posterPath) {
                self.tvPosterImageView.kf.indicatorType = .activity
                self.tvPosterImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil) { result in
                    switch result {
                    case .success(let value):
                        print("Image: \(value.image). Got from: \(value.cacheType)")
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
            }
        }
    }
}
