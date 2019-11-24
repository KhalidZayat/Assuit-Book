//
//  SelfSizeUITableView.swift
//  RKlinic-Patient
//
//  Created by RKAnjel on 4/7/19.
//  Copyright © 2019 RKAnjel. All rights reserved.
//

import UIKit

class SelfSizedUITableView: UITableView {
    weak var heightDelegate: UITableViewHeighDelegate? = nil
    override var contentSize: CGSize {
        didSet{
            heightDelegate?.UITableView(self, didUITableViewHeightChanged: contentSize.height * zoomScale )
        }
    }
}

protocol UITableViewHeighDelegate: class {
    func UITableView(_ tableView: UITableView, didUITableViewHeightChanged height: CGFloat)
}


