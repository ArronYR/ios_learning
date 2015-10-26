//
//  DianKaiScrollView.swift
//  Diankaiwan
//
//  Created by YangRong on 15/9/25.
//  Copyright © 2015年 Arron. All rights reserved.
//

import UIKit

class DianKaiScrollView: UIScrollView {
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.panGestureRecognizer {
            let velocity = self.panGestureRecognizer.velocityInView(self)
            return fabs(velocity.y)/3 < fabs(velocity.x)
        } else {
            return true
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.exerciseAmbiguityInLayout()
    }
}
