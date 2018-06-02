//
//  AddressModel.swift
//  AddressPicker
//
//  Created by 每天农资 on 2018/6/2.
//  Copyright © 2018年 我是五高你敢信. All rights reserved.
//

import UIKit

class 省数据结构 {

    var cities: [市数据结构]
    var state: String
    
    init(item: [String: Any]) {
        
        if let state = item["state"] as? String {
            self.state = state
        }else {
            self.state = ""
        }
        
        self.cities = [市数据结构]()
        if let citys = item["cities"] as? [[String: Any]] {
            for i in citys {
                self.cities.append(市数据结构(item: i))
            }
        }
    }
}

class 县数据结构 {
    var county: String
    var streets: [String]
    
    init(item: [String: Any]) {
        if let county = item["county"] as? String {
            self.county = county
        }else {
            self.county = ""
        }
        
        if let streets = item["streets"] as? [String] {
            self.streets = streets
        }else {
            self.streets = [String]()
        }
    }
}

class 市数据结构 {
    
    var city: String
    var areas: [县数据结构]
    
    init(item: [String: Any]) {
        if let city = item["city"] as? String {
            self.city = city
        }else {
            self.city = ""
        }
        
        areas = [县数据结构]()
        if let areas = item["areas"] as? [[String: Any]] {
            for i in areas {
                self.areas.append(县数据结构(item: i))
            }
        }
        
    }
}
