//
//  FavouriteItemCell.swift
//  AssuitGuideBook
//
//  Created by Khalid on 11/26/19.
//  Copyright © 2019 Khalid. All rights reserved.
//

import UIKit

protocol FavouriteItemCellDelegate : class {
    func addToFavourites(with id : IndexPath)
    func makeACall(with id : IndexPath)
    func shareItem(with id : IndexPath)
    func navigate(with id : IndexPath)
}

class FavouriteItemCell: UITableViewCell {
    
    var id: IndexPath!
    weak var delegate: FavouriteItemCellDelegate?
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPhone: UILabel!
    @IBOutlet weak var itemAddress: UILabel!
    @IBOutlet weak var btnAddFavourit: UIButton!
    
    func updateCell(cellIndex: IndexPath, item: FavouriteItem)
    {
        id = cellIndex
        itemImage.image = UIImage(named: item.imageName)
        itemName.text = item.name
        itemPhone.text = item.phone
        itemAddress.text = item.address
        btnAddFavourit.isSelected = true
    }
    
    @IBAction func didTappedBtnCall(_ sender: UIButton) {
        self.delegate?.makeACall(with: id)
    }
   
    @IBAction func didTappedBtnShare(_ sender: UIButton) {
        self.delegate?.shareItem(with: id)
    }
    
    @IBAction func didTappedBtnNavigate(_ sender: UIButton) {
        self.delegate?.navigate(with: id)
    }
    
    @IBAction func didTappedBtnFavourite(_ sender: UIButton) {
        self.delegate?.addToFavourites(with: id)
    }
}
