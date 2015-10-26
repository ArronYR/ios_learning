//
//  App.swift
//  Diankaiwan
//
//  Created by YangRong on 15/9/25.
//  Copyright © 2015年 Arron. All rights reserved.
//

import UIKit

class UserInfo {
    var userID: Int! {
        didSet { NSUserDefaults.standardUserDefaults().setInteger(self.userID, forKey: "user_id"); }
    }
    var name: String! {
        didSet { NSUserDefaults.standardUserDefaults().setObject(self.name, forKey: "user_name"); }
    }
    var avatarUrl: String!{
        didSet { NSUserDefaults.standardUserDefaults().setObject(self.avatarUrl, forKey: "user_avatar"); }
    }
    var phoneNumber: String!{
        didSet { NSUserDefaults.standardUserDefaults().setObject(self.phoneNumber, forKey: "user_phone_number"); }
    }
    var sex: String!{
        didSet { NSUserDefaults.standardUserDefaults().setObject(self.sex, forKey: "user_sex"); }
    }
    static func initFromUserDefault() -> UserInfo {
        let ud = NSUserDefaults.standardUserDefaults()
        let userInfo = UserInfo()
        userInfo.userID = ud.integerForKey("user_id")
        userInfo.name = ud.objectForKey("user_name") as? String
        userInfo.avatarUrl = ud.objectForKey("user_avatar") as? String
        userInfo.phoneNumber = ud.objectForKey("user_phone_number") as? String
        userInfo.sex = ud.objectForKey("user_sex") as? String
        return userInfo
    }
    static func removeAllFromUserDefault() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("user_id")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("user_name")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("user_avatar")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("user_phone_number")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("user_sex")
    }
}

class App {
    static let DEV = false
    static let NetworkBaseUrl: String = App.DEV ? "http://dev.leqicheng.com/" : "http://www.leqicheng.com/"
    static let GameURLBasePrefix = "http://www.leqicheng.com/game/"
    static let DocumentBasePath: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first as String!
    static let MD5Base: String = "b4b5547c7f1e883f24a20326319da7e9"
    static let ScreenWidth = UIScreen.mainScreen().bounds.maxX
    static let ScreenHeight = UIScreen.mainScreen().bounds.maxY
    static let GlobalOrange = UIColor(hex: 0xfa8100)
    static let GlobalOrangeLight = UIColor(hex: 0xff8a00)
    static let GlobalDarkGreen = UIColor(hex: 0x669999)
    static let GlobalGreyOfTextBack = UIColor(hex: 0xf1f1f1)
    static var TimeDiffrenceBetweenLocalAndServer: Int = 0
    static var FullScreenImagesSlidesWindow: UIWindow!
    static var userInfo = UserInfo.initFromUserDefault()
    static var youkeID = NSUserDefaults.standardUserDefaults().stringForKey("youke_id") {
        didSet {
            NSUserDefaults.standardUserDefaults().setObject(App.youkeID, forKey: "youke_id")
        }
    }
    static var userInfoOfLocalNotification: [NSObject : AnyObject]?
    
    static var messageJSONArray = Array<JSON>()
    static func getMessageJSONArray(callback: (()->Void)? = nil) {
        Network.POSTWithAlert("messages", params: ["user_id": App.userInfo.userID ?? 0], errorCallback: nil) { (json) -> Void in
            switch json["status"] {
            case 0:
                App.messageJSONArray = json["values"]["messages"].arrayValue
                callback?()
            default:
                SwiftNotice.showNoticeWithText(.error, text: "出错", autoClear: true, autoClearTime: 1)
                break
            }
        }
    }
    
    struct WechatStrings {
        var AppID = "wx5faf2d92a01c3d30"
        var AppSecret = "80142e21a18867f5e8462d608769b0aa"
        var PartnerID = "1261061001"
    }
    static let wechatStrings = WechatStrings()
    
    static var DianKaiPayID: Int! = nil
    
    static var HintWindow: UIWindow!
    
    static func changeToOrangeBackground(navigationBar: UINavigationBar?) {
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        navigationBar?.setBackgroundColorWithAlpha(UIColor.whiteColor(), alpha: 0)
        navigationBar?.tintColor = UIColor.whiteColor()
        navigationBar?.translucent = false
        navigationBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSShadowAttributeName: NSShadow()]
        navigationBar?.setBackgroundImage(UIImage(named: "Orange"), forBarMetrics: .Default)
        navigationBar?.shadowImage = UIImage()
    }
    static func changeToWhiteBackground(navigationBar: UINavigationBar?) {
        App.changeToClearBackground(navigationBar)
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        navigationBar?.setBackgroundColorWithAlpha(UIColor.whiteColor(), alpha: 1)
        navigationBar?.tintColor = UIColor.whiteColor()
        navigationBar?.translucent = false
        navigationBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor(), NSShadowAttributeName: NSShadow()]
        navigationBar?.shadowImage = UIImage(named: "grey")
    }
    static func changeToClearBackground(navigationBar: UINavigationBar?) {
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        navigationBar?.setBackgroundColorWithAlpha(UIColor.whiteColor(), alpha: 0)
        navigationBar?.translucent = true
        navigationBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.clearColor(), NSShadowAttributeName: NSShadow()]
        navigationBar?.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar?.shadowImage = UIImage()
    }
    
    static func checkLogin(fromVC: UIViewController!,callback: (()->Void)?, errorCallback: (() -> Void)?) {
        if App.userInfo.userID != 0 {
            callback?()
        } else {
            errorCallback?()
        }
    }
    
    static func AlipayCallBack(params: Dictionary<NSObject, AnyObject>) {
        if params["resultStatus"]?.intValue == 9000 {
            print("支付成功！")
        }
    }
    
    static var userIDOrYoukeID: String {
        get {
            return App.userInfo.userID != 0 ? App.userInfo.userID.description : App.youkeID!
        }
    }
    
    static func refreshAppUserInfo(userID: Int, callback: ((json: JSON) -> Void)? = nil) {
        if userID != 0 {
            Network.POSTWithAlert("get-user-info", params: ["user_id": userID], errorCallback: nil) { (json) -> Void in
                switch json["status"] {
                case 0:
                    let userInfo = UserInfo()
                    userInfo.userID = Int(json["values"]["user_id"].stringValue)
                    userInfo.name = json["values"]["name"].stringValue
                    userInfo.avatarUrl = json["values"]["image_url"].stringValue
                    userInfo.phoneNumber = json["values"]["phone_number"].stringValue
                    userInfo.sex = json["values"]["sex"].stringValue
                    App.userInfo = userInfo
                    callback?(json: json)
                default:
                    SwiftNotice.showNoticeWithText(.error, text: "未知错误", autoClear: true, autoClearTime: 3)
                    break
                }
            }
        }
    }
//    
//    static func doSomethingAfterRegist() {
//        if let rvc = UIApplication.sharedApplication().keyWindow?.rootViewController as? MainTabBarController {
//            if let vc = rvc.selectedViewController {
//                vc.showUserInfoSettingTableViewController(vc)
//            }
//        }
//    }
//    
    static func popToRootViewController() {
        App.gameCenterViewController?.navigationController?.popToRootViewControllerAnimated(false)
    }
    static var gameCenterViewController: GameCenterViewController?
}