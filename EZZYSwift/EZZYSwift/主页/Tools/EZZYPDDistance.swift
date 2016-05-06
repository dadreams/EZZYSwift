//
//  EZZYPDDistance.swift
//  EZZYSwift
//
//  Created by 彭懂 on 16/5/4.
//  Copyright © 2016年 彭懂. All rights reserved.
//

import Foundation

class EZZYPDDistance: NSObject {
    
    func isLocationNearToOtherLocation(oneLocation: CLLocationCoordinate2D, secondLocation: CLLocationCoordinate2D, distance: CLLocationDistance) -> Bool {
        var retVal: Bool = YES;
        let dis: CLLocationDistance = self.getDistance(oneLocation, secondLocation: secondLocation)
        if dis > distance {
            retVal = NO
        }
        return retVal
    }
    
    private func getDistance(firstLocation: CLLocationCoordinate2D, secondLocation: CLLocationCoordinate2D) -> CLLocationDistance {
        var distance: CLLocationDistance = 0
        let deltaLat: CLLocationDistance = firstLocation.latitude - secondLocation.latitude
        let deltaLon: CLLocationDistance = firstLocation.longitude - secondLocation.longitude
        distance = sqrt(deltaLat * deltaLat + deltaLon * deltaLon)
        return distance
    }
}
