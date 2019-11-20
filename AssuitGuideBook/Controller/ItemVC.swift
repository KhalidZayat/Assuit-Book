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
        let activityView = UIActivityIndicatorView(style: .gray)
        activityView.center = self.view.center
        activityView.transform = CGAffineTransform(scaleX: 3, y: 3)
        activityView.color = #colorLiteral(red: 0.1656232178, green: 0.2400336862, blue: 0.6871221662, alpha: 1)
        activityView.hidesWhenStopped = true
        self.view.addSubview(activityView)
        activityView.startAnimating()
        
        Api.getItems(url) { (error: String?, items: [Item]?) in
            
            if error == nil{
                self.items = items ?? [Item]()
                self.itemsTableView.reloadData()
                activityView.stopAnimating()
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
    
    
    //call item's phone
    func makeACall(with id : IndexPath) {
        
        // generate phone numbers list
        var numlist = self.items[id.row].phone.components(separatedBy: "/")
        if(numlist.count > 1)
        {
            for i in 0..<numlist.count
            {
                 numlist[i] = "088\(numlist[i].trimmingCharacters(in: .whitespaces))"
            }
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NumbersVC") as! NumbersVC
            vc.numberslist = numlist
            vc.navigationItem.title = "أرقام الهاتف"
            vc.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.1656232178, green: 0.2400336862, blue: 0.6871221662, alpha: 1)
            self.present(vc,animated: true)
        }
        else{
            guard let url = URL(string: "tel://088\(String(describing: numlist[0]))")
                else { return }
            UIApplication.shared.open(url, options: [:], completionHandler:nil)
        }
    }
    
    //share item as message
    func shareItem(with id : IndexPath) {
        let message = "الاسم// \(self.items[id.row].name)\nرقم الهاتف// ( \(self.items[id.row].phone) )\nالعنوان// \(self.items[id.row].address)"
        let activityController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        
        present(activityController, animated: true)
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
    
    func addToFavourites(with id: IndexPath, isSelected: Bool) {
        self.items[id.row].isSelected = isSelected
    }
    
}

