//
//  RotationViewController.swift
//  iOSAnimationSample
//
//  Created by YangRong on 16/4/14.
//  Copyright © 2016年 Arron. All rights reserved.
//

import UIKit

class RotationViewController: UIViewController {

    @IBOutlet weak var redSquare: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func spin(){
        UIView.animateWithDuration(1) { () -> Void in
            self.redSquare.transform = CGAffineTransformRotate(self.redSquare.transform, CGFloat(M_PI))
        }
        
        UIView.animateWithDuration(1, delay: 0, options: [.CurveLinear], animations: { () -> Void in
            self.redSquare.transform = CGAffineTransformRotate(self.redSquare.transform, CGFloat(M_PI))
            }) { (finished) -> Void in
                self.spin()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        self.spin()
    }
}
