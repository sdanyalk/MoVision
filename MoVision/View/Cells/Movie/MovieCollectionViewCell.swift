//
//  MovieCollectionViewCell.swift
//  MoVision
//
//  Created by SDK on 5/20/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    var movie: Movie? = nil {
        didSet {
            if let movie = movie, let posterPath = movie.posterPath, let url = URL(string: posterPath) {
                self.moviePosterImageView.kf.indicatorType = .activity
                self.moviePosterImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil) { result in
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
