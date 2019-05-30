//
//  DetailViewViewController.swift
//  MoVision
//
//  Created by SDK on 5/27/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import UIKit
import CoreData

class DetailViewViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var releaseDateTextField: UITextField!
    @IBOutlet weak var votesTextField: UITextField!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var favButton: UIButton!
    
    var movie: Movie?
    var tvShow: TVShow?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            setupMovieDetailView(movie)
        } else if let tvShow = tvShow {
            setupTVShowDetailView(tvShow)
        }
    }
    
    @IBAction func favButtonClicked(_ sender: Any) {
        if let movie = movie {
            saveFavoriteMovie(movie)
        }
        
        if let tvShow = tvShow {
            saveFavoriteTVShow(tvShow)
        }
    }
}

// MARK : - Private Methods

extension DetailViewViewController {
    
    private func setupMovieDetailView(_ movie: Movie) {
        titleTextField.text = movie.title
        releaseDateTextField.text = movie.releaseDate
        votesTextField.text = String (movie.voteCount)
        overviewTextView.text = movie.overview
        if let posterPath = movie.posterPath {
            setupPosterImageView(posterPath, .movie)
        }
    }
    
    private func setupTVShowDetailView(_ tvShow: TVShow) {
        titleTextField.text = tvShow.name
        releaseDateTextField.text = tvShow.firstAirDate
        votesTextField.text = String (tvShow.voteCount)
        overviewTextView.text = tvShow.overview
        if let posterPath = tvShow.posterPath {
            setupPosterImageView(posterPath, .tvShow)
        }
    }
    
    private func setupPosterImageView(_ posterPath: String, _ entertainmentType: EntertainmentType) {
            self.posterImageView.kf.indicatorType = .activity
            self.posterImageView.kf.setImage(with: URL(string: posterPath), placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                if entertainmentType == .movie {
                    self.movie?.posterImageData = value.image.pngData()
                } else if entertainmentType == .tvShow {
                    self.tvShow?.posterImageData = value.image.pngData()
                }
                
                print("Image: \(value.image). Got from: \(value.cacheType)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    private func saveFavoriteMovie(_ movie: Movie) {
        let favorite = Favorites(context: appDelegate.dataController.viewContext)

        favorite.category = EntertainmentType.movie.description()
        favorite.title = movie.title
        favorite.releaseDate = movie.releaseDate
        favorite.overview = movie.overview
        favorite.creationDate = Date()
        favorite.data = movie.posterImageData
        
        let voteCountStr = String (movie.voteCount)
        if let voteCount = Int32(voteCountStr) {
            favorite.voteCount = voteCount
        }
        
        try? appDelegate.dataController.viewContext.save()
    }
    
    private func saveFavoriteTVShow(_ tvShow: TVShow) {
        let favorite = Favorites(context: appDelegate.dataController.viewContext)
        
        favorite.category = EntertainmentType.tvShow.description()
        favorite.title = tvShow.name
        favorite.releaseDate = tvShow.firstAirDate
        favorite.overview = tvShow.overview
        favorite.creationDate = Date()
        favorite.data = tvShow.posterImageData
        
        let voteCountStr = String (tvShow.voteCount)
        if let voteCount = Int32(voteCountStr) {
            favorite.voteCount = voteCount
        }
        
        try? appDelegate.dataController.viewContext.save()
    }
}
