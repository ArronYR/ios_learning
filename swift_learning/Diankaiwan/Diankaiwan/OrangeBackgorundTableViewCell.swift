//
//  OrangeBackgorundTableViewCell.swift
//  Diankaiwan
//
//  Created by YangRong on 15/9/28.
//  Copyright © 2015年 Arron. All rights reserved.
//

import UIKit

class OrangeBackgorundTableViewCell: UITableViewCell {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pullTuRefreshImageView: UIImageView!
    @IBOutlet weak var bottomConstraintOfTextLabel: NSLayoutConstraint!
    @IBOutlet weak var hintTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
