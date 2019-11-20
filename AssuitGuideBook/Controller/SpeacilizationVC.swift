//
//  SpeacilizationVC.swift
//  AssuitGuideBook
//
//  Created by Khalid on 11/13/19.
//  Copyright © 2019 Khalid. All rights reserved.
//

import UIKit

class SpeacilizationVC: UIViewController {

    var category: Category? = nil
    var speclizationList = [String]()
    @IBOutlet weak var speaclizationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func callApi()
    {
        let activityView = UIActivityIndicatorView(style: .gray)
        activityView.center = self.view.center
        activityView.transform = CGAffineTransform(scaleX: 3, y: 3)
        activityView.color = #colorLiteral(red: 0.1656232178, green: 0.2400336862, blue: 0.6871221662, alpha: 1)
        activityView.hidesWhenStopped = true
        self.view.addSubview(activityView)
        activityView.startAnimating()
        Api.getDepartments(URLs.clinicsDepartmentsUrl){(error: String?, items: [String]?) in
                if error == nil
                {
                    self.speclizationList = (items ?? nil)!
                    self.speaclizationTableView.reloadData()
                    activityView.stopAnimating()
                }
                else
                {
                    print(error!)
                }
            
        }
    }
}

extension SpeacilizationVC: UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return speclizationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "speacilizationCell", for: indexPath) as? SpeacilizingCell
        {
            cell.doctorSpecilization.text = speclizationList[indexPath.row]
            return cell
        }else
        {
            return SpeacilizingCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "fromSpecilizationToItems", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let itemVC = segue.destination as? ItemVC
        {
            guard let index = sender as? Int else { return }
            itemVC.category = category
            
            if self.speclizationList[index] == "المستشفيات العامة"
            {
                itemVC.callApi(url: URLs.hospitalsUrl)
                itemVC.navigationItem.title = "المستشفيات العامة"
                itemVC.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.1656232178, green: 0.2400336862, blue: 0.6871221662, alpha: 1)
            }
            else if(self.speclizationList[index] == "المستشفيات الخاصة")
            {
                itemVC.callApi(url: URLs.specialHospitalsUrl)
                itemVC.navigationItem.title = "المستشفيات الخاصة"
                itemVC.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.1656232178, green: 0.2400336862, blue: 0.6871221662, alpha: 1)
            }
            else
            {
                itemVC.callApi(url: URLs.clinicsUrl+"?id=\(index+1)")
                itemVC.navigationItem.title = "عيادات ( \(speclizationList[index]) )"
                itemVC.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.1656232178, green: 0.2400336862, blue: 0.6871221662, alpha: 1)
            }
        }
    }
}
