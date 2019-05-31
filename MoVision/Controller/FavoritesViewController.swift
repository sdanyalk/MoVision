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
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var fetchedFavMoviesResultsController: NSFetchedResultsController<Favorites>!
    var fetchedFavTVShowsResultsController: NSFetchedResultsController<Favorites>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFetchedResultsController(for: .movie)
        setupFetchedResultsController(for: .tvShow)
        
        favoriteTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        fetchedFavMoviesResultsController = nil
        fetchedFavTVShowsResultsController = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupFetchedResultsController(for: .movie)
        setupFetchedResultsController(for: .tvShow)
        
        favoriteTableView.reloadData()
    }
}

// MARK : - Table View Data Source

extension FavoritesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Catalog.sharedInstance.categoriesFavorite.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            if let count = fetchedFavMoviesResultsController.fetchedObjects?.count {
                return count
            }
        } else if (section == 1) {
            if let count = fetchedFavTVShowsResultsController.fetchedObjects?.count {
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
            favorite = fetchedFavMoviesResultsController.fetchedObjects![indexPath.row]
        } else if indexPath.section == 1 {
            favorite = fetchedFavTVShowsResultsController.fetchedObjects![indexPath.row]
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryFavoriteCell", for: indexPath) as! CategoryFavoriteTableViewCell
        
        if let favorite = favorite {
            cell.titleLabel.textColor = UIColor.white
            cell.titleLabel.text = favorite.title
            
            if let data = favorite.data {
                cell.posterImageView.image = UIImage(data: data)
            } else {
                cell.posterImageView.image = UIImage(named: "placeholder")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var favorite: Favorites?
            
            if indexPath.section == 0 {
                favorite = fetchedFavMoviesResultsController.fetchedObjects![indexPath.row]
            } else if indexPath.section == 1 {
                favorite = fetchedFavTVShowsResultsController.fetchedObjects![indexPath.row]
            }
            
            if let favorite = favorite {
                self.favoriteTableView.beginUpdates()
                appDelegate.dataController.viewContext.delete(favorite)
                
                do {
                    try appDelegate.dataController.viewContext.save()
                    self.favoriteTableView.deleteRows(at: [indexPath], with: .right)
                } catch {
                    self.showError(withMessage: error.localizedDescription)
                }
                self.favoriteTableView.endUpdates()
            }
        }
    }
}

// MARK : - Table View Delegate

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.black
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    }
}

// MARK : - Fetched Results Core Data Delegate

extension FavoritesViewController: NSFetchedResultsControllerDelegate {
    
    private func setupFetchedResultsController(for entertainmentType: EntertainmentType) {
        let fetchRequest: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        let predicate = NSPredicate(format: "category == %@", entertainmentType.description())
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        
        switch entertainmentType {
        case .movie:
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
            
        case .tvShow:
            fetchedFavTVShowsResultsController = NSFetchedResultsController(
                fetchRequest: fetchRequest,
                managedObjectContext: appDelegate.dataController.viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil)
            fetchedFavTVShowsResultsController.delegate = self
            
            do {
                try fetchedFavTVShowsResultsController.performFetch()
            } catch {
                fatalError("The fetch could not be performed: \(error.localizedDescription)")
            }
        }
    }
    
    internal func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                             didChange anObject: Any,
                             at indexPath: IndexPath?,
                             for type: NSFetchedResultsChangeType,
                             newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            self.favoriteTableView.reloadData()
            break
        default: ()
        }
    }
}
