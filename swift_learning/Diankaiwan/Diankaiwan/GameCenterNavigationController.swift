//
//  GameCenterNavigationController.swift
//  Diankaiwan
//
//  Created by YangRong on 15/9/25.
//  Copyright © 2015年 Arron. All rights reserved.
//

import UIKit

class GameCenterNavigationController: DianKaiNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarItem.selectedImage = UIImage(named: "工具栏-当前-游戏大厅")
        
        let vc = UIStoryboard(name: "GameCenter", bundle: nil).instantiateInitialViewController() as UIViewController!
        self.setViewControllers([vc], animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

