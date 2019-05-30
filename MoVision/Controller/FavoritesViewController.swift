//
//  ThirdViewController.swift
//  MoVision
//
//  Created by SDK on 5/20/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var fetchedFavMoviesResultsController: NSFetchedResultsController<Favorites>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFavMoviesFetchedResultsController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        fetchedFavMoviesResultsController = nil
    }
}

extension FavoritesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Catalog.sharedInstance.categoriesFavorite.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            if let count = fetchedFavMoviesResultsController.fetchedObjects?.count {
                return count
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Catalog.sharedInstance.categoriesFavorite[section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var favorite: Favorites?
        
        if indexPath.section == 0 {
            favorite = fetchedFavMoviesResultsController.object(at: indexPath)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryFavoriteCell", for: indexPath) as! CategoryFavoriteTableViewCell
        
        if let favorite = favorite {
            cell.titleLabel.text = favorite.title
            
            if let data = favorite.data {
                cell.posterImageView.image = UIImage(data: data)
            } else {
                cell.posterImageView.image = UIImage(named: "placeholder")
            }
        }
        
        return cell
    }
}

extension FavoritesViewController: NSFetchedResultsControllerDelegate {
    
    private func setupFavMoviesFetchedResultsController() {
        let fetchRequest: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        let predicate = NSPredicate(format: "category == %@", EntertainmentType.movie.description())
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        
        fetchedFavMoviesResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: appDelegate.dataController.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        fetchedFavMoviesResultsController.delegate = self
        
        do {
            try fetchedFavMoviesResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
}
