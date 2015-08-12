//
//  GalleryViewController.swift
//  BeautyGallery
//
//  Created by YangRong on 15/8/12.
//  Copyright © 2015年 arron. All rights reserved.
//

import UIKit
import Social

class GalleryViewController: UIViewController {
    
    
    @IBOutlet weak var beautyImage: UIImageView!
    
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = imageName {
            beautyImage.image = UIImage(named: name)
            
            switch name {
            case "fanbingbing":
                navigationItem.title = "范冰冰"
            case "libingbing":
                navigationItem.title = "李冰冰"
            case "wangfei":
                navigationItem.title = "王菲"
            case "yangmi":
                navigationItem.title = "杨幂"
            case "zhouxun":
                navigationItem.title = "周迅"
            default:
                navigationItem.title = "女神画廊"
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func shareTapped(sender: AnyObject) {
        let controller:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeSinaWeibo)
        controller.setInitialText("一起来玩女神画廊App，Github上的源码在 https://github.com/JakeLin/BeautyGallery")
        controller.addImage(beautyImage.image)
        self.presentViewController(controller, animated: true, completion: nil)
    }
}
