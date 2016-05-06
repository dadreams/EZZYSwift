//
//  PDSelectedBtn.swift
//  EZZYSwift
//
//  Created by 彭懂 on 16/5/6.
//  Copyright © 2016年 彭懂. All rights reserved.
//

import Foundation
import UIKit

class PDSelectedBtnControl: UIControl {
    var items: NSArray
    private var selIndex: Int?
    
    var currentStates: ArroStates?
    private var allItems: NSMutableArray
    
    var selectedIndex: Int? {
        get {
            return self.selIndex
        }
        set {
            self.selIndex = newValue
            for j in 0 ..< self.allItems.count {
                let itemV: UIView = allItems[j] as! UIView
                if let titleL: UILabel = itemV.viewWithTag(2013) as? UILabel {
                    if let arrowV: PDArrowView = itemV.viewWithTag(2014) as? PDArrowView {
                        if j == selectedIndex {
                            titleL.textColor = kRedColor
                            arrowV.isSelected = YES
                        } else {
                            titleL.textColor = UIColor.blackColor()
                            arrowV.isSelected = NO
                        }
                    }
                }
            }
        }
    }
    
    init(items: NSArray, frame: CGRect) {
        self.items = items
        self.allItems = NSMutableArray.init(capacity: items.count)
        super.init(frame: frame)
        
        self.initAllViews(items)
    }
    
    func initAllViews(itemsArr: NSArray) {
        for i in 0 ..< itemsArr.count {
            let itemName: String = itemsArr[i] as! String
            let itemView: UIView = UIView(frame:CGRectMake((CGFloat(i) * (50.0 + 10.0)) / 320.0 * kScreenW, 0, 50, 35))
            if i == 2 {
                itemView.frame = CGRectMake((CGFloat(i) * (50.0 + 5.0))/320.0 * kScreenW, 0, 50 + 30, 35)
            }
            let titleLabel: UILabel = UILabel(frame: itemView.bounds)
            titleLabel.textAlignment = NSTextAlignment.Center
            titleLabel.font = kFontSizeMin
            titleLabel.textColor = UIColor.blackColor()
            titleLabel.text = itemName
            titleLabel.tag = 2013
            itemView.addSubview(titleLabel)
            
            let arrowView: PDArrowView = PDArrowView.init(frame: CGRectMake(40, 10, 16, 16))
            if i == 2 {
                arrowView.frame = CGRectMake(50+20, 10, 16, 16)
            }
            weak var weakSelf: PDSelectedBtnControl? = self
            arrowView.block = { states in
                weakSelf?.currentStates = states
            }
            arrowView.tag = 2014
            if i == 0 {
                arrowView.isSelected = YES
            }
            itemView.addSubview(arrowView)
            
            self.addSubview(itemView)
            self.allItems.addObject(itemView)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch: UITouch = touches.first {
            let point: CGPoint = touch.locationInView(self)
            let width: CGFloat = 70
            let index: Int = Int(point.x / width)
            self.selectedIndex = index
            self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}