//
//  FavouritVC.swift
//  AssuitGuideBook
//
//  Created by Khalid on 11/13/19.
//  Copyright © 2019 Khalid. All rights reserved.
//

import UIKit

class FavouritVC: UIViewController {

    var data = ["العيادات","المستشفيات","معامل التحاليل","الصيدليات","الفنادق","المطاعم"]
    var numberOfRows = 0
    var iscollapsed = true
    var sectionTitl = "العيادات"
    let button = UIButton(type: .system)
    
    @IBOutlet weak var sectionsTableView: UITableView!
    @IBOutlet weak var itemsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension FavouritVC: UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        button.setTitle(sectionTitl, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1656232178, green: 0.2400336862, blue: 0.6871221662, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.titleLabel?.textAlignment = .center
        button .addTarget(self, action: #selector(didHeaderTapped), for: .touchUpInside)
        return button
    }
    
    @objc func didHeaderTapped() {
        if iscollapsed
        {
            iscollapsed = false
            numberOfRows = 6
            sectionsTableView.reloadData()
        }
        else {
            iscollapsed = true
            numberOfRows = 0
            sectionsTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textColor = #colorLiteral(red: 0.1656232178, green: 0.2400336862, blue: 0.6871221662, alpha: 1)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sectionTitl = data[indexPath.row]
        didHeaderTapped()
    }
}
