//
//  UITableView.swift
//  Diankaiwan
//
//  Created by YangRong on 15/9/28.
//  Copyright © 2015年 Arron. All rights reserved.
//

import UIKit

extension UITableView {
    
    func reloadSections(sections: NSIndexSet, withRowAnimation: UITableViewRowAnimation,callback: ()->Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(callback)
        self.reloadSections(sections, withRowAnimation: withRowAnimation)
        CATransaction.commit()
    }
}