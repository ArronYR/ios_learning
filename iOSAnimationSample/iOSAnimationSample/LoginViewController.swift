//
//  LoginViewController.swift
//  iOSAnimationSample
//
//  Created by YangRong on 16/4/16.
//  Copyright © 2016年 Arron. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var bubble1: UIImageView!
    @IBOutlet weak var bubble2: UIImageView!
    @IBOutlet weak var bubble3: UIImageView!
    @IBOutlet weak var bubble4: UIImageView!
    @IBOutlet weak var bubble5: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var dot: UIImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var warning: UIImageView!
    
    var loginPosition = CGPoint.zero
    //spinner
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bubble1.transform = CGAffineTransformMakeScale(0, 0)
        self.bubble2.transform = CGAffineTransformMakeScale(0, 0)
        self.bubble3.transform = CGAffineTransformMakeScale(0, 0)
        self.bubble4.transform = CGAffineTransformMakeScale(0, 0)
        self.bubble5.transform = CGAffineTransformMakeScale(0, 0)
        
        self.dot.center.x -= self.view.bounds.width/3
        self.logo.center.x -= self.view.bounds.width
        
        // adjust place holder icon
        let usernamePaddingLeft = UIView(frame: CGRectMake(0,0,44, self.username.frame.height))
        self.username.leftView = usernamePaddingLeft
        self.username.leftViewMode = .Always
        
        let passwordPaddingLeft = UIView(frame: CGRectMake(0,0,44, self.password.frame.height))
        self.password.leftView = passwordPaddingLeft
        self.password.leftViewMode = .Always
        
        let userImageView = UIImageView(image: UIImage(named: "user"))
        userImageView.frame.origin = CGPoint(x: 13, y: 9)
        self.username.addSubview(userImageView)
        
        let keyImageView = UIImageView(image: UIImage(named: "key"))
        keyImageView.frame.origin = CGPoint(x: 12, y: 9)
        self.password.addSubview(keyImageView)
        
        self.username.center.x -= self.view.bounds.width
        self.password.center.x -= self.view.bounds.width
        
        self.loginPosition = self.loginButton.center
        self.loginButton.center.x -= self.view.bounds.width
        
        self.warning.center = self.loginPosition
        self.warning.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            self.bubble1.transform = CGAffineTransformMakeScale(1, 1)
            self.bubble4.transform = CGAffineTransformMakeScale(1, 1)
        }, completion: nil)
        UIView.animateWithDuration(0.3, delay: 0.1, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            self.bubble2.transform = CGAffineTransformMakeScale(1, 1)
            self.bubble3.transform = CGAffineTransformMakeScale(1, 1)
        }, completion: nil)
        UIView.animateWithDuration(0.3, delay: 0.2, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            self.bubble5.transform = CGAffineTransformMakeScale(1, 1)
        }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.3, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: [], animations: { () -> Void in
            self.logo.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animateWithDuration(5, delay: 0.4, usingSpringWithDamping: 0.1, initialSpringVelocity: 1, options: [], animations: { () -> Void in
            self.dot.center.x += self.view.bounds.width/3
        }, completion: nil)
        
        UIView.animateWithDuration(0.4, delay: 0.5, options: [.CurveEaseOut], animations: { () -> Void in
            self.username.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animateWithDuration(0.4, delay: 0.6, options: [.CurveEaseOut], animations: { () -> Void in
            self.password.center.x += self.view.bounds.width
        }, completion: nil)
        
        UIView.animateWithDuration(0.4, delay: 0.7, options: [.CurveEaseOut], animations: { () -> Void in
            self.loginButton.center.x += self.view.bounds.width
        }, completion: nil)
    }
    
    @IBAction func okLoginTapped(sender: AnyObject) {
        self.spinner.frame.origin = CGPointMake(12, 10)
        self.loginButton.addSubview(spinner)
        self.spinner.startAnimating()
        
        UIView.transitionWithView(self.warning, duration: 0.3, options: [.TransitionFlipFromBottom], animations: { () -> Void in
            self.warning.hidden = true
        }, completion: nil)
        
        UIView.animateWithDuration(0.3) { () -> Void in
            self.loginButton.center = self.loginPosition
        }
        self.loginButton.center.x -= 30
        UIView.animateWithDuration(1.5, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            self.loginButton.center.x += 30
        }, completion: { _ in
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.loginButton.center.y += 80
                self.spinner.removeFromSuperview()
            }, completion: { _ in
                UIView.transitionWithView(self.warning, duration: 0.3, options: [.TransitionFlipFromTop, .CurveEaseInOut], animations: { () -> Void in
                    self.warning.hidden = false
                }, completion: nil)
            })
        })
    }
}
