//
//  EZZYCarNetWroking.swift
//  EZZYSwift
//
//  Created by 彭懂 on 16/5/4.
//  Copyright © 2016年 彭懂. All rights reserved.
//

import Foundation

class EZZYCarNetworking: NSObject {
    
    /**  
        单例
     */
    class var sharedNetworking: EZZYCarNetworking {
        struct Staticd {
            static var onceToken: dispatch_once_t = 0
            static var netWorking: EZZYCarNetworking? = nil
        }
        dispatch_once(&Staticd.onceToken) { 
            Staticd.netWorking = EZZYCarNetworking()
        }
        return Staticd.netWorking!
    }
    
    /**
        获取车辆
     */
    func findNearCars(UserCoordinate userCoordinate: CLLocationCoordinate2D, UserDestination destination: CLLocationCoordinate2D, isAll: Bool) -> (DSASubject) {
        let subject: DSASubject = DSASubject()
        var yonghuId: String
        if let yonhu = NSUserDefaults.standardUserDefaults().objectForKey("phone") {
            yonghuId = yonhu as! String
        } else {
            yonghuId = ""
        }
        var dic: NSDictionary
        var serviceUrl: String
        if isAll == YES {
            dic = ["longitude": String(userCoordinate.longitude), "latitude": String(userCoordinate.latitude), "phone": yonghuId]
            serviceUrl = kHTTPService + allCarToMapView
        } else {
            dic = ["longitude": String(userCoordinate.longitude), "latitude": String(userCoordinate.latitude), "Terminilongitude": String(destination.longitude), "Terminilatitude": String(destination.latitude), "phone": yonghuId]
            serviceUrl = kHTTPService + nearCarToMapView
        }
        KKHttpServices.httpPostUrl(serviceUrl, prams: dic as [NSObject : AnyObject], success: { (operation: AFHTTPRequestOperation!, parse:KKHttpParse!) in
            let carAry: NSMutableArray = NSMutableArray()
            let parseDic: NSDictionary = parse.responseJsonOB
            let objArr = parseDic.mutableArrayValueForKey("obj")
            for objDic in objArr {
                if let carInfo: NSDictionary = objDic as? NSDictionary {
                    let carModel: EZZYCarModel = EZZYCarModel(responseDic: carInfo)
                    carAry.addObject(carModel)
                }
            }
            subject.sendNext(carAry)
            subject.sendCompleted()
        }) { (parse) in
            subject.sendError(nil)
            subject.sendCompleted()
        }
        return subject
    }
    
    /**
     *  范围控制（自定义不规则范围控制）
     */
    func getZiDingYiOperationRigion(version: String) -> DSASubject {
        let subject: DSASubject = DSASubject()
        let dic: NSDictionary = ["version": version]
        let serviceUrl: String = kHTTPService + getOperationRigion
        KKHttpServices.httpPostUrl(serviceUrl, prams: dic as [NSObject : AnyObject], success: { (operation, parse) in
                let parseDic: NSDictionary = parse.responseJsonOB
                subject.sendNext(parseDic)
                subject.sendCompleted()
            }) { (error) in
                subject.sendError(nil)
                subject.sendCompleted()
        }
        return subject
    }
}
