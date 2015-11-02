//
//  ViewController.swift
//  MyParse
//
//  Created by YangRong on 15/9/25.
//  Copyright © 2015年 Arron. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginMaskView: UIView!
    @IBOutlet weak var userEmailAddressTextField: UITextField!
    @IBOutlet weak var userPasswordTextFild: UITextField!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.userEmailAddressTextField.resignFirstResponder()
        self.userPasswordTextFild.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func signInTapped(sender: AnyObject) {
        let userEmail = userEmailAddressTextField.text
        let password = userPasswordTextFild.text
        
        if (userEmail!.isEmpty || password!.isEmpty) {
            self.alertAction("警告", msg: "请填写登录信息")
            
            return
        }
        
        self.showLoadingIndicator(false)
        
        PFUser.logInWithUsernameInBackground(userEmail!, password: password!) { (user: PFUser?, error: NSError?) -> Void in
            var userMessage = "登录成功"
            if user != nil {
                self.showLoadingIndicator(true)
                
                // 存储登录后的用户名
                let userName = user?.username
                NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "user_name")
                NSUserDefaults.standardUserDefaults().synchronize()
                
                // 跳转到主界面
                let mainStrotyBoard = UIStoryboard(name: "Main", bundle: nil)
                let main: MainViewController = mainStrotyBoard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
                let mainNav = UINavigationController(rootViewController: main)
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.window?.rootViewController = mainNav
            }else{
                self.showLoadingIndicator(true)
                userMessage = error!.localizedDescription
                
                self.alertAction("警告", msg: userMessage)
            }
        }
    }
    
    // 显示加载圈
    func showLoadingIndicator(indicator: Bool){
        self.loginMaskView.hidden = indicator
        self.loadingIndicator.startAnimating()
    }
    
    // 系统Alert提示
    func alertAction(title: String, msg: String){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

