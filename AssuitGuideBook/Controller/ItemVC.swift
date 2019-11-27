//
//  ItemVC.swift
//  AssuitGuideBook
//
//  Created by Khalid on 11/13/19.
//  Copyright © 2019 Khalid. All rights reserved.
//

import UIKit
import MapKit

class ItemVC: UIViewController {

    @IBOutlet weak var itemsTableView: UITableView!
    
    var category: Category? = nil
    var items : [Item] = [Item]()  {
        didSet {
            searchItem = items
        }
    }
    var searchItem: [Item] = []
    var searchController: UISearchController!
    override func viewDidLoad() {
        super.viewDidLoad()
            setupSearchbar()
        }
    
    private func setupSearchbar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
    }
    
    func callApi(url: String) {
        let activityView = UIActivityIndicatorView(style: .gray)
        activityView.center = self.view.center
        activityView.transform = CGAffineTransform(scaleX: 2, y: 2)
        activityView.color = #colorLiteral(red: 0.1656232178, green: 0.2400336862, blue: 0.6871221662, alpha: 1)
        activityView.hidesWhenStopped = true
        self.view.addSubview(activityView)
        activityView.startAnimating()
        
        Api.getItems(url) { (error: String?, items: [Item]?) in
            
            if error == nil{
                self.items = items ?? [Item]()
                for item in self.items {
                    if  RealmCrud.readItem(name: item.name) != nil {
                        item.isSelected = true
                    }
                }
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
        return searchItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemCell
        {
            cell.delegate = self
            cell.updateCell(cellIndex: indexPath, imgname: category!.imgName,item: searchItem[indexPath.row])
            return cell
        }else
        {
            return ItemCell()
        }
    }
}

//item operations
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
    func shareItem(with id : IndexPath) {
        let message = "الاسم// \(self.items[id.row].name)\nرقم الهاتف// ( \(self.items[id.row].phone) )\nالعنوان// \(self.items[id.row].address)"
        let activityController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        
        present(activityController, animated: true)
    }
    
    func navigate(with id : IndexPath) {
        let coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(27.180953),CLLocationDegrees(31.182783))
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = "Target location"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    
    func addToFavourites(with id: IndexPath, isSelected: Bool) {
        self.items[id.row].isSelected = isSelected
        
        switch isSelected {
            //add to favourite
            case true:
                RealmCrud.insert(item: FavouriteItem(name: self.items[id.row].name, phone: self.items[id.row].phone, address: self.items[id.row].address, imageName: self.category!.imgName))
            
            //delete from favourite
        case false:
                RealmCrud.deleteItem(name: self.items[id.row].name)
        }
    }
    
}

//searching
extension ItemVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            self.searchItem = items.filter( {
                $0.name.contains(searchText)
            })
        } else {
            self.searchItem = items
        }
         itemsTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        self.searchItem = items
        itemsTableView.reloadData()
    }
}
