//
//  ViewController.swift
//  MyParse
//
//  Created by YangRong on 15/9/25.
//  Copyright © 2015年 Arron. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userEmailAddressTextField: UITextField!
    @IBOutlet weak var userPasswordTextFild: UITextField!
   
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
        
        // 显示加载圈
        self.showLoadingIndicator("登录", detailText: "正在登录，请请等待...", indicator: true)
        
        PFUser.logInWithUsernameInBackground(userEmail!, password: password!) { (user: PFUser?, error: NSError?) -> Void in
            var userMessage = "登录成功"
            if user != nil {
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                
                // 存储登录后的用户名
                let userName = user?.username
                NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "user_name")
                NSUserDefaults.standardUserDefaults().synchronize()
                
                // 跳转到主界面
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.buildUserInterface()
                
            }else{
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                
                userMessage = error!.localizedDescription
                
                self.alertAction("警告", msg: userMessage)
            }
        }
    }
    
    // 显示加载圈
    func showLoadingIndicator(text: String, detailText: String, indicator: Bool){
        let spiningActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        spiningActivity.labelText = text
        spiningActivity.detailsLabelText = detailText
        spiningActivity.userInteractionEnabled = indicator
    }
    
    // 系统Alert提示
    func alertAction(title: String, msg: String){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

