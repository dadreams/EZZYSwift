//
//  EZZYConfigs.swift
//  EZZYSwift
//
//  Created by 彭懂 on 16/5/3.
//  Copyright © 2016年 彭懂. All rights reserved.
//

import Foundation


class EZZYConfigs: NSObject {
    
    var TokenID: String = ""
    
    /** 单例 */
    class var sharedUserNetworking: EZZYConfigs {
        struct SharedConfigStruct {
            static var configOnce: dispatch_once_t = 0
            static var sharedConfig: EZZYConfigs? = nil
        }
        dispatch_once(&SharedConfigStruct.configOnce) {
            SharedConfigStruct.sharedConfig = EZZYConfigs()
        }
        return SharedConfigStruct.sharedConfig!
    }
    
}

