//
//  EZZYMainViewController.swift
//  EZZYSwift
//
//  Created by 彭懂 on 16/5/3.
//  Copyright © 2016年 彭懂. All rights reserved.
//

import Foundation
import UIKit

var timeString: String?
var beginTimeStr: String?
var endTimeStr: String?

class EZZYMainViewController: EZZYBaseHiddenNav, MAMapViewDelegate, UIAlertViewDelegate {
    
    private enum PopoverAlertType: Int {
        case one = 325, two, three
    }
    
    /** 地图 */
    var mapView: MAMapView!
    /** 车辆位置大头针 */
    var ezzyAnnotations = [EZZYAnnotation]()
    /** 导航管理类 */
    var naviManager: AMapNaviManager?
//    /** 车辆大头针数组*/
//    var carAnnotations: NSMutableArray?
    /** 用户位置 */
    var userLocation: CLLocationCoordinate2D?
    /** 用户目的地位置 */
    var userDestination: CLLocationCoordinate2D?
    /** 地图缩放大小 */
    var mapSalcus: CGFloat?
    /** 地图运营范围数组 */
    var polyArray: [PDPolygon]?
    
    /** UI */
    var mudiLabel: UILabel?
    
    /** 网络请求管理类 */
    var networkingManager: EZZYCarNetworking = EZZYCarNetworking.sharedNetworking
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化配置
        self.initConfig()
        // 配置地图
        self.configMapView()
        // 配置导航
        self.configMapNaviView()
        // 创建UI
        self.createMainUI()
    }
    
    /**
     初始化配置
     */
    func initConfig() {
        self.userLocation = CLLocationCoordinate2DMake(39.90815613, 116.3973999)
        self.userDestination = CLLocationCoordinate2DMake(0, 0)
        self.polyArray = Array()
        self.checkedIsOpenGPS()
    }
    
    /**
     检测是否打开GPS
     */
    func checkedIsOpenGPS() {
        if CLLocationManager.locationServicesEnabled() && CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Denied {
            let alerView: UIAlertView = UIAlertView(title: nil, message: "为方便您尽快找到目标车辆，请打开GPS。", delegate: nil, cancelButtonTitle: "确认")
            alerView.show()
        }
    }
    
    /**
     配置地图
     */
    func configMapView() {
        
        self.mapView = MAMapView(frame: self.view.bounds)
        self.mapView.delegate = self
        self.view.insertSubview(self.mapView, atIndex: 0)
        self.mapView.customizeUserLocationAccuracyCircleRepresentation = YES
        self.mapView.setUserTrackingMode(MAUserTrackingMode.Follow, animated: YES)
        self.mapView.showsUserLocation = YES
        self.mapView.setZoomLevel(1, animated: NO)
        self.mapView.showsScale = NO
        self.mapView.showsCompass = NO
        self.mapView.distanceFilter = 5.0
        self.mapView.skyModelEnable = NO
        self.mapView.rotateCameraEnabled = NO
        
        self.getOperationRegionFromNetworking()
        
    }
    
    /**
     创建UI
     */
    func createMainUI() {
        // 底部图层
        let bottomView: UIView = UIView(frame: CGRectMake(50 / 375.0 * kScreenW, kScreenH - 108, kScreenW - 100 / 375.0 * kScreenW, 90))
        bottomView.alpha = 0.8
        self.view.addSubview(bottomView)
        
        // 底图图片
        let dituImage: UIImageView = UIImageView(frame: bottomView.bounds)
        dituImage.image = UIImage(named: "di273*89")
        bottomView.addSubview(dituImage)
        
        // 目的地输入UI
        let sousuoImage: UIImageView = UIImageView(frame: CGRectMake(0, 0, 21, 21))
        sousuoImage.center = CGPointMake(28, 22)
        sousuoImage.image = UIImage(named: "sousuohuise21*21")
        bottomView.addSubview(sousuoImage)
        
        let mudiLa: UILabel = UILabel(frame: CGRectMake(CGRectGetMaxX(sousuoImage.frame) + 7, 0, bottomView.bounds.size.width - CGRectGetMaxX(sousuoImage.frame) - 7, 45))
        mudiLa.textColor = kGrayColor
        mudiLa.text = "输入目的地"
        mudiLa.font = kFontNomal
        self.mudiLabel = mudiLa
        bottomView.addSubview(mudiLa)
        
        let mudiBtn: UIButton = UIButton(type: UIButtonType.Custom)
        mudiBtn.frame = CGRectMake(0, 0, kScreenW - 30, 49)
        mudiBtn.addTarget(self, action: #selector(mudidiButtonCliecked), forControlEvents: UIControlEvents.TouchUpInside)
        bottomView.addSubview(mudiBtn)
        
        let btnW: CGFloat = bottomView.bounds.size.width
        // 归位刷新按钮
        let luopanBtn: UIButton = UIButton.init(type: UIButtonType.Custom)
        luopanBtn.frame = CGRectMake(bottomView.frame.origin.x, bottomView.frame.origin.y + 45, btnW / 4.0, 45)
        luopanBtn.setImage(UIImage(named: "guiwei30*30"), forState: UIControlState.Normal)
        luopanBtn.addTarget(self, action: #selector(refreshLuoPanBtnClicked), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(luopanBtn)
        
        // 车辆列表
        let qicheLieBiao: UIButton = UIButton.init(type: UIButtonType.Custom)
        qicheLieBiao.frame = CGRectMake(bottomView.frame.origin.x + btnW / 4.0, bottomView.frame.origin.y + 45, btnW / 4.0, 45)
        qicheLieBiao.setImage(UIImage(named: "cheliangliebiao30*30"), forState: UIControlState.Normal)
        qicheLieBiao.addTarget(self, action: #selector(carListBtnClicked), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(qicheLieBiao)
        
        // 我的行程  （运营范围的显示与隐藏）
        let wodeXingChengBtn: UIButton = UIButton.init(type: UIButtonType.Custom)
        wodeXingChengBtn.frame = CGRectMake(bottomView.frame.origin.x + btnW / 2.0, bottomView.frame.origin.y + 45, btnW / 4.0, 45)
        wodeXingChengBtn.setImage(UIImage(named: "wodexingcheng30*30"), forState: UIControlState.Normal)
        wodeXingChengBtn.addTarget(self, action: #selector(wodeXingChengBtnClicked), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(wodeXingChengBtn)
        
        // 个人中心首页
        let userCenter: UIButton = UIButton.init(type: UIButtonType.Custom)
        userCenter.frame = CGRectMake(bottomView.frame.origin.x + btnW / 4.0 * 3, bottomView.frame.origin.y + 45, btnW / 4.0, 45)
        userCenter.setImage(UIImage(named: "caidan30*30"), forState: UIControlState.Normal)
        userCenter.addTarget(self, action: #selector(userCenterBtnClicked), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(userCenter)
    }
    
    // 输入目的地的点击事件
    func mudidiButtonCliecked(sender: UIButton) {
        
    }
    
    // 归位刷新按钮
    func refreshLuoPanBtnClicked(sender: UIButton) {
        self.mapView.setZoomLevel(15.1, animated: YES)
        self.mapView.setCenterCoordinate(self.userLocation!, animated: YES)
        self.mapView.setRotationDegree(0, animated: YES, duration: 0.2)
        
        self.fetchCarLocationDetaile(self.userDestination!, isAll: YES)
    }
    
    // 车辆列表点击
    func carListBtnClicked(sender: UIButton) {
        let carListVC: EZZYECarListViewController = EZZYECarListViewController()
        
    }
    
    // 我的行程 (运营范围的显示与隐藏)
    func wodeXingChengBtnClicked(sender: UIButton) {
        
    }
    
    // 个人中心首页
    func userCenterBtnClicked(sender: UIButton) {
        
    }
    
    /**
     配置导航
     */
    func configMapNaviView() {
        self.naviManager = AMapNaviManager()
    }
    
    /**
     获得车辆信息
     */
    func fetchCarLocationDetaile(userDestination: CLLocationCoordinate2D, isAll: Bool) {
        weak var weakSelf = self
        self.networkingManager.findNearCars(UserCoordinate: self.userLocation!, UserDestination: userDestination, isAll: isAll).subscribeNext({ (x) in
            let carArr: Array = x as! Array<EZZYCarModel>
            weakSelf?.mapView.removeAnnotations(weakSelf?.ezzyAnnotations)
            weakSelf?.ezzyAnnotations.removeAll()
            if carArr.count == 0 {
                weakSelf?.delayHidHUD("附近没有车辆")
                return;
            } else {
                for carModel in carArr {
                    let annotation: EZZYAnnotation = EZZYAnnotation()
                    annotation.carCount = 1
                    annotation.carModel = carModel
                    annotation.coordinate = CLLocationCoordinate2DMake(Double(carModel.carLatitude!)!, Double(carModel.carLongitude!)!)
                    weakSelf?.ezzyAnnotations.append(annotation)
                }
            }
            self.aggregationAnnotations()
            }, error: { (error) in
            weakSelf?.delayHidHUD(kNetworkingError)
        }) {
            
        }
    }
    
    /**
     获得图层自定义折现范围控制
     */
    func getOperationRegionFromNetworking() {
        weak var weakSelf: EZZYMainViewController? = self
        let bundleDic: NSDictionary = NSBundle.mainBundle().infoDictionary!
        let version: String = bundleDic["CFBundleShortVersionString"] as! String
        self.networkingManager.getZiDingYiOperationRigion(version).subscribeNext({ (x) in
                let dic: NSDictionary = x as! NSDictionary
            print(dic)
                let timeStr: String? = dic["phoneMsg"] as? String
                if timeStr?.characters.count != 0 {
                    let attributes: NSDictionary = dic["attributes"] as! NSDictionary
                    beginTimeStr = attributes["begintime"] as? String
                    endTimeStr = attributes["endtime"] as? String
                    timeString = timeStr
                }
                
                if let attributesDic: NSDictionary = dic["attributes"] as? NSDictionary {
                    let type: String? = attributesDic["type"] as? String
                    var title = "提示"
                    var information = "欢迎使用EZZY"
                    var leftBtn = "确认"
                    var rightBtn = "取消"
                    if let titleStr: String = attributesDic["title"] as? String {
                        title = titleStr
                    }
                    if let informationStr: String = attributesDic["information"] as? String {
                        information = informationStr
                    }
                    if let leftBtnStr: String = attributesDic["leftbtn"] as? String {
                        leftBtn = leftBtnStr
                    }
                    if let rightBtnStr: String = attributesDic["rightbtn"] as? String {
                        rightBtn = rightBtnStr
                    }
                    switch type! {
                    case "1":
                        let alertView: UIAlertView = UIAlertView(title: title, message: information, delegate: self, cancelButtonTitle: leftBtn)
                        alertView.tag = PopoverAlertType.one.rawValue
                        alertView.show()
                        break
                    case "2":
                        let alertView: UIAlertView = UIAlertView(title: title, message: information, delegate: self, cancelButtonTitle: leftBtn, otherButtonTitles: rightBtn)
                        alertView.tag = PopoverAlertType.two.rawValue
                        alertView.show()
                        break
                    default:
                        break
                    }
                }
                let success: String! = String(dic["success"]!)
                if success! == "1" {
                    weakSelf?.delayHidHUD("运营区域")
                    let model: EZZYAggregatRegionTool = EZZYAggregatRegionTool.sharedECarFanWeiModel
                    let objArr: NSArray = dic["obj"] as! NSArray
                    if objArr.count > 0 {
                        if weakSelf?.polyArray?.count > 0 {
                            weakSelf?.polyArray?.removeAll()
                        }
                        // 得到坐标点
                        let firstPoly: NSArray = objArr.firstObject as! NSArray
                        model.pointArr = firstPoly
                        weakSelf?.createZiDingYiCoverViewOnMapViewWithPointArr(firstPoly, tag: 0)
                        model.fanWeiStatus = YES
                        for i in 1..<objArr.count {
                            let polyAr: NSArray = objArr[i] as! NSArray
                            if polyAr.count > 0 {
                                weakSelf?.createZiDingYiCoverViewOnMapViewWithPointArr(polyAr, tag: i)
                            }
                        }
                        self.mapView.setCenterCoordinate(CLLocationCoordinate2DMake(39.90815613, 116.3973999), animated: YES)
                        self.mapView.setZoomLevel(11.5, animated: YES)
                    }
                }
            }, error: { (erro) in
                weakSelf?.delayHidHUD(kNetworkingError)
            }) { 
                weakSelf?.performSelector(#selector(self.userCentor), withObject: nil, afterDelay: 2.5)
        }
    }
    
    func userCentor() {
        self.mapView.setZoomLevel(15.1, animated: YES)
        self.mapView.setCenterCoordinate(self.userLocation!, animated: YES)
    }
    
    // 构造自定义折线覆盖物
    func createZiDingYiCoverViewOnMapViewWithPointArr(pointArr: NSArray, tag: Int) {
        let numberOfPoints = pointArr.count
        if numberOfPoints > 2 {
            let poly: PDPolygon = PDPolygonManager().createZiDingYiCoverViewOnMapViewWithPointArr(pointArr as [AnyObject], andTag: tag)
            self.polyArray?.append(poly)
            self.mapView.addOverlay(poly)
        }
    }
    
    /**
     多点聚合
     */
    func aggregationAnnotations() {
        if self.ezzyAnnotations.count <= 1 {
            return;
        }
        if self.mapSalcus! == 19.000 {
            self.mapView.removeAnnotations(self.ezzyAnnotations)
            for annot in self.ezzyAnnotations {
                if let annotatin: EZZYAnnotation = annot {
                    annotatin.carCount = 1
                }
            }
            self.mapView.addAnnotations(self.ezzyAnnotations)
            return
        }
        
        let pdDistance: EZZYPDDistance = EZZYPDDistance()
        let a: CLLocationDistance = self.mapView.region.span.latitudeDelta / 50.0
        let b: CLLocationDistance = self.mapView.region.span.longitudeDelta / 50.0
        let radius: CLLocationDistance = sqrt(a * a + b * b)
        let annotations: NSMutableArray = NSMutableArray(array: self.ezzyAnnotations)
        let saveAnnotations: NSMutableArray = NSMutableArray()
        var n: Int = 1
        while 0 < annotations.count {
            n = 1
            let customAnn: EZZYAnnotation = annotations.firstObject as! EZZYAnnotation
            customAnn.carCount = n
            let deleAnnotation: NSMutableArray = NSMutableArray()
            for j in 1 ..< annotations.count {
                let customsecod: EZZYAnnotation = annotations[j] as! EZZYAnnotation
                if pdDistance.isLocationNearToOtherLocation(customAnn.coordinate, secondLocation: customsecod.coordinate, distance: radius) == YES {
                    n += 1
                    deleAnnotation.addObject(customsecod)
                }
            }
            customAnn.carCount = n
            saveAnnotations.addObject(customAnn)
            annotations.removeObjectAtIndex(0)
            if n > 1 {
                annotations .removeObjectsInArray(deleAnnotation as [AnyObject])
            }
        }
        self.mapView.removeAnnotations(self.ezzyAnnotations)
        self.mapView.addAnnotations(saveAnnotations as [AnyObject])
    }
    
    /**
     地图功能代理回调函数
     */
    var locationUserFirst: Bool = YES
    // 用户位置
    func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!, updatingLocation: Bool) {
        if updatingLocation == YES {
            if locationUserFirst == YES {
                self.fetchCarLocationDetaile(CLLocationCoordinate2DMake(0, 0), isAll: YES)
                self.locationUserFirst = NO
                self.mapView.setZoomLevel(1, animated: NO)
            }
            self.userLocation = userLocation.coordinate
            
        }
    }
    // 地图折线层
    func mapView(mapView: MAMapView!, viewForOverlay overlay: MAOverlay!) -> MAOverlayView! {
        if let over: MACircle = overlay as? MACircle {
            if over == mapView.userLocationAccuracyCircle {
                return nil
            }
        }
        if let overlayPdPoly = overlay as? PDPolygon {
            let polyGonView: MAPolygonView = MAPolygonView(polygon: overlayPdPoly)
            polyGonView.lineWidth = 1.0
            if overlayPdPoly.polygonColorType == PolygonColorType.FanWei {
                polyGonView.fillColor = UIColor(red: 243.0 / 255.0, green: 201.0 / 255.0, blue: 0, alpha: 0.3)
                polyGonView.lineWidth = 10.0
                polyGonView.strokeColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            } else if overlayPdPoly.polygonColorType == PolygonColorType.Green {
                polyGonView.fillColor = UIColor(red:34.0 / 255.0, green:160.0 / 255.0, blue:140.0 / 255.0, alpha:0.6)
            } else if overlayPdPoly.polygonColorType == PolygonColorType.Yellow {
                polyGonView.fillColor = UIColor(red:252.0 / 255.0, green:0.0, blue:172.0 / 255.0, alpha:0.4)
            } else if overlayPdPoly.polygonColorType == PolygonColorType.Red {
                polyGonView.fillColor = UIColor(red:224.0 / 255.0, green:54.0 / 255.0, blue:134.0 / 255.0, alpha:0.4)
            }
            polyGonView.lineJoinType = kMALineJoinRound
            return polyGonView
        }
        return nil
    }
    
    // 自定义userLocation对应的annotationView
    func mapView(mapView: MAMapView!, viewForAnnotation annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation.isKindOfClass(MAUserLocation) {
            return nil
        }
        let customAnnotation = annotation as! EZZYAnnotation
        let userLocationStyleReuseIndetifier: String = "userLocationStyleReuseIndetifier"
        var annotationView: EZZYCarAnnotationView? = mapView.dequeueReusableAnnotationViewWithIdentifier(userLocationStyleReuseIndetifier) as? EZZYCarAnnotationView
        if annotationView == nil {
            annotationView = EZZYCarAnnotationView(annotation: customAnnotation, reuseIdentifier: userLocationStyleReuseIndetifier)
        }
        annotationView?.carCount = customAnnotation.carCount!
        return annotationView
    }
    
    // 地图缩放时调用
    func mapView(mapView: MAMapView!, mapDidZoomByUser wasUserAction: Bool) {
        self.mapSalcus = self.mapView.zoomLevel
        if self.ezzyAnnotations.count <= 1 {
            return;
        }
        self.aggregationAnnotations()
    }
    
    // 大头针被选择代理回调方法
    func mapView(mapView: MAMapView!, didSelectAnnotationView view: MAAnnotationView!) {
        print("点击")
    }
}