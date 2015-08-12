//
//  ViewController.swift
//  ChineseZodiac
//
//  Created by YangRong on 15/8/6.
//  Copyright © 2015年 arron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var yearOfBirth: UITextField!
    
    @IBOutlet weak var image: UIImageView!
    
    let offset = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 点击屏幕时使输入框退出焦点
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        yearOfBirth.resignFirstResponder()
        
        // 使文本在界面打开时获取焦点，弹出输入键盘
        // yearOfBirth.becomeFirstResponder()
    }
    
    @IBAction func okTapped(sender: AnyObject) {
        yearOfBirth.resignFirstResponder()
        
        if let year = Int(yearOfBirth.text!){
            var imageNumber = abs((year - offset) % 12)
            image.image = UIImage(named: imageNumber.description)
        }else{
            self.alertAction("错误提示", msg: "请输入数字")
        }
    }

    // 系统Alert提示
    func alertAction(title: String, msg: String){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}

