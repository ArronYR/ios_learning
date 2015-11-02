//
//  MainViewController.swift
//  MyParse
//
//  Created by YangRong on 15/11/2.
//  Copyright © 2015年 Arron. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutTapped(sender: AnyObject) {
        self.logoutConfirm("退出", msg: "退出 MyParse 应用", okCallback: { () -> Void in
            NSUserDefaults.standardUserDefaults().removeObjectForKey("user_name")
            // 启动是检测用户是否已登录
            let userName: String? = NSUserDefaults.standardUserDefaults().stringForKey("user_name")
            if userName == nil {
                // 跳转到主界面
                let mainStrotyBoard = UIStoryboard(name: "Main", bundle: nil)
                let main: ViewController = mainStrotyBoard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
                let mainNav = UINavigationController(rootViewController: main)
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.window?.rootViewController = mainNav
            }
        }) { () -> Void in
            print("出错！")
        }
    }
    
    // 退出提示
    func logoutConfirm(title: String, msg: String, okCallback: ()->Void, cancelCallback: ()->Void){
        let myAlert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "确定", style: .Default, handler: { (action) -> Void in
            okCallback()
        })
        
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel) { (action) -> Void in
            cancelCallback()
        }
        
        myAlert.addAction(okAction)
        myAlert.addAction(cancelAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
}
