//
//  ItemVC.swift
//  AssuitGuideBook
//
//  Created by Khalid on 11/13/19.
//  Copyright © 2019 Khalid. All rights reserved.
//

import UIKit

class ItemVC: UIViewController {

    @IBOutlet weak var itemsTableView: UITableView!
    
    var category: Category? = nil
    var items : [Item] = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        }
    
    func callApi(url: String)
    {
        Api.getItems(url) { (error: String?, items: [Item]?) in
            
            if error == nil{
                self.items = items ?? [Item]()
                self.itemsTableView.reloadData()
            }
            else{
                print(error as Any)
            }
        }
    }
}

extension ItemVC: UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemCell
        {
            cell.delegate = self
            cell.updateCell(cellIndex: indexPath, imgname: category!.imgName,item: items[indexPath.row])
            return cell
        }else
        {
            return ItemCell()
        }
    }
}

extension ItemVC: ItemCellDelegate
{
    func addToFavourites(with id: IndexPath, isSelected: Bool) {
        self.items[id.row].isSelected = isSelected
    }
    
    func makeACall(with id : IndexPath) {
        guard let url = URL(string: "tel://088\(String(describing: self.items[id.row].phone))")
            else { return }
        if UIApplication.shared.canOpenURL(url)
         {
            UIApplication.shared.open(url, options: [:], completionHandler:nil)
         }
         else
         {
            print("Can't make a call !!")
         }
    }
    
    func shareItem(with id : IndexPath) {
        let message = "الاسم// \(self.items[id.row].name)\nرقم الهاتف// ( \(self.items[id.row].phone) )\nالعنوان// \(self.items[id.row].address)"
        let activityController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        
        present(activityController, animated: true)
        print(message)
    }
    
    func navigate(with id : IndexPath) {
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(NSURL(string:
                    "comgooglemaps://?saddr=&daddr=27.180953,31.182783&directionsmode=driving")! as URL)
            } else {
                UIApplication.shared.openURL(NSURL(string:
                    "comgooglemaps://?saddr=&daddr=27.180953,31.182783&directionsmode=driving")! as URL)
            }
        } else {
            print("Can't pass location !!")
        }
    }
    
}

