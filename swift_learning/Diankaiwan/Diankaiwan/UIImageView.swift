//
//  UIImageView.swift
//  Diankaiwan
//
//  Created by YangRong on 15/9/28.
//  Copyright © 2015年 Arron. All rights reserved.
//

import UIKit

private var timer: dispatch_source_t!
private var timerTimes = 0

extension UIImageView {
    
    func animatePullToRefreshImageView() {
        let imageNames = ["下拉loading1", "下拉loading2", "下拉loading3", "下拉loading4", "下拉loading5", "下拉loading6", "下拉loading7"]
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue())
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, UInt64(50) * NSEC_PER_MSEC, 0)
        dispatch_source_set_event_handler(timer, { () -> Void in
            let name = imageNames[timerTimes % imageNames.count]
            self.image = UIImage(named: name)
            timerTimes++
        })
        dispatch_resume(timer)
    }
    func stopAnimatePullToRefreshImageView() {
        if let _ = timer {
            dispatch_source_cancel(timer)
            timer = nil
            timerTimes = 0
        }
    }
}