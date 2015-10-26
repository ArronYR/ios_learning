//
//  ImagesSlideTableViewCell.swift
//  Diankaiwan
//
//  Created by YangRong on 15/9/25.
//  Copyright © 2015年 Arron. All rights reserved.
//

import UIKit
import Kingfisher

class ImagesSlideTableViewCell: UITableViewCell, UIScrollViewDelegate {
    
    var gameCenterViewController: GameCenterViewController!
    var imageCount = 0
    
    var imagesJSONArray = Array<JSON>() {
        didSet {
            self.refreshImages()
        }
    }
    
    @IBOutlet weak var scrollView: DianKaiScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var heightConstraintOfScrollView: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.heightConstraintOfScrollView.constant = App.ScreenWidth * 9 / 16

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func refreshImages() {
        self.imageCount = self.imagesJSONArray.count
        self.pageControl.numberOfPages = self.imageCount
        scrollView.removeAllSubviews()
        scrollView.contentSize = CGSizeMake(App.ScreenWidth * CGFloat(self.imageCount + 2), 0)
        
        for i in 0...(self.imageCount + 1) {
            let iv = UIImageView(frame: CGRectMake(App.ScreenWidth * CGFloat(i), 0, App.ScreenWidth, App.ScreenWidth * 9 / 16))
            iv.image = UIImage(named: "phone")
            switch i {
            case 0:
                iv.kf_setImageWithURL(NSURL(string: self.imagesJSONArray.last!["img_url"].stringValue)!)
            case (self.imageCount + 1):
                iv.kf_setImageWithURL(NSURL(string: self.imagesJSONArray.first!["img_url"].stringValue)!)
            default:
                iv.kf_setImageWithURL(NSURL(string: self.imagesJSONArray[i - 1]["img_url"].stringValue)!)
                
                let tg = UITapGestureRecognizer(target: self, action: "imageBeTapped:")
                iv.tag = 10000 + i - 1
                iv.userInteractionEnabled = true
                iv.addGestureRecognizer(tg)
            }
            iv.contentMode = UIViewContentMode.ScaleAspectFill
            iv.clipsToBounds = true
            
            scrollView.addSubview(iv)
        }
        scrollView.contentOffset = CGPointMake(App.ScreenWidth, 0)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        
        if offsetX == 0 {
            scrollView.contentOffset = CGPointMake(App.ScreenWidth * CGFloat(self.imageCount), 0)
        }
        if offsetX == App.ScreenWidth * CGFloat(self.imageCount + 1) {
            scrollView.contentOffset = CGPointMake(App.ScreenWidth, 0)
        }
        
        let currentPage = scrollView.contentOffset.x / App.ScreenWidth - 0.5
        pageControl.currentPage = Int(currentPage)
    }
    
}
