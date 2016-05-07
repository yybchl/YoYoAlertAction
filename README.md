# YoYoAlertAction
##swift提示选择框
调用简单,点击事件使用闭包处理，不需要添加代理<br>
AlertView使用方法
```Swift
        //AlertView
        let alertView = YoYoAlertView(title: "消息提醒", message: "苹果与SAP达成全新企业业务合作将带来“革命性”移动工作体验", cancelButtonTitle: "取 消", sureButtonTitle: "确 定")
        alertView.show()
        //获取点击事件
        alertView.clickIndexClosure { (index) in
            print("点击了第" + "\(index)" + "个按钮")
        }
```
ActionSheet使用方法
```swift
        //ActionSheet,标题和取消按钮不传值不会添加到选择面板上
        let sheetView = YoYoActionSheet(title: "标题", cancelButtonTitle: "取消", buttonTitles: ["选择1", "选择2", "选择3"])
        sheetView.show()
        //获取点击事件
        sheetView.clickIndexClosure { (index) in
            if index == 0 {
                print("点击了取消按钮")
            }else {
                print("点击了按钮" + "\(index)")
            }
        }
```
