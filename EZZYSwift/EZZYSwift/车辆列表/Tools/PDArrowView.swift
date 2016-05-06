//
//  PDArrowView.swift
//  EZZYSwift
//
//  Created by 彭懂 on 16/5/6.
//  Copyright © 2016年 彭懂. All rights reserved.
//

import Foundation
import UIKit

enum ArroStates: Int {
    case UPStates = 0, DownStates = 1
}
typealias StateHadChangeBlock = (state: ArroStates) -> ()
class PDArrowView: UIImageView {
    
    private var Pstates: ArroStates?
    private var selected: Bool?
    
    var isSelected: Bool? {
        get {
            return self.selected
        }
        set {
            self.selected = newValue
            if newValue == YES {
                if self.Pstates == ArroStates.UPStates {
                    self.states = ArroStates.DownStates
                } else {
                    self.states = ArroStates.UPStates
                }
            } else {
                self.states = self.Pstates
            }
        }
    }
    var states: ArroStates? {
        get {
            return self.Pstates
        }
        set {
            if newValue != self.Pstates {
                self.Pstates = newValue
            }
            if self.isSelected == YES {
                if self.Pstates == ArroStates.UPStates {
                    self.image = UIImage(named: "up_red")
                } else if self.Pstates == ArroStates.DownStates {
                    self.image = UIImage(named: "down_red")
                }
            } else {
                if self.Pstates == ArroStates.UPStates {
                    self.image = UIImage(named: "up_white")
                } else if self.Pstates == ArroStates.DownStates {
                    self.image = UIImage(named: "down_white")
                }
            }
        }
    }
    var block: StateHadChangeBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.states = ArroStates.UPStates
        self.image = UIImage(named: "up_white")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}