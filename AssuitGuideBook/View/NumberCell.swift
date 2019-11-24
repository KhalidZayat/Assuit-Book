//
//  NumberCell.swift
//  AssuitGuideBook
//
//  Created by Khalid on 11/20/19.
//  Copyright © 2019 Khalid. All rights reserved.
//

import UIKit

class NumberCell: UITableViewCell {
    
    @IBOutlet weak var numberLable: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    override var isSelected: Bool {
        didSet {
            checkButton.isSelected = self.isSelected
        }
    }
    
    func updateCell(phoneNumber: String)
    {
        numberLable.text = phoneNumber
    }
}
