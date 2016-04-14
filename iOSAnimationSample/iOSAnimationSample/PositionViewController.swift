//
//  PositionViewController.swift
//  iOSAnimationSample
//
//  Created by YangRong on 16/4/14.
//  Copyright © 2016年 Arron. All rights reserved.
//

import UIKit

class PositionViewController: UIViewController {

    @IBOutlet weak var blueSquare: UIView!
    
    @IBOutlet weak var redSquare: UIView!
    
    @IBOutlet weak var greenSquare: UIView!
    
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
            self.blueSquare.center.x = self.view.bounds.width - self.blueSquare.center.x
        }
        UIView.animateWithDuration(1, delay: 0.5, options: [], animations: { () -> Void in
            self.redSquare.center.y = self.view.bounds.height - self.redSquare.center.y
        }, completion: nil)
        UIView.animateWithDuration(1, delay: 1, options: [], animations: { () -> Void in
            self.greenSquare.center.x = self.view.bounds.width - self.greenSquare.center.x
            self.greenSquare.center.y = self.view.bounds.height - self.greenSquare.center.y
            }, completion: nil)
    }
}
