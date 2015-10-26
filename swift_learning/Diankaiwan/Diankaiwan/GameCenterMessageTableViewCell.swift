//
//  GameCenterMessageTableViewCell.swift
//  Diankaiwan
//
//  Created by YangRong on 15/9/25.
//  Copyright © 2015年 Arron. All rights reserved.
//

import UIKit

class GameCenterMessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
