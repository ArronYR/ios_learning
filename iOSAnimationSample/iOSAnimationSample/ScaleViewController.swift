//
//  ScaleViewController.swift
//  iOSAnimationSample
//
//  Created by YangRong on 16/4/14.
//  Copyright © 2016年 Arron. All rights reserved.
//

import UIKit

class ScaleViewController: UIViewController {

    @IBOutlet weak var redSquare: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(1) { () -> Void in
            self.redSquare.transform = CGAffineTransformMakeScale(2.0, 2.0)
        }
    }
}
