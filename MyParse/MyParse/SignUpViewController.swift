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
        self.alertAction("错误提示", msg: "请输入人名")
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.profilePhotoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
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
}
