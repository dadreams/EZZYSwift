//
//  Header.swift
//  EZZYSwift
//
//  Created by 彭懂 on 16/5/3.
//  Copyright © 2016年 彭懂. All rights reserved.
//

import Foundation
import UIKit

/**
 *  重写bool判断
 */
let YES = true
let NO = false

/**
 *  屏幕宽和高
 */
let kScreenW: CGFloat = UIScreen.mainScreen().bounds.size.width
let kScreenH: CGFloat = UIScreen.mainScreen().bounds.size.height

/**
 *  app颜色统一
 */
let kWhiteColor : UIColor =  UIColor(red: 249.0 / 255.0, green: 249.0 / 255.0, blue: 249.0 / 255.0, alpha: 1.0)
let kRedColor   : UIColor =  UIColor(red: 224.0 / 255.0, green: 54.0 / 255.0, blue: 134.0 / 255.0, alpha: 1.0)
let kBlackColor : UIColor =  UIColor(red: 5.0 / 255.0, green: 5.0 / 255.0, blue: 5.0 / 255.0, alpha: 1.0)
let kGrayColor  : UIColor = UIColor(red: 197.0 / 255.0, green: 197.0 / 255.0, blue: 197.0 / 255.0, alpha: 1.0)
let kClearColor : UIColor =  UIColor.clearColor()

/**
 *  字体统一
 */
let kFontSizeMax    : UIFont = UIFont.systemFontOfSize(23.0 / 667.0 * kScreenH)
let kFontSizeMiddle : UIFont = UIFont.systemFontOfSize(17.0 / 667.0 * kScreenH)
let kFontSizeMin    : UIFont = UIFont.systemFontOfSize(12.0 / 667.0 * kScreenH)
let kFontNomal      : UIFont = UIFont.systemFontOfSize(15.0 / 667.0 * kScreenH)

/**
 *  高德地图配置
 */
let kAMapNaviApiKey = "2fca9ee9881d8dbfb6e8ec87ac2f807f"

/**
 *  网络请求
 */
let kHTTPService: String = "http://101.201.196.43:9888/"
let kNetworkingError = "网络异常，加载失败"

/**
 *  配置
 */
let TokenPrams: NSDictionary = ["tokenid": EZZYConfigs.sharedUserNetworking.TokenID]














