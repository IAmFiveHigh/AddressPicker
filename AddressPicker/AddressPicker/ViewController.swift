//
//  ViewController.swift
//  AddressPicker
//
//  Created by 每天农资 on 2018/6/2.
//  Copyright © 2018年 我是五高你敢信. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let a = AddressPicker(frame: CGRect(x: 0, y: screenHeight - 200, width: screenWidth, height: 200))
        view.addSubview(a)
    }

}

