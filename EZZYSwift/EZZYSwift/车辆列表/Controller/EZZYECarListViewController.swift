//
//  EZZYECarListViewController.swift
//  EZZYSwift
//
//  Created by 彭懂 on 16/5/6.
//  Copyright © 2016年 彭懂. All rights reserved.
//

import Foundation
import UIKit

class EZZYECarListViewController: EZZYBaseShowNavViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectBtn: PDSelectedBtnControl?
    var page: Int = 0
    var netManager: EZZYCarNetworking = EZZYCarNetworking.sharedNetworking
    var tableView: UITableView = UITableView.init(frame: CGRectZero, style: UITableViewStyle.Plain)
    var dataList: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = NO
        self.custemTitle = "车辆列表"
    }
    
    func createViewUI() {
        let buttonView: UIView = UIView(frame: CGRectMake(0, 64, kScreenW, 43))
        self.view.addSubview(buttonView)
        
        let itemsAr: NSArray = ["距离", "续航", "步行时间"]
        let segment: PDSelectedBtnControl = PDSelectedBtnControl(items: itemsAr, frame: CGRectMake(kScreenW / 5.0  + 5, 4, kScreenW / 4 * 3, 43))
        segment.addTarget(self, action: #selector(self.segmentAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        segment.selectedIndex = 0
        buttonView.addSubview(segment)
        
        let viewRed: UIView = UIView(frame: CGRectMake(0, buttonView.bounds.size.height - 1, kScreenW, 1))
        viewRed.backgroundColor = kGrayColor
        buttonView.addSubview(viewRed)
        
        self.tableView.frame = CGRectMake(0, buttonView.bottom, kScreenW, kScreenH - 64 - buttonView.height)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.backgroundColor = kWhiteColor
        self.view.addSubview(self.tableView)
        self.tableView.registerNib(UINib.init(nibName: "EZZYCarListTableViewCell", bundle: nil), forCellReuseIdentifier: "CarListTableViewCell")
        self.tableView.addHeaderWithTarget(self, action: #selector(self.headerRefreshing))
    }
    
    func segmentAction(segment: PDSelectedBtnControl) {
        
    }
    
    // 网络请求数据
    func headerRefreshing() {
        self.page = 0
    }
    
    func footerRefreshing() {
        self.page += 1
    }
    
    /**
      UITableViewDelegate 代理方法
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: EZZYCarListTableViewCell = tableView.dequeueReusableCellWithIdentifier("CarListTableViewCell") as! EZZYCarListTableViewCell
        cell.contentView.backgroundColor = kWhiteColor
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
}