//
//  CategoryCell.swift
//  AssuitGuideBook
//
//  Created by Khalid on 11/13/19.
//  Copyright © 2019 Khalid. All rights reserved.
//

import UIKit

protocol CategoryCellDelgate : class {
    func addFav()
}
class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    func updateCell(category: Category)
    {
        self.categoryTitle.text = category.title
        self.categoryImage.image = UIImage(named: category.imgName)
    }
}
