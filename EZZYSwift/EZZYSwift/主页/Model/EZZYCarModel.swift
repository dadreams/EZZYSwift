//
//  EZZYCarModel.swift
//  EZZYSwift
//
//  Created by 彭懂 on 16/5/4.
//  Copyright © 2016年 彭懂. All rights reserved.
//

import Foundation

class EZZYCarModel: NSObject {
    
    var carNo: String?                          // 车牌号
    var lanYaName: String?                      // 蓝牙名称
    var lanYaServiceName: String?               // 蓝牙服务名称
    var lanYaWriteCharacteristiceName: String?  // 蓝牙写特性名称
    var lanYaNotifyCharacteristiceName: String? // 蓝牙通知特性名称
    var lanYaPassWord: String?                  // 蓝牙动态码
    var carId: String?                          // 车辆ID
    var carSN: String?                          // 车辆SN
    var carName: String?                        // 车辆名称
    var carMileage: String?                     // 车辆里程
    var carHeight: String?                      // 车辆海拔
    var carLongitude: String?                   // 车辆经度
    var carLatitude: String?                    // 车辆纬度
    var carVehicle:String?                      // 车辆型号
    var carDescription: String?                 // 车辆描述
    var carStatus: String?                      // 车辆状态
    var carLicense: String?                     // 车辆行驶证号
    var carDistance: String?                    // 车辆距离
    var carDuration: String?                    // 车辆续航
    var carLocationName: String?                // 车辆地点名称
    
    init(responseDic: NSDictionary) {
        super.init()
        
        let strLatitude: String = self.optionalToString(responseDic["latitude"])
        let strLongitude: String = self.optionalToString(responseDic["longitude"])
        self.carNo = self.optionalToString(responseDic["carno"])
        self.lanYaName = self.optionalToString(responseDic["bluetoothname"])
        self.lanYaServiceName = self.optionalToString(responseDic["bluetoothname"])
        self.lanYaWriteCharacteristiceName = self.optionalToString(responseDic["bluetoothname"])
        self.lanYaNotifyCharacteristiceName = self.optionalToString(responseDic["bluetoothname"])
        self.lanYaPassWord = self.optionalToString(responseDic["bluetoothpass"])
        self.carId = self.optionalToString(responseDic["id"])
        self.carName = self.optionalToString(responseDic["name"])
        self.carMileage = self.optionalToString(responseDic["Mileage"])
        self.carHeight = self.optionalToString(responseDic["altitude"])
        self.carLongitude = strLongitude
        self.carLatitude = strLatitude;
        self.carVehicle = self.optionalToString(responseDic["vehicleModel"])
        self.carDescription = self.optionalToString(responseDic["info"])
        self.carStatus = self.optionalToString(responseDic["status"])
        self.carLicense = self.optionalToString(responseDic["drivingLicense"])
        self.carDistance = self.optionalToString(responseDic["distance"])
        self.carDuration = self.optionalToString(responseDic["duration"])
        self.carLocationName = self.optionalToString(responseDic["bluetoothname"])
        
    }
    func optionalToString(str: AnyObject?) -> String! {
        if let eee = str {
            return String(eee)
        } else {
            return ""
        }
    }
}