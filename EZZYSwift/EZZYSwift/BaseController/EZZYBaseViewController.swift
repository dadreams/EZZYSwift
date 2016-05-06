//
//  EZZYBaseViewController.swift
//  EZZYSwift
//
//  Created by 彭懂 on 16/5/3.
//  Copyright © 2016年 彭懂. All rights reserved.
//

import Foundation
import UIKit

class EZZYBaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var hud: MBProgressHUD?
    private var titleText: UILabel?
    var custemTitle: String? {
        get {
            return self.titleText?.text
        }
        set {
            self.titleText?.text = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kWhiteColor
        self.navigationController?.interactivePopGestureRecognizer?.enabled = YES
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.createTitleLabel()
    }
    
    func createTitleLabel() {
        let titleLabel: UILabel = UILabel(frame: CGRectMake(0, 0, 150, 40))
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.font = kFontTitleNormal
        titleLabel.textAlignment = NSTextAlignment.Center
        self.navigationItem.titleView = titleLabel
        self.titleText = titleLabel
    }
    
    /**
     浮出提示框
     */
    func showHUD(text: String) {
        if self.hud == nil {
            self.hud = MBProgressHUD(view: self.view)
            self.hud?.animationType = MBProgressHUDAnimation.Fade
            self.view.addSubview(self.hud!)
        }
        self.hud?.labelText = text
        self.hud?.show(YES)
    }
    
    func hideHUD() {
        MBProgressHUD.hideAllHUDsForView(self.view, animated: YES)
        self.hud = nil
    }
    
    func delayHidHUD(text: String) {
        if self.hud == nil {
            self.hud = MBProgressHUD(view: self.view)
            self.hud?.mode = MBProgressHUDMode.Text
            self.view.addSubview(self.hud!)
        }
        self.hud?.labelText = text
        self.hud?.show(YES)
        self.hud?.hide(YES, afterDelay: 2)
    }
}
