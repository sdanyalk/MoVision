//
//  CategoryTableViewCell.swift
//  MoVision
//
//  Created by SDK on 5/20/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import UIKit

class CategoryMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var category: CategoryMovie? = nil {
        didSet {
            self.moviesCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK : - Collection View Data Source

extension CategoryMovieTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let category = category {
            return category.movies.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        
        if let category = category {
            cell.movie = category.movies[indexPath.row]
        }
        
        return cell
    }
}

// MARK : - Collection View Flow Layout

extension CategoryMovieTableViewCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 3
        let hardCodedPadding: CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
