//
//  SignUpViewController.swift
//  MyParse
//
//  Created by YangRong on 15/10/16.
//  Copyright © 2015年 Arron. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var profilePhotoImageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userEmailAddressTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userPasswordRepeatTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.userNameTextField.resignFirstResponder()
        self.userEmailAddressTextField.resignFirstResponder()
        self.userPasswordTextField.resignFirstResponder()
        self.userPasswordRepeatTextField.resignFirstResponder()
    }
    
    // UITextFieldDelegate 点击return按钮使得键盘消失
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func selectProfilePhotoButtonTapped(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        // 调用照片选择器
        self.presentViewController(pickerController, animated:true, completion: nil)
        
    }

    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func signUpButtonTapped(sender: AnyObject) {
        
        let userName = self.userNameTextField.text
        let userEmail = self.userEmailAddressTextField.text
        let password = self.userPasswordTextField.text
        let rePassword = self.userPasswordRepeatTextField.text
        
        if (userName!.isEmpty || userEmail!.isEmpty || password!.isEmpty || rePassword!.isEmpty) {
            self.alertAction("错误提示", msg: "所有字段必须填写！")
            return
        }
        if password?.characters.count < 6 {
            self.alertAction("错误提示", msg: "输入的密码不能小于6位数！")
            return
        }
        if password! != rePassword! {
            self.alertAction("错误提示", msg: "两次输入的密码不一致！")
            return
        }
        
        // 显示加载圈
        self.showLoadingIndicator("注册", detailText: "正在注册，请等待...", indicator: false)
        
        let myUser = PFUser()
        myUser.username = userEmail
        myUser.email = userEmail
        myUser.password = password
        myUser.setObject(userName!, forKey: "name")
        
        // 获取图片
        let profileImageData = UIImageJPEGRepresentation(profilePhotoImageView.image!, 1)
        if profileImageData != nil {
            let profileFile = PFFile(data: profileImageData!)
            myUser.setObject(profileFile, forKey: "profile_picture")
        }
        
        myUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            var userMessage = "注册成功"
            
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            
            if !success {
                userMessage = error!.localizedDescription
            }
            let myAlert = UIAlertController(title: "提示", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.Default, handler: { _ in
                if success {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            })
            myAlert.addAction(okAction)
            self.presentViewController(myAlert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.profilePhotoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        // 将照片选择器清除掉
        self.dismissViewControllerAnimated(true, completion: nil)
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
