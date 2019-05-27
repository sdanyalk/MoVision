//
//  DetailViewViewController.swift
//  MoVision
//
//  Created by SDK on 5/27/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import UIKit

class DetailViewViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var releaseDateTextField: UITextField!
    @IBOutlet weak var votesTextField: UITextField!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var favButton: UIButton!
    
    var movie: Movie?
    var tvShow: TVShow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            setupMovieDetailView(movie);
        } else if let tvShow = tvShow {
            setupTVShowDetailView(tvShow)
        }
    }
}

extension DetailViewViewController {
    
    private func setupMovieDetailView(_ movie: Movie) {
        titleTextField.text = movie.title
        releaseDateTextField.text = movie.releaseDate
        votesTextField.text = String (movie.voteCount)
        overviewTextView.text = movie.overview
        if let posterPath = movie.posterPath {
            setupPosterImageView(posterPath)
        }
    }
    
    private func setupTVShowDetailView(_ tvShow: TVShow) {
        titleTextField.text = tvShow.name
        releaseDateTextField.text = tvShow.firstAirDate
        votesTextField.text = String (tvShow.voteCount)
        overviewTextView.text = tvShow.overview
        if let posterPath = tvShow.posterPath {
            setupPosterImageView(posterPath)
        }
    }
    
    private func setupPosterImageView(_ posterPath: String) {
            self.posterImageView.kf.indicatorType = .activity
            self.posterImageView.kf.setImage(with: URL(string: posterPath), placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                print("Image: \(value.image). Got from: \(value.cacheType)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
