//
//  通用PickerView.swift
//  AddressPicker
//
//  Created by 每天农资 on 2018/6/2.
//  Copyright © 2018年 我是五高你敢信. All rights reserved.
//

import UIKit

protocol 通用PickerViewDelegate: class {
    func 点击完成(text: String)
    
    func 返回数据(text: String)
}

class 通用PickerView: UIView {

    private let pickerView = UIPickerView(frame: CGRect(x: 0, y: 25, width: screenWidth, height: 0))
    
    var dataSource = [String]() {
        didSet {
            pickerView.reloadAllComponents()
            if dataSource.count > 0 {
                pickerView.selectRow(0, inComponent: 0, animated: true)
                text = dataSource[0]
            }
        }
    }
    
    weak var delegate: 通用PickerViewDelegate?
    
    var text = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        setupUI(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dismiss() {
        点击完成()
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
        
        let btn = UIButton(frame: CGRect(x: screenWidth - 100, y: 3, width: 100, height: 30))
        btn.setTitle("完成", for: .normal)
        btn.setTitleColor(UIColor(hexColor: "1A1917"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(点击完成), for: .touchUpInside)
        self.addSubview(btn)
        
        let line = UIView(frame: CGRect(x: 0, y: 36, width: screenWidth, height: 1))
        line.backgroundColor = UIColor(hexColor: "EBEBEB")
        self.addSubview(line)
        
        self.addSubview(pickerView)
    }

    @objc private func 点击完成() {
        if let delegate = delegate {
            delegate.点击完成(text: text)
        }
    }
    
    deinit {
        print("三级联动选择地址pickerView被销毁了")
    }
}

extension 通用PickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return dataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        text = dataSource[row]
        if let delegate = delegate {
            delegate.返回数据(text: text)
        }
    }
}
