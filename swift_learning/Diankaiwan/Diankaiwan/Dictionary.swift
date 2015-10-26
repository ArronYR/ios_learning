//
//  Dictionary.swift
//  Diankaiwan
//
//  Created by YangRong on 15/9/28.
//  Copyright © 2015年 Arron. All rights reserved.
//

extension Dictionary {
    func convertToURLParams() -> String
    {
        var url = ""
        for (i, j) in self {
            url += "&\(i)=\(j)"
        }
        return url
    }
}
