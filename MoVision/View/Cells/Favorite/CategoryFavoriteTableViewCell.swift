//
//  CategoryFavoriteTableViewCell.swift
//  MoVision
//
//  Created by SDK on 5/27/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import UIKit

class CategoryFavoriteTableViewCell: UITableViewCell {
    
    var category: CategoryFavorite? = nil {
        didSet {
//            self.favoriteCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
