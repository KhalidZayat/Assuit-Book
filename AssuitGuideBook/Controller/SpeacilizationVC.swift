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

        if category?.imgName == "doctor-50.png"
        {
            speclizationList = LocalService.instance.getDoctorsList()
        }
        
        if category?.imgName == "hospital-50.png"
        {
            speclizationList = LocalService.instance.getHospitalsList()
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
        self.performSegue(withIdentifier: "fromSpecilizationToItems", sender: category)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let itemVC = segue.destination as? ItemVC
        {
            itemVC.category = category
        }
    }
}
