//
//  ItemCell.swift
//  AssuitGuideBook
//
//  Created by Khalid on 11/13/19.
//  Copyright © 2019 Khalid. All rights reserved.
//

import UIKit

protocol ItemCellDelegate : class {
    func addToFavourites(with id : IndexPath, isSelected: Bool)
    func makeACall(with id : IndexPath)
    func shareItem(with id : IndexPath)
    func navigate(with id : IndexPath)
}

class ItemCell: UITableViewCell {

    var id: IndexPath!
    weak var delegate: ItemCellDelegate?
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPhone: UILabel!
    @IBOutlet weak var itemAddress: UILabel!
    @IBOutlet weak var btnAddFavourit: UIButton!

    func updateCell(cellIndex: IndexPath, imgname: String, item: Item)
    {
        id = cellIndex
        itemImage.image = UIImage(named: imgname)
        itemName.text = item.name
        itemPhone.text = item.phone
        itemAddress.text = item.address
        btnAddFavourit.isSelected = item.isSelected
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
        
        let status = !self.btnAddFavourit.isSelected
        sender.isSelected = status
        self.delegate?.addToFavourites(with: id, isSelected: status)
    }
    
    
}
