//
//  EZZYBaseShowNav.swift
//  EZZYSwift
//
//  Created by 彭懂 on 16/5/3.
//  Copyright © 2016年 彭懂. All rights reserved.
//

import Foundation

class EZZYBaseHiddenNav: EZZYBaseViewController {
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(NO, animated: NO)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(YES, animated: NO)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}