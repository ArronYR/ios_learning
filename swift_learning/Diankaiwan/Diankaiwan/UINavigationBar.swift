//
//  UINavigationBar.swift
//  DianKai
//
//  Created by leqicheng on 15/8/11.
//  Copyright © 2015年 Leqicheng. All rights reserved.
//

import UIKit

private var backgroundView = UIView(frame: CGRectMake(0, -20, App.ScreenWidth, 64))
private var backgroundViewHasBeenInserted = false
extension UINavigationBar {
    func setBackgroundColorWithAlpha(color: UIColor, alpha: CGFloat) {
        if !backgroundViewHasBeenInserted {
            self.insertSubview(backgroundView, atIndex: 0)
        } else {
            backgroundViewHasBeenInserted = true
        }
        backgroundView.backgroundColor = color
        backgroundView.alpha = alpha
    }
}
