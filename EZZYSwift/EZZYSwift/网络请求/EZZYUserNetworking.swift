//
//  EZZYUserNetworking.swift
//  EZZYSwift
//
//  Created by 彭懂 on 16/5/4.
//  Copyright © 2016年 彭懂. All rights reserved.
//

import Foundation

class EZZYUserNetworking: NSObject {
    
    /** 单例 */
    class var sharedUserNetworking: EZZYUserNetworking {
        struct SharedStruct {
            static var dispatchOnce: dispatch_once_t = 0
            static var sharedUsern: EZZYUserNetworking? = nil
        }
        dispatch_once(&SharedStruct.dispatchOnce) { 
            SharedStruct.sharedUsern = EZZYUserNetworking()
        }
        return SharedStruct.sharedUsern!
    }
    
    func sendUserLocation(userPhone phone: String, userLocation: CLLocationCoordinate2D) -> DSASubject {
        let subject: DSASubject = DSASubject()
        let serviceUrl = kHTTPService + getMemberLocation
        let dic: NSMutableDictionary = ["latitude": String(userLocation.latitude), "longitude": String(userLocation.longitude)]
        dic.addEntriesFromDictionary(TokenPrams as [NSObject : AnyObject])
        KKHttpServices.httpPostUrl(serviceUrl, prams: dic as [NSObject : AnyObject], success: { (operation, parse) in
                let parDic = parse.responseJsonOB
                subject.sendNext(parDic)
                subject.sendCompleted()
            }) { (parse) in
                subject.sendNext(nil)
                subject.sendCompleted()
        }
        return subject
    }
}