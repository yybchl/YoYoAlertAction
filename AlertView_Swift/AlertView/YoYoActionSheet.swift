//
//  YoYoActionSheet.swift
//  AlertView_Swift
//
//  Created by YoYo on 16/5/6.
//  Copyright © 2016年 cn.yoyoy.mw. All rights reserved.
//

import UIKit

class YoYoActionSheet: UIView {
    
    typealias clickSheetClosure = (index: Int) -> Void //声明闭包，点击按钮传值
    //把申明的闭包设置成属性
    var clickClosure: clickSheetClosure?
    //为闭包设置调用函数
    func clickIndexClosure(closure:clickSheetClosure?){
        //将函数指针赋值给myClosure闭包
        clickClosure = closure
    }
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
        if title != nil && title != "" { //是否添加标题
            num += 1
            //加标题
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: screen_width - 12, height: 50))
            titleLabel.textAlignment = .Center
            titleLabel.text = title
            titleLabel.textColor = UIColor.grayColor()
            titleLabel.font = UIFont.systemFontOfSize(15)
            backGroundView.addSubview(titleLabel)
        }
        if cancelButtonTitle != nil && cancelButtonTitle != "" {
            num += 1
        }
        let height = 50 * (buttonTitles!.count + num)
        backGroundView.frame = CGRect(x: 6, y: screen_height, width: screen_width - 12, height: CGFloat(height))
        backGroundView.backgroundColor = UIColor.whiteColor()
        backGroundView.layer.cornerRadius = 4
        backGroundView.clipsToBounds = true
        backGroundView.layer.shadowColor = UIColor.lightGrayColor().CGColor
        backGroundView.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
        self.addSubview(backGroundView)
        
        //添加按键
        for index in 0..<buttonTitles!.count {
            let btn = SheetButton(frame: CGRect(x: 0, y: 50 * CGFloat(index + (title == nil || title == "" ? 0 : 1)), width: screen_width - 12, height: 50))
            btn.addTarget(self, action:  #selector(self.actionSheetButton(_:)), forControlEvents: .TouchUpInside)
            btn.addTarget(self, action:  #selector(self.actionSheetDowmAction(_:)), forControlEvents: .TouchDown)
            btn.tag = index + 1
            btn.setTitle(buttonTitles![index], forState: .Normal)
            btn.setTitleColor(UIColor.grayColor(), forState: .Normal)
            backGroundView.addSubview(btn)
        }
        // cancelButton
        if cancelButtonTitle != nil && cancelButtonTitle != "" { //是否添加取消按钮
            let cancelBtn = UIButton(frame: CGRectMake(8, CGFloat(height) - 44, screen_width - 28, 38))
            cancelBtn.addTarget(self, action: #selector(self.actionSheetButton(_:)), forControlEvents: .TouchUpInside)
            cancelBtn.addTarget(self, action:  #selector(self.actionSheetDowmAction(_:)), forControlEvents: .TouchDown)
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
        if (clickClosure != nil) {
            clickClosure!(index: sender.tag)
        }
        dismiss()
    }
    
    func actionSheetDowmAction(sender:UIButton) {
        if sender.tag == 0 {
            sender.alpha = 0.6
            return
        }
        sender.backgroundColor = UIColor.orangeColor()
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
class SheetButton: UIButton {
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineCap(context, CGLineCap.Round
        );
        CGContextSetLineWidth(context, 0.5);  //线宽
        CGContextSetAllowsAntialiasing(context, true);
        CGContextSetRGBStrokeColor(context, 220.0 / 255.0, 220.0 / 255.0, 220.0 / 255.0, 1.0);  //线的颜色
        CGContextBeginPath(context);
        
        CGContextMoveToPoint(context, 0, self.frame.size.height - 0.5);  //起点坐标
        CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height - 0.5);   //终点坐标
        
        CGContextStrokePath(context);
    }
}
