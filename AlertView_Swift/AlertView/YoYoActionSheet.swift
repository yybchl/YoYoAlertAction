//
//  YoYoActionSheet.swift
//  AlertView_Swift
//
//  Created by YoYo on 16/5/6.
//  Copyright © 2016年 cn.yoyoy.mw. All rights reserved.
//

import UIKit

class YoYoActionSheet: UIView {
    
    let screen_width = UIScreen.mainScreen().bounds.size.width
    let screen_height = UIScreen.mainScreen().bounds.size.height
    let backGroundView = UIView() //背景视图
    let tap = UITapGestureRecognizer() //手势

    init(title: String?, cancelButtonTitle: String?, buttonTitles: [String]?) {
        super.init(frame: CGRect(x: 0, y: 0, width: screen_width, height: screen_height))
        if buttonTitles == nil || buttonTitles?.count == 0 {
            return
        }
        // 自定义一个actionsheet
        self.frame = CGRect(x: 0, y: 0, width: screen_width, height: screen_height)
        self.backgroundColor = UIColor(white: 0, alpha: 0)
        // 添加手势
        tap.addTarget(self, action: #selector(self.removeWindowsView(_:)))
        self.addGestureRecognizer(tap)
        //选择视图
        var num = 0
        if title != nil && title != "" {
            num += 1
            //加标题
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: screen_width, height: 45))
            titleLabel.textAlignment = .Center
            titleLabel.text = title
            titleLabel.font = UIFont.systemFontOfSize(18)
            backGroundView.addSubview(titleLabel)
        }
        if cancelButtonTitle != nil && cancelButtonTitle != "" {
            num += 1
        }
        let height = 45 * (buttonTitles!.count + num)
        backGroundView.frame = CGRect(x: 6, y: screen_height, width: screen_width - 12, height: CGFloat(height))
        backGroundView.backgroundColor = UIColor.whiteColor()
        backGroundView.layer.cornerRadius = 4
        backGroundView.clipsToBounds = true
        backGroundView.layer.shadowColor = UIColor.lightGrayColor().CGColor
        backGroundView.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
        self.addSubview(backGroundView)
        
        //添加按键
        for index in 0..<buttonTitles!.count {
            let btn = UIButton(frame: CGRect(x: 0, y: 45 * CGFloat(index + 1), width: screen_width - 12, height: 45))
            btn.addTarget(self, action:  #selector(self.actionSheetButton(_:)), forControlEvents: .TouchUpInside)
            btn.addTarget(self, action:  #selector(self.actionSheetDowmAction(_:)), forControlEvents: .TouchDown)
            btn.tag = index + 2
            btn.setTitle(buttonTitles![index], forState: .Normal)
            if index == 0 {
                btn.setTitleColor(UIColor.orangeColor(), forState: .Normal)
            }else {
                btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            }
            backGroundView.addSubview(btn)
            //加线
            let line = UIView(frame: CGRect(x: 0, y: 44, width: btn.frame.size.width, height: 1))
            line.backgroundColor = UIColor.groupTableViewBackgroundColor()
            btn.addSubview(line)
            
        }
        // cancelButton
        if cancelButtonTitle != nil && cancelButtonTitle != "" {
            let cancelBtn = UIButton(frame: CGRectMake(8, CGFloat(height) - 42, screen_width - 28, 39))
            cancelBtn.addTarget(self, action: #selector(self.actionSheetButton(_:)), forControlEvents: .TouchUpInside)
            cancelBtn.tag = 1
            cancelBtn.layer.cornerRadius = 3
            cancelBtn.clipsToBounds = true
            cancelBtn.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
            cancelBtn.layer.borderWidth = 1
            cancelBtn.setTitleColor(UIColor.redColor(), forState: .Normal)
            cancelBtn.backgroundColor = UIColor.groupTableViewBackgroundColor()
            cancelBtn.setTitle(cancelButtonTitle, forState: .Normal)
            backGroundView.addSubview(cancelBtn)
        }
        
    }
    
    func actionSheetButton(sender:UIButton) {
        dismiss()
    }
    
    func actionSheetDowmAction(sender:UIButton) {
        sender.setTitleColor(UIColor.orangeColor(), forState: .Normal)
    }
    
    func removeWindowsView(thetap:UITapGestureRecognizer) {
        dismiss()
    }
    
    func show() {
        UIApplication.sharedApplication().windows[0].addSubview(self)
        UIView.animateWithDuration(0.25, animations: { 
            self.backGroundView.frame = CGRect(x: 6, y: self.screen_height -  self.backGroundView.frame.size.height - 8, width: self.screen_width - 12, height: self.backGroundView.frame.size.height)
            self.backgroundColor = UIColor(white: 0, alpha: 0.2)
            })
    }
    
    func dismiss() {
        UIView.animateKeyframesWithDuration(0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { 
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1/2.0, animations: {
                self.backGroundView.frame = CGRect(x: self.backGroundView.frame.origin.x, y: self.screen_height, width: self.backGroundView.frame.size.width, height: self.backGroundView.frame.size.height)
            })
            UIView.addKeyframeWithRelativeStartTime(1/2.0, relativeDuration: 1/2.0, animations: { 
                self.backgroundColor = UIColor(white: 0, alpha: 0)
            })
            }) { (finished) in
                self.backGroundView.removeFromSuperview()
                self.removeFromSuperview()
                self.removeGestureRecognizer(self.tap)
                self.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
