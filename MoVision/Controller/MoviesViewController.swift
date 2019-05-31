//
//  FirstViewController.swift
//  MoVision
//
//  Created by SDK on 5/20/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMovies(for: .topRated)
        getMovies(for: .upComing)
        getMovies(for: .nowPlaying)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieSegue" {
            if let movieCell = sender as? MovieCollectionViewCell,
                let movie = movieCell.movie,
                let detailVC = segue.destination as? DetailViewViewController {
                
                detailVC.movie = movie
            }
        }
    }
}

// MARK : - Private Methods

extension MoviesViewController {
    
    private func getMovies(for categoryType: CategoryType) {
        APIClient.getMovies(categoryType) { movies, error in
            if let error = error {
                self.showError(withMessage: error.localizedDescription)
                
                return
            }
            
            if let movies = movies {
                Catalog.sharedInstance.categoriesMovie[categoryType.index()].movies = movies.results
            }
            
            DispatchQueue.main.async {
                self.moviesTableView.reloadData()
            }
        }
    }
}

// MARK : - Table View Data Source

extension MoviesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Catalog.sharedInstance.categoriesMovie.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Catalog.sharedInstance.categoriesMovie[section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryMovieCell", for: indexPath) as! CategoryMovieTableViewCell
        cell.category = Catalog.sharedInstance.categoriesMovie[indexPath.section]
        
        return cell
    }
}

// MARK : - Table View Delegate

extension MoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.black
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    }
}
