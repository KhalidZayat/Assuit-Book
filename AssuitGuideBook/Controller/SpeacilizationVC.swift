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
        Api.getDepartments(URLs.clinicsDepartmentsUrl){(error: String?, items: [String]?) in
                if error == nil
                {
                    self.speclizationList = (items ?? nil)!
                    self.speaclizationTableView.reloadData()
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
            }
            else if(self.speclizationList[index] == "المستشفيات الخاصة")
            {
                itemVC.callApi(url: URLs.specialHospitalsUrl)
            }
            else
            {
                itemVC.callApi(url: URLs.clinicsUrl+"?id=\(index+1)")
            }
        }
    }
}
