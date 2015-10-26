//
//  GameOperationTableViewCell.swift
//  Diankaiwan
//
//  Created by YangRong on 15/9/28.
//  Copyright © 2015年 Arron. All rights reserved.
//

import UIKit

class GameOperationTableViewCell: UITableViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var heightConstraintOfMainPic: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.heightConstraintOfMainPic.constant = 33 / 75 * (App.ScreenWidth - 20)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
