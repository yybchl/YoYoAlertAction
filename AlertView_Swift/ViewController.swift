//
//  ViewController.swift
//  AlertView_Swift
//
//  Created by YoYo on 16/5/6.
//  Copyright © 2016年 cn.yoyoy.mw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //显示alert
    @IBAction func showAction(sender: AnyObject) {
        let alertView = YoYoAlertView(title: "消息提醒", message: "苹果与SAP达成全新企业业务合作将带来“革命性”移动工作体验", cancelButtonTitle: "取 消", sureButtonTitle: "确 定")
        alertView.show()
        //获取点击事件
        alertView.clickIndexClosure { (index) in
            print("点击了第" + "\(index)" + "个按钮")
        }
    }
    //显示sheet
    @IBAction func showSheetAction(sender: AnyObject) {
        //标题和取消按钮不传值不会添加到选择面板上
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

