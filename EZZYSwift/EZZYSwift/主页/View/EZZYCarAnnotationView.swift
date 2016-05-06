//
//  EZZYCarAnnotationView.swift
//  EZZYSwift
//
//  Created by 彭懂 on 16/5/4.
//  Copyright © 2016年 彭懂. All rights reserved.
//

import Foundation

typealias ShowCarDetailView = (carModel: EZZYCarModel) -> ()
typealias HiddenCarDetailView = () -> ()
typealias SacelMapView = () -> ()

class EZZYCarAnnotationView: MAAnnotationView {

    var showCarDetailView: ShowCarDetailView?
    var hiddenCarDetailView: HiddenCarDetailView?
    var sacelMapView: SacelMapView?
    var carDetailModel: EZZYCarModel?
    var carNum: Int?
    
    var carCount: Int {
        get {
            return self.carNum!
        }
        set {
            self.carNum = newValue
            self.image = UIImage(named: "cheweizhi\(newValue)")
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        if self.selected == selected {
            return;
        }
        if selected == YES {
            if self.carNum > 1 {
                if let sacelView = self.sacelMapView {
                    sacelView()
                }
                return;
            }
            if let showCarView = self.showCarDetailView {
                showCarView(carModel: self.carDetailModel!)
            }
        } else {
            if let hiddenCarView = self.hiddenCarDetailView {
                hiddenCarView()
            }
        }
        super.setSelected(selected, animated: animated)
    }
    
}

