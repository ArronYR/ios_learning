//
//  LeftSideViewController.swift
//  MyParse
//
//  Created by YangRong on 15/11/4.
//  Copyright © 2015年 Arron. All rights reserved.
//

import UIKit

class LeftSideViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNamelabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    let menuItems = ["主页", "关于", "退出"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let userName = PFUser.currentUser()?.username
        self.userNamelabel.text = userName
        
        let profilePictureObject = PFUser.currentUser()?.objectForKey("profile_picture") as! PFFile
        profilePictureObject.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
            if let imageData = imageData{
                self.userProfileImageView.image = UIImage(data: imageData)
            }
        }
        
        // 默认选中第一个
        let selectedIndex: Int = 0
        self.tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedIndex, inSection: 0), animated: false, scrollPosition: .Top)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let myCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
        myCell.textLabel?.text = menuItems[indexPath.row]
        
        return myCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.row){
        case 0:
            let mainViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
            let mainNav = UINavigationController(rootViewController: mainViewController)
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.drawerContainer?.centerViewController = mainNav
            appDelegate.drawerContainer?.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
            break
        case 1:
            let aboutViewController: AboutViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
            let aboutNav = UINavigationController(rootViewController: aboutViewController)
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.drawerContainer?.centerViewController = aboutNav
            appDelegate.drawerContainer?.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
            break
        case 2:
            // 退出按钮点击之后不设为选中状态
            tableView.deselectRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0), animated: false)
            self.logoutTapped()
            
            break
        default:
            print("选项没有被处理！")
        }
    }
    
    func logoutTapped() {
        self.logoutConfirm("退出", msg: "退出 MyParse 应用", okCallback: { () -> Void in
            NSUserDefaults.standardUserDefaults().removeObjectForKey("user_name")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            // 显示加载圈
            self.showLoadingIndicator("退出", detailText: "正在退出，请等待...", indicator: true)
            
            // 借助PFUser退出
            PFUser.logOutInBackgroundWithBlock({ (error: NSError?) -> Void in
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                
                // 检测用户是否已退出
                let userName: String? = NSUserDefaults.standardUserDefaults().stringForKey("user_name")
                if userName == nil {
                    // 跳转到主界面
                    let mainStrotyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let main: ViewController = mainStrotyBoard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
                    let mainNav = UINavigationController(rootViewController: main)
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.window?.rootViewController = mainNav
                }
            })
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
    
    
    // 显示加载圈
    func showLoadingIndicator(text: String, detailText: String, indicator: Bool){
        let spiningActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        spiningActivity.labelText = text
        spiningActivity.detailsLabelText = detailText
        spiningActivity.userInteractionEnabled = indicator
    }
}
