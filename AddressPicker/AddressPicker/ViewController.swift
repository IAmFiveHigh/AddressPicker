//
//  ViewController.swift
//  AddressPicker
//
//  Created by 每天农资 on 2018/6/2.
//  Copyright © 2018年 我是五高你敢信. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var a: AddressPicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        a = AddressPicker(frame: CGRect(x: 0, y: screenHeight - 200, width: screenWidth, height: 200))
        a.delegate = self
        view.addSubview(a)
        
        let btn1 = UIButton(frame: CGRect(x: 20, y: 100, width: 100, height: 40))
        btn1.setTitle("我是按钮1", for: .normal)
        btn1.setTitleColor(UIColor.blue, for: .normal)
        btn1.addTarget(self, action: #selector(点击按钮1), for: .touchUpInside)
        view.addSubview(btn1)
        
        let btn2 = UIButton(frame: CGRect(x: 20, y: 200, width: 100, height: 40))
        btn2.setTitle("我是按钮2", for: .normal)
        btn2.setTitleColor(UIColor.blue, for: .normal)
        btn2.addTarget(self, action: #selector(点击按钮2), for: .touchUpInside)
        view.addSubview(btn2)
    }
    
    @objc private func 点击按钮1() {
        print(a.设置省市县("河南省", 市: "洛阳市", 县: "老"))
    }
    @objc private func 点击按钮2() {
        print(a.设置省市县("黑龙江省", 市: "洛阳市", 县: "老"))
    }
}

extension ViewController: AddressPickerDelegate {
    func 点击完成(_ 省: String, 市: String, 县: String, 街道们: [String]) {
        
    }
    
    func 返回选中省(_ 省: String, 市: String, 县: String, 街道们: [String]) {
        print(街道们)
    }
}

