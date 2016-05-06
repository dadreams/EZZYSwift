//
//  EZZYAggregatRegionTool.swift
//  EZZYSwift
//
//  Created by 彭懂 on 16/5/5.
//  Copyright © 2016年 彭懂. All rights reserved.
//

import Foundation

class EZZYAggregatRegionTool: NSObject {
    // 范围控制
    var fanWeiStatus: Bool?
    // 自定义折线覆盖物点坐标数组
    var pointArr: NSArray?
    
    override init() {
        super.init()
        fanWeiStatus = NO
    }
    
    class var sharedECarFanWeiModel: EZZYAggregatRegionTool {
        struct ECarFanWeiModel {
            static var dispatchOnce: dispatch_once_t = 0
            static var aggregatRegionTool: EZZYAggregatRegionTool? = nil
        }
        dispatch_once(&ECarFanWeiModel.dispatchOnce) { 
            ECarFanWeiModel.aggregatRegionTool = EZZYAggregatRegionTool()
        }
        return ECarFanWeiModel.aggregatRegionTool!
    }
}
