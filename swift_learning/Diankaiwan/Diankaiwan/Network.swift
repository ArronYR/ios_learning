//
//  Network.swift
//  DianKai
//
//  Created by leqicheng on 15/7/16.
//  Copyright © 2015年 Leqicheng. All rights reserved.
//

import Pitaya

class Network {
    
    static func POSTWithAlert(uri: String, params: Dictionary<String, AnyObject>, APIVersion: Int = 1, errorCallback: ((NSError) -> Void)?, callback: (JSON) -> Void) {
        Network.POST(uri, params: params, APIVersion: APIVersion, errorCallback: { (error) -> Void in
            SwiftNotice.clear()
            SwiftNotice.showNoticeWithText(.error, text: "连接失败", autoClear: true, autoClearTime: 3)
            errorCallback?(error)
            }, callback: callback)
    }
    static func POST(uri: String, params: Dictionary<String, AnyObject>, APIVersion: Int = 1, errorCallback: ((NSError) -> Void)?, callback: (JSON) -> Void) {
        let seed = Int(NSDate().timeIntervalSince1970) + App.TimeDiffrenceBetweenLocalAndServer
        let token = (seed.description + App.MD5Base).md5
        let jsonString = JSON(params).rawString()!
        let sign = (jsonString + App.MD5Base).md5
        let urlParams: Dictionary<String, AnyObject> = [ "seed": seed, "token": token, "sign": sign ]
        
        let pitaya = PitayaManager.build(.POST, url: "\(App.NetworkBaseUrl)api/\(APIVersion.description)/\(uri)?source=ios" + urlParams.convertToURLParams())
        pitaya.setHTTPBodyRaw(jsonString)
        pitaya.fire({ (error) -> Void in
            errorCallback?(error)
            }) { (data, response) -> Void in
                if let statusCode = response?.statusCode {
                    if statusCode != 200 {
                        SwiftNotice.showNoticeWithText(.error, text: "服务器出错", autoClear: true, autoClearTime: 3)
                    } else if let d = data {
                        if let json: JSON = JSON(data: d) {
                            callback(json)
                        }
                    }
                }
        }
    }
    
    static func getTimeDiffrenceBetweenLocalAndServer() {
        Pitaya.request(.GET, url: "\(App.NetworkBaseUrl)now", errorCallback: nil) { (data, response) -> Void in
            if let string = NSString(data: data!, encoding: NSUTF8StringEncoding) as? String {
                if let t = Int(string) {
                    App.TimeDiffrenceBetweenLocalAndServer = t - Int(NSDate().timeIntervalSince1970)
                }
            }
        }
    }
    
    static func testNetwork(errorCallback: (() -> Void)?, callback: (() -> Void)?) {
        Pitaya.request(.GET, url: "\(App.NetworkBaseUrl)now", errorCallback: { (error) -> Void in
            SwiftNotice.showNoticeWithText(.error, text: "连接失败", autoClear: true, autoClearTime: 3)
            errorCallback?()
            }) { (data, response) -> Void in
                callback?()
        }
    }
}
