//
//  EditProfileViewController.swift
//  MyParse
//
//  Created by YangRong on 15/11/9.
//  Copyright © 2015年 Arron. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    var opener: LeftSideViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
