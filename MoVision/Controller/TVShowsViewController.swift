//
//  SecondViewController.swift
//  MoVision
//
//  Created by SDK on 5/20/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import UIKit

class TVShowsViewController: UIViewController {

    @IBOutlet weak var tvShowsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTVShows(for: .topRated)
        getTVShows(for: .upComing)
        getTVShows(for: .nowPlaying)
    }
}

// MARK : - Private Methods

extension TVShowsViewController {
    
    private func getTVShows(for categoryType: CategoryType) {
        APIClient.getTVShows(categoryType) { tvShows, error in
            if let error = error {
                self.showError(withMessage: error.localizedDescription)
                
                return
            }
            
            if let tvShows = tvShows {
                Catalog.sharedInstance.categoriesTV[categoryType.index()].tvShows = tvShows.results
            }
            
            DispatchQueue.main.async {
                self.tvShowsTableView.reloadData()
            }
        }
    }
}

// MARK : - Table View Data Source

extension TVShowsViewController: UITableViewDataSource {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryTVCell", for: indexPath) as! CategoryTVTableViewCell
        cell.category = Catalog.sharedInstance.categoriesTV[indexPath.section]
        
        return cell
    }
}
