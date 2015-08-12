//
//  ViewController.swift
//  LoveFinder
//
//  Created by YangRong on 15/8/12.
//  Copyright © 2015年 arron. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var gender: UISegmentedControl!
    
    @IBOutlet weak var birthday: UIDatePicker!
    
    @IBOutlet weak var heightNumber: UISlider!
    
    @IBOutlet weak var height: UILabel!
    
    @IBOutlet weak var hasProperty: UISwitch!
    
    @IBOutlet weak var result: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        name.resignFirstResponder()
    }
    
    // UITextFieldDelegate 点击return按钮使得键盘消失
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func heightChanged(sender: AnyObject) {
        let slider = sender as! UISlider
        height.text = "\(Int(slider.value))cm"
        
        // 或者不使用上两行的代码，直接使用下面的代码亦可
        // height.text = "\(Int(heightNumber.value))cm"
    }
    
    @IBAction func okTapped(sender: AnyObject) {
        
        if name.text != "" {
            let genderText = gender.selectedSegmentIndex == 0 ? "高富帅" : "白富美"
            let age = self.calculateAge()
            let hasPropertyText = hasProperty.on ? "有房" : "无房"
            
            result.text = "\(name.text!), \(genderText), \(age)岁, 身高\(height.text!), \(hasPropertyText), 求交往！"
        }else{
            self.alertAction("错误提示", msg: "请输入人名")
        }
    }
    
    // 计算年龄
    func calculateAge() -> Int {
        var age = 0
        let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let now = NSDate()
        let components = gregorian?.components(NSCalendarUnit.Year, fromDate: birthday.date, toDate: now, options: NSCalendarOptions(rawValue: 0))
    
        age = components!.year
        return age
    }
    
    // 系统Alert提示
    func alertAction(title: String, msg: String){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

