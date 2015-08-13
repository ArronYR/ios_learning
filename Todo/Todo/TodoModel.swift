//
//  TodoModel.swift
//  Todo
//
//  Created by YangRong on 15/8/13.
//  Copyright © 2015年 arron. All rights reserved.
//

import UIKit

class TodoModel: NSObject {
    var id: String
    var image: String
    var title: String
    var date: NSDate
    
    init (id: String, image: String, title: String, date: NSDate) {
        self.id = id
        self.image = image
        self.title = title
        self.date = date
    }
}

/*
struct TodoModel{
    var id: String
    var image: String
    var title: String
    var date: NSDate
}
*/