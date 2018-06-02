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

    private var 省数据源 = [省数据结构]()
    private var 市数据源 = [市数据结构]()
    private var 县数据源 = [县数据结构]()
    var 街道数据 = [String]()
    
    private let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 0))
    
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
        }else {
            print("array is not [[string: any]]")
        }
    }
    
    private func setupUI(frame: CGRect) {
        var f = pickerView.frame
        f.size.height = frame.height
        pickerView.frame = f
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        self.addSubview(pickerView)
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
            
            街道数据 = 县数据源[0].streets
        case 1:
            县数据源 = 市数据源[row].areas
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            
            街道数据 = 县数据源[0].streets
        default:
            街道数据 = 县数据源[row].streets
        }
        
       
        
    }
}
