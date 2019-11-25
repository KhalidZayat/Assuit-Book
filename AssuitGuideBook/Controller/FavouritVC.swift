//
//  FavouritVC.swift
//  AssuitGuideBook
//
//  Created by Khalid on 11/13/19.
//  Copyright © 2019 Khalid. All rights reserved.
//

import UIKit

struct cellData
{
    var iscollapsed: Bool
    var data: [String]
}

class FavouritVC: UIViewController {
    
    var tableViewData = [cellData]()
    var hederView: HeaderView!
    @IBOutlet weak var sectionsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewData = [cellData(iscollapsed: true, data: ["0,0", "0,1"]) ,
        cellData(iscollapsed: true, data: ["1,0", "1,1"]),
        cellData(iscollapsed: true, data: ["2,0", "2,1"]),
        cellData(iscollapsed: true, data: ["3,0", "3,1"]),
        cellData(iscollapsed: true, data: ["4,0", "4,1"]),
        cellData(iscollapsed: true, data: ["5,0", "5,1"]),]
    }
    
}

extension FavouritVC: UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].iscollapsed == false {
            return tableViewData[section].data.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        hederView = HeaderView()
        hederView.button.tag = section
        hederView.button.addTarget(self, action: #selector(didHeaderTapped(button:)), for: .touchUpInside)
        hederView.setupHeader(imageName: LocalService.instance.Categories[section].imgName, title: LocalService.instance.Categories[section].title)
        return hederView
    }
    
    @objc func didHeaderTapped(button: UIButton) {
        let iscollapsed = tableViewData[button.tag].iscollapsed
        tableViewData[button.tag].iscollapsed = !iscollapsed
        sectionsTableView.reloadSections([button.tag], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath)
        cell.textLabel?.text = tableViewData[indexPath.section].data[indexPath.row]
        cell.textLabel?.textColor = #colorLiteral(red: 0.1656232178, green: 0.2400336862, blue: 0.6871221662, alpha: 1)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
}
