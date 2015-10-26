//
//  GameListTableViewCell.swift
//  Diankaiwan
//
//  Created by YangRong on 15/9/28.
//  Copyright © 2015年 Arron. All rights reserved.
//

import UIKit

class GameListTableViewCell: UITableViewCell {
    var url = ""
    var gameId = 0
    var gameCenterViewController: GameCenterViewController!
    var xxv: XingXingsView!

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var xingxingsView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var heightConstraintOfMainPic: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization codes
        self.heightConstraintOfMainPic.constant = 33 / 75 * (App.ScreenWidth - 20)
        
        self.xxv = NSBundle.mainBundle().loadNibNamed("XingXingsView", owner: self, options: nil).first as! XingXingsView
        self.xingxingsView.addSubview(self.xxv)
        
        self.xxv.data = DataForXingXingsView(xingxingNumber: 2, playerNumber: 20129)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
