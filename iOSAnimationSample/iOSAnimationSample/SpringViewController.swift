//
//  SpringViewController.swift
//  iOSAnimationSample
//
//  Created by YangRong on 16/4/14.
//  Copyright © 2016年 Arron. All rights reserved.
//

import UIKit

class SpringViewController: UIViewController {

    @IBOutlet weak var blueSquare: UIView!
    @IBOutlet weak var redSquare: UIView!
    @IBOutlet weak var orangeSquare: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(1) { () -> Void in
            self.blueSquare.center.x = self.view.bounds.width - self.blueSquare.center.x
        }
        
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            self.redSquare.center.x = self.view.bounds.width - self.redSquare.center.x
        }, completion: nil)
        
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1, options: [], animations: { () -> Void in
            self.orangeSquare.center.x = self.view.bounds.width - self.orangeSquare.center.x
        }, completion: nil)
    }
}
