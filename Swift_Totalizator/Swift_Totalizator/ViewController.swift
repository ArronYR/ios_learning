//
//  ViewController.swift
//  Swift_ Totalizator
//
//  Created by YangRong on 15/9/5.
//  Copyright © 2015年 Arron. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var numberOne: UITextField!
    @IBOutlet weak var numberTwo: UITextField!
    @IBOutlet weak var numberResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        numberOne.resignFirstResponder()
        numberTwo.resignFirstResponder()
    }
    
    // UITextFieldDelegate 点击return按钮使得键盘消失
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func calculate(sender: AnyObject) {
        
        if let firstNum = Int(numberOne.text!) {
            if let secondNum = Int(numberTwo.text!) {
                numberResult.text = "结果为:\(Int(firstNum + secondNum))"
            } else {
                self.alertAction("错误提示", msg: "请输入数字")
            }
        } else {
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

