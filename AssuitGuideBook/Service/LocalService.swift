//
//  LocalService.swift
//  AssuitGuideBook
//
//  Created by Khalid on 11/13/19.
//  Copyright © 2019 Khalid. All rights reserved.
//

import Foundation

class LocalService {
    
    static let instance = LocalService()
    
    let Categories = [
        Category(title: "العيادات",imageName: "doctor-50.png"),
        Category(title: "المستشفيات",imageName: "hospital-50.png"),
        Category(title: "معامل التحاليل",imageName: "lab-50.png"),
        Category(title: "الصيدليات",imageName: "pharmacy-50.png"),
        Category(title: "الفنادق",imageName: "bedroom-50.png"),
        Category(title: "المطاعم",imageName: "restaurant-50.png")
    ]
    
    let doctorsList = ["أطفال","عيون","عظام","باطنة","جراحة","النسا والتوليد","القلب","الجلدية"]
    
    let hospitalsList = ["المستشفيات العامة","المستشفيات الخاصة"]
    
    func getCategories() -> [Category] {
        return Categories
    }
    
    func getDoctorsList() -> [String] {
        return doctorsList
    }
    
    func getHospitalsList() -> [String] {
        return hospitalsList
    }
}
