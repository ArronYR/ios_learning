//
//  XingXingsView.swift
//  Diankaiwan
//
//  Created by YangRong on 15/9/28.
//  Copyright © 2015年 Arron. All rights reserved.
//

import UIKit

struct DataForXingXingsView {
    let xingxingNumber: Int!
    let playerNumber: Int!
}
class XingXingsView: UIView {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    var data: DataForXingXingsView = DataForXingXingsView(xingxingNumber: 4, playerNumber: 0) {
        didSet{
            // 生成 label
            if data.playerNumber < 0 {
                self.textLabel.textColor = UIColor.whiteColor()
                self.textLabel.text = "\(data.xingxingNumber)分"
            } else {
                let text = NSMutableAttributedString(string: self.data.xingxingNumber.description, attributes: [NSForegroundColorAttributeName: App.GlobalOrangeLight!])
                text.appendAttributedString(NSAttributedString(string: "分  ", attributes: nil))
                text.appendAttributedString(NSAttributedString(string: self.data.playerNumber.description, attributes: [NSForegroundColorAttributeName: App.GlobalOrangeLight!]))
                text.appendAttributedString(NSAttributedString(string: "人正在玩", attributes: nil))
                self.textLabel.attributedText = text
            }
            
            // 设置星星
            for i in 1...self.data.xingxingNumber {
                let star = [star1, star2, star3, star4, star5][i - 1]
                star.image = UIImage(named: data.playerNumber < 0 ? "通用-星级-白色" : "通用-星级-橙色")
            }
        }
    }
}
