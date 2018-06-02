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

protocol AddressPickerDelegate: class {
    func 返回选中省(_ 省: String, 市: String, 县: String, 街道们: [String])
    
    func 点击完成()
}

class AddressPicker: UIView {

    private var 省数据源 = [省数据结构]()
    private var 市数据源 = [市数据结构]()
    private var 县数据源 = [县数据结构]()
    private var 街道数据 = [String]()
    
    private var 省 = ""
    private var 市 = ""
    private var 县 = ""
    
    private let pickerView = UIPickerView(frame: CGRect(x: 0, y: 25, width: screenWidth, height: 0))
    
    weak var delegate: AddressPickerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        setupUI(frame: frame)
        loadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadData() {
        
        guard let path = Bundle.main.path(forResource: "area", ofType: "plist") else {return}
        
        guard let array = NSArray(contentsOfFile: path) else {return}
        
        if array is [[String: Any]] {
            for i in (array as! [[String: Any]]) {
                省数据源.append(省数据结构(item: i))
            }
            
            市数据源 = 省数据源[0].cities
            县数据源 = 市数据源[0].areas
            
            省 = 省数据源[0].state
            市 = 市数据源[0].city
            县 = 县数据源[0].county
        }else {
            print("array is not [[string: any]]")
        }
    }
    
    private func setupUI(frame: CGRect) {
        
        let line2 = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 1))
        line2.backgroundColor = UIColor(hexColor: "EBEBEB")
        self.addSubview(line2)
        
        var f = pickerView.frame
        f.size.height = frame.height - 36
        pickerView.frame = f
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let btn = UIButton(frame: CGRect(x: screenWidth - 40, y: 8, width: 40, height: 20))
        btn.setTitle("完成", for: .normal)
        btn.setTitleColor(UIColor(hexColor: "1A1917"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(点击完成), for: .touchUpInside)
        self.addSubview(btn)
        
        let line = UIView(frame: CGRect(x: 0, y: 36, width: screenWidth, height: 1))
        line.backgroundColor = UIColor(hexColor: "EBEBEB")
        self.addSubview(line)
        
        self.addSubview(pickerView)
    }
    
    @objc private func 点击完成() {
        if let delegate = delegate {
            delegate.点击完成()
        }
    }
    
}

extension AddressPicker: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 省数据源.count
        }else if component == 1 {
            return 市数据源.count
        }else {
            return 县数据源.count
        }
    }
    

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        
        if component == 0 {
            label.text = 省数据源[row].state
        }else if component == 1 {
            label.text = 市数据源[row].city
        }else {
            label.text = 县数据源[row].county
        }
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch component {
        case 0:
            市数据源 = 省数据源[row].cities
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            
            县数据源 = 市数据源[0].areas
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            
            省 = 省数据源[row].state
            市 = 市数据源[0].city
            县 = 县数据源[0].county
            
            街道数据 = 县数据源[0].streets
        case 1:
            县数据源 = 市数据源[row].areas
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            
            市 = 市数据源[row].city
            县 = 县数据源[0].county
            
            街道数据 = 县数据源[0].streets
        default:
            
            县 = 县数据源[row].county
            街道数据 = 县数据源[row].streets
        }

        if let delegate = delegate {
            delegate.返回选中省(省, 市: 市, 县: 县, 街道们: 街道数据)
        }
    }
}
