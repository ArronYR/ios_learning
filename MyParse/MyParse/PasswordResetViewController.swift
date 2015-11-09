//
//  PasswordResetViewController.swift
//  MyParse
//
//  Created by YangRong on 15/11/9.
//  Copyright © 2015年 Arron. All rights reserved.
//

import UIKit

class PasswordResetViewController: UIViewController {

    @IBOutlet weak var emailAddressTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.emailAddressTextField.resignFirstResponder()
    }

    @IBAction func sendButtonTapped(sender: AnyObject) {
        let emailAddress = self.emailAddressTextField.text
        if let emailAddress = emailAddress {
            if emailAddress.isEmpty {
                return
            }
            PFUser.requestPasswordResetForEmailInBackground(emailAddress, block: { (success: Bool, error: NSError?) -> Void in
                if error != nil {
                    self.displayMessage(error!.localizedDescription)
                }else{
                    self.displayMessage("重置密码信息已发送到您的邮箱，请注意查收！")
                }
            })
        }
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func displayMessage(str: String){
        let myAlert = UIAlertController(title: "提示", message: str, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "确定", style: .Default, handler: nil)
        
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
}
