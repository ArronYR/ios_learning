//
//  ResponseData.swift
//  SimpleDemoIOS
//
//  Created by YangRong on 15/10/29.
//  Copyright © 2015年 Arron. All rights reserved.
//

import JSONNeverDie

class ReponseData: JSONNDModel{
    var error = 0
    var msg = ""
    var userInfo: UserInfo!
    
    required init(JSONNDObject json: JSONND){
        super.init(JSONNDObject: json)
        
        self.userInfo = UserInfo(JSONNDObject: json["userInfo"])
    }
}

class UserInfo: JSONNDModel {
    var userName = ""
    var phone = ""
    var email = ""
    var ip = ""
    var create_time = ""
}