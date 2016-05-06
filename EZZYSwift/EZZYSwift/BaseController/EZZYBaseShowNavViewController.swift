//
//  EZZYBaseShowNavViewController.swift
//  EZZYSwift
//
//  Created by 彭懂 on 16/5/6.
//  Copyright © 2016年 彭懂. All rights reserved.
//

import Foundation

class EZZYBaseShowNavViewController: EZZYBaseViewController, UIAlertViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createNaviBtn()
    }
    
    func createNaviBtn() {
        let liftBtn: UIButton = UIButton.init(type: UIButtonType.Custom)
        liftBtn.frame = CGRectMake(0, -10, 30, 30)
        liftBtn.setImage(UIImage(named: "fanhui9*14"), forState: UIControlState.Normal)
        liftBtn.addTarget(self, action: #selector(self.liftBtnClicked), forControlEvents: UIControlEvents.TouchUpInside)
        liftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0)
        let liftBarItem: UIBarButtonItem = UIBarButtonItem.init(customView: liftBtn)
        self.navigationItem.leftBarButtonItem = liftBarItem
        
        let rightBtn: UIButton = UIButton.init(type: UIButtonType.Custom)
        rightBtn.frame = CGRectMake(0, 0, 30, 30)
        rightBtn.setImage(UIImage(named: "lianxikefu16*17"), forState: UIControlState.Normal)
        rightBtn.addTarget(self, action: #selector(self.rightBtnClicked), forControlEvents: UIControlEvents.TouchUpInside)
        rightBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        let riGHT: UIBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = riGHT
    }
    
    func rightBtnClicked() {
        let alert: UIAlertView = UIAlertView.init(title: "联系客服", message: "400-6507265", delegate: self, cancelButtonTitle: "呼叫", otherButtonTitles: "取消")
        alert.tag = 400
        alert.show()
    }
    
    func liftBtnClicked() {
        self.navigationController?.popViewControllerAnimated(YES)
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 400 {
            if buttonIndex == 0 {
                ToolKit.callTelephoneNumber("400-6507265", addView: self.view)
            }
        }
    }
}
