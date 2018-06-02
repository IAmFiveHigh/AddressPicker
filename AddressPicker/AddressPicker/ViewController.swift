//
//  ViewController.swift
//  AddressPicker
//
//  Created by 每天农资 on 2018/6/2.
//  Copyright © 2018年 我是五高你敢信. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let b = UILabel(frame: CGRect(x: 0, y: 100, width: screenWidth, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let a = AddressPicker(frame: CGRect(x: 0, y: screenHeight - 200, width: screenWidth, height: 200))
        a.delegate = self
        view.addSubview(a)
        
        view.addSubview(b)
    }
}

extension ViewController: AddressPickerDelegate {
    func 点击完成() {
        
    }
    
    func 返回选中省(_ 省: String, 市: String, 县: String, 街道们: [String]) {
        print(街道们)
        b.text = "\(省)\(市)\(县)"
    }
    
}

