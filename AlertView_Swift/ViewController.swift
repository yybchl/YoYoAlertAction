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
        let alertView = YoYoAlertView()
        alertView.showAlert("消息提醒", message: "苹果与SAP达成全新企业业务合作将带来“革命性”移动工作体验", cancelButtonTitle: "取 消", sureButtonTitle: "确 定")
        alertView.clickIndexClosure { (index) in
            print("点击了第" + "\(index)" + "个按钮")
        }
    }
    //显示sheet
    @IBAction func showSheetAction(sender: AnyObject) {
        let vc = UIActionSheet(title: "选择", delegate: nil, cancelButtonTitle: "取消", destructiveButtonTitle: "确定", otherButtonTitles: "1", "2")
        vc.showInView(self.view)
//        let companySheet = YoYoActionSheet(title: "选择", cancelButtonTitle: "取消", buttonTitles: ["1", "2", "3"])
//        companySheet.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

