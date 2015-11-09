//
//  EditProfileViewController.swift
//  MyParse
//
//  Created by YangRong on 15/11/9.
//  Copyright © 2015年 Arron. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var opener: LeftSideViewController!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userName = PFUser.currentUser()?.username
        self.userNameTextField.text = userName
        
        if PFUser.currentUser()?.objectForKey("profile_picture") != nil {
            let profilePictureObject = PFUser.currentUser()?.objectForKey("profile_picture") as! PFFile
            profilePictureObject.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                if let imageData = imageData{
                    self.profileImageView.image = UIImage(data: imageData)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func selectProfilePhotoButtonTapped(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        // 调用照片选择器
        self.presentViewController(pickerController, animated:true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        let userName = self.userNameTextField.text
        let password = self.passwordTextField.text
        let rePassword = self.rePasswordTextField.text
        
        if (userName!.isEmpty) {
            self.alertAction("错误提示", msg: "邮箱必须填写！")
            return
        }
        if  (!password!.isEmpty) {
            if password?.characters.count < 6 {
                self.alertAction("错误提示", msg: "输入的密码不能小于6位数！")
                return
            }
            if password! != rePassword! {
                self.alertAction("错误提示", msg: "两次输入的密码不一致！")
                return
            }
        }
        
        let myUser = PFUser.currentUser()
        myUser!.username = userName
        // 获取图片
        let profileImageData = UIImageJPEGRepresentation(self.profileImageView.image!, 1)
        if profileImageData != nil {
            let profileFile = PFFile(data: profileImageData!)
            myUser!.setObject(profileFile, forKey: "profile_picture")
        }
        if !password!.isEmpty {
            myUser!.password = password
        }
        
        // 显示加载圈
        self.showLoadingIndicator("修改", detailText: "正在提交，请等待...", indicator: false)
        
        myUser?.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
            var userMessage = "修改成功"
            
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            
            if !success {
                userMessage = error!.localizedDescription
            }
            let myAlert = UIAlertController(title: "提示", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.Default, handler: { action in
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    if let opener = self.opener {
                        opener.loadUserDetail()
                    }
                })
            })
            myAlert.addAction(okAction)
            self.presentViewController(myAlert, animated: true, completion: nil)
        })
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.profileImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        // 将照片选择器清除掉
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // 系统Alert提示
    func alertAction(title: String, msg: String){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // 显示加载圈
    func showLoadingIndicator(text: String, detailText: String, indicator: Bool){
        let spiningActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        spiningActivity.labelText = text
        spiningActivity.detailsLabelText = detailText
        spiningActivity.userInteractionEnabled = indicator
    }
}
