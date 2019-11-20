//
//  NumbersVC.swift
//  AssuitGuideBook
//
//  Created by Khalid on 11/20/19.
//  Copyright © 2019 Khalid. All rights reserved.
//

import UIKit

class NumbersVC: UIViewController {

    @IBOutlet weak var numersTableView: UITableView!
    
    var numberslist = [String]()
    
    @IBOutlet weak var btnDismess: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapDismessBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapDismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension NumbersVC: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberslist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "numberCell", for: indexPath) as? NumberCell
        {
            cell.numberLable.text = numberslist[indexPath.row]
            return cell
        }
        else {
            return NumberCell()
        }
    }
}
