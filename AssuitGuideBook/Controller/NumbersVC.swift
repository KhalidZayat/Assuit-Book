//
//  NumbersVC.swift
//  AssuitGuideBook
//
//  Created by Khalid on 11/20/19.
//  Copyright © 2019 Khalid. All rights reserved.
//

import UIKit

class NumbersVC: UIViewController {

    @IBOutlet weak var numersTableView: SelfSizedUITableView!
    
    var numberslist = [String]()
    var statusList = [Bool]()
    @IBOutlet weak var btnDismess: UIButton!
    @IBOutlet weak var tableViewHieght : NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        numersTableView.heightDelegate = self
    }
    
    func initData(list: [String])
    {
        numberslist = list
        for _ in 0..<list.count
        {
            statusList.append(false)
        }
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
            cell.updateCell( phoneNumber: numberslist[indexPath.row])
            return cell
        }
        else {
            return NumberCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
    }
}

extension NumbersVC: UITableViewHeighDelegate {
    func UITableView(_ tableView: UITableView, didUITableViewHeightChanged height: CGFloat) {
        self.tableViewHieght.constant = height
    }
    
    
}
