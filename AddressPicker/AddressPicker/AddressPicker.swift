//
//  AddressPicker.swift
//  AddressPicker
//
//  Created by 每天农资 on 2018/6/2.
//  Copyright © 2018年 我是五高你敢信. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

class AddressPicker: UIView {

    private var 省数据源 = [[String: Any]]()
    private var 市数据源 = [[String: Any]]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        setupUI()
        loadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadData() {
        
        guard let path = Bundle.main.path(forResource: "area", ofType: "plist") else {return}
        
        guard let array = NSArray(contentsOfFile: path) else {return}
        
        if array is [[String: Any]] {
            省数据源 = array as! [[String: Any]]
            print(省数据源)
        }else {
            print("array is not [[string: any]]")
        }
    }
    
    private func setupUI() {
        
    }
    
}
