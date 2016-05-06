//
//  EZZYBaseViewController.swift
//  EZZYSwift
//
//  Created by 彭懂 on 16/5/3.
//  Copyright © 2016年 彭懂. All rights reserved.
//

import Foundation
import UIKit

class EZZYBaseViewController: UIViewController {
    
    var hud: MBProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kWhiteColor
    }
    
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
