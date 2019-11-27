//
//  FavouritVC.swift
//  AssuitGuideBook
//
//  Created by Khalid on 11/13/19.
//  Copyright © 2019 Khalid. All rights reserved.
//

import UIKit
import MapKit

struct cellData
{
    var iscollapsed: Bool
    var data: [FavouriteItem]
}

class FavouritVC: UIViewController {
    
    var tableViewData = [cellData]()
    var hederView: HeaderView!
    var categories: [Category]!
    
    @IBOutlet weak var sectionsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = LocalService.instance.getCategories()
        
        for category in categories {
            let res = RealmCrud.readType(type: category.imgName)
            tableViewData.append(cellData(iscollapsed: true, data: res.toArray()))
        }
    }
}

extension FavouritVC: UITableViewDelegate,UITableViewDataSource
{
    //header part
    //*******************************
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        hederView = HeaderView()
        hederView.button.tag = section
        hederView.button.addTarget(self, action: #selector(didHeaderTapped(button:)), for: .touchUpInside)
        hederView.setupHeader(imageName: categories[section].imgName, title: categories[section].title)
        return hederView
    }
    
    @objc func didHeaderTapped(button: UIButton) {
        let iscollapsed = tableViewData[button.tag].iscollapsed
        tableViewData[button.tag].iscollapsed = !iscollapsed
        sectionsTableView.reloadSections([button.tag], with: .fade)
        
    }
    
    
    
     // cells part
    //**********************************
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].iscollapsed == false {
            return tableViewData[section].data.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath) as? FavouriteItemCell {
            cell.delegate = self
            cell.updateCell(cellIndex: indexPath, item: tableViewData[indexPath.section].data[indexPath.row])
            return cell
        }
        else {
            return FavouriteItemCell()
        }
    }
}


extension FavouritVC: FavouriteItemCellDelegate
{
    //call item's phone
    func makeACall(with index : IndexPath) {
        
        // generate phone numbers list
        var numlist = self.tableViewData[index.section].data[index.row].phone.components(separatedBy: "/")
        if(numlist.count > 1)
        {
            for i in 0..<numlist.count
            {
                numlist[i] = "088\(numlist[i].trimmingCharacters(in: .whitespaces))"
            }
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NumbersVC") as! NumbersVC
            vc.initData(list: numlist)
            self.present(vc,animated: true)
        }
        else{
            guard let url = URL(string: "tel://088\(String(describing: numlist[0]))")
                else { return }
            UIApplication.shared.open(url, options: [:], completionHandler:nil)
        }
    }
    
    //share item as message
    func shareItem(with index : IndexPath) {
        let message = "الاسم// \(self.tableViewData[index.section].data[index.row].name)\nرقم الهاتف// ( \(self.tableViewData[index.section].data[index.row].phone) )\nالعنوان// \(self.tableViewData[index.section].data[index.row].address)"
        let activityController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        
        present(activityController, animated: true)
    }
    
    func navigate(with index : IndexPath) {
        let coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(27.180953),CLLocationDegrees(31.182783))
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = "Target location"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    
    func addToFavourites(with index: IndexPath) {
        //delete from favourite
        RealmCrud.deleteItem(name: self.tableViewData[index.section].data[index.row].name)
        self.tableViewData[index.section].data.remove(at: index.row)
        sectionsTableView.reloadSections([index.section], with: .fade)
    }
    
}
