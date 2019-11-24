//
//  Api.swift
//  AssuitGuideBook
//
//  Created by Khalid on 11/15/19.
//  Copyright © 2019 Khalid. All rights reserved.
//

import UIKit
import Alamofire

class Api: NSObject {

    class func getDepartments(_ url: String , completion: @escaping (_ error: String?, _ daprtments: [String]?)->Void)
    {
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseData {
                response in
                
                switch response.result
                {
                case .failure(let error):
                    do {
                        completion(error.localizedDescription , nil)
                    }
                case .success(let value):
                    do {
                        let result = try JSONDecoder().decode(DapartmentsModel.self, from: value)
                        
                        var deps = [String]()
                        for item in result.data
                        {
                            deps.append(item.name)
                        }
                        completion(nil , deps)
                    }
                    catch {
                        completion(error.localizedDescription , nil)
                    }
                }
        }
    }
    class func getItems(_ url: String , completion: @escaping (_ error: String?, _ item: [Item]?)->Void)
    {
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseData {
                response in
                
                switch response.result
                {
                case .failure(let error):
                    do {
                    completion(error.localizedDescription , nil)
                }
                case .success(let value):
                    do {
                    let result = try JSONDecoder().decode(ApiModel.self, from: value)
                    
                    var items = [Item]()
                    for item in result.data
                    {
                        let newItem = Item(itemName: item.name, itemPhone: item.phone, itemAddress: item.address)
                        items.append(newItem)
                    }
                    completion(nil , items)
                    }
                    catch {
                        completion(error.localizedDescription , nil)
                    }
                }
            }
    }
}
