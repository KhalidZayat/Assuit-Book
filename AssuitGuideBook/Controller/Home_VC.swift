//
//  ViewController.swift
//  AssuitGuideBook
//
//  Created by Khalid on 11/13/19.
//  Copyright © 2019 Khalid. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HomeVC: UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LocalService.instance.getCategories().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? CategoryCell
        {
            cell.updateCell(category: LocalService.instance.getCategories()[indexPath.row])
            return cell
        }else
        {
            return CategoryCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = LocalService.instance.getCategories()[indexPath.row]
        
        switch category.imgName
        {
            case "doctor-50.png" :
                self.performSegue(withIdentifier: "fromHomeToSpeacilization", sender: category)
            
            case "hospital-50.png" :
                self.performSegue(withIdentifier: "fromHomeToSpeacilization", sender: category)
            
            default:
                self.performSegue(withIdentifier: "fromHomeToItems", sender: category)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let category = sender as? Category
        
        switch category?.imgName
        {
            case "doctor-50.png" :
                if let specVC = segue.destination as? SpeacilizationVC
                {
                    specVC.category = category
                }
            case "hospital-50.png" :
                if let specVC = segue.destination as? SpeacilizationVC
                {
                    specVC.category = category
                }
            default:
                if let itemVC = segue.destination as? ItemVC
                {
                    itemVC.category = category
                }
        }
}
    
}
extension HomeVC: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        return CGSize(width: bounds.width / 2, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

