# AddressPicker
三级联动 带第四级街道地址选择

## 安装
-直接把AddressPicker.swift.swift文件拖进工程，还有UIColor+Extension.swift文件拖入工程

## 使用
init方法创建，并且设置delegate
``` swift
let a = AddressPicker(frame: CGRect(x: 0, y: screenHeight - 200, width: screenWidth, height: 200))
a.delegate = self
view.addSubview(a)
```

实现AddressPickerDelegate协议方法
``` swift
extension ViewController: AddressPickerDelegate {
    func 点击完成(_ 省: String, 市: String, 县: String, 街道们: [String]) {

    }
    func 返回选中省(_ 省: String, 市: String, 县: String, 街道们: [String]) {
        print(街道们)
        b.text = "\(省)\(市)\(县)"
    }
}
```

-------------
添加默认地址
``` swift
a.设置省市县("河南省", 市: "洛阳市", 县: "西工区")
```
返回值是街道数组
