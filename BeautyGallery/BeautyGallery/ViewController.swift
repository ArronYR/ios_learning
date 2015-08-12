//
//  ViewController.swift
//  BeautyGallery
//
//  Created by YangRong on 15/8/12.
//  Copyright © 2015年 arron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var beautyPicker: UIPickerView!
    
    let beauties = ["范冰冰", "李冰冰", "王菲", "杨幂", "周迅"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beautyPicker.dataSource = self
        beautyPicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue:
        UIStoryboardSegue, sender: AnyObject!) {
            if segue.identifier == "GoToGallery" {
                let index = beautyPicker.selectedRowInComponent(0)
                
                let vc = segue.destinationViewController as! GalleryViewController
                switch index {
                case 0:
                    vc.imageName = "fanbingbing"
                case 1:
                    vc.imageName = "libingbing"
                case 2:
                    vc.imageName = "wangfei"
                case 3:
                    vc.imageName = "yangmi"
                case 4:
                    vc.imageName = "zhouxun"
                default:
                    vc.imageName = nil
                }
            }
    }
    
}

