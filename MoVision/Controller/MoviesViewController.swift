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
                Catalog.sharedInstance.categories[categoryType.index()].movies = movies.results
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
        return Catalog.sharedInstance.categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Catalog.sharedInstance.categories[section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
        cell.category = Catalog.sharedInstance.categories[indexPath.section]
        
        return cell
    }
}
