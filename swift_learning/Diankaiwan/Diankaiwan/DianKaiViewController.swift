//
//  DianKaiViewController.swift
//  Diankaiwan
//
//  Created by YangRong on 15/9/28.
//  Copyright © 2015年 Arron. All rights reserved.
//

import UIKit

extension UIViewController {
    func pleaseWaitWithDiankai() {
        self.pleaseWaitWithImages(["loading1", "loading2", "loading3", "loading4", "loading5", "loading6", "loading7"], timeInterval: 50)
    }
}

extension SwiftNotice {
    static func waitWithDiankai() {
        SwiftNotice.wait(["loading1", "loading2", "loading3", "loading4", "loading5", "loading6", "loading7"], timeInterval: 50)
    }
}

enum BackButtonColor {
    case Orange, White
    func picName() -> String {
        switch self {
        case .Orange:
            return "back"
        case .White:
            return "back2"
        }
    }
}

class DianKaiViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var backButtonColor = BackButtonColor.Orange
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let image = UIImage(named: self.backButtonColor.picName())?.imageWithRenderingMode(.AlwaysOriginal)
        let leftbbi = UIBarButtonItem(image: image, style: .Plain, target: self, action: "popVC")
        self.navigationItem.setLeftBarButtonItem(leftbbi, animated: false)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    func popVC() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}

