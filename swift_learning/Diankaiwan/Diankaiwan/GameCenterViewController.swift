//
//  GameCenterViewController.swift
//  Diankaiwan
//
//  Created by YangRong on 15/9/25.
//  Copyright © 2015年 Arron. All rights reserved.
//

import UIKit
import Pitaya

class GameCenterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableViewCanPullDown = true
    
    static var token: dispatch_once_t = 0
    var topCell: ImagesSlideTableViewCell!
    var gameCardsJSONArray = Array<JSON>() {
        didSet{
            if self.gameCardsJSONArray.count > 0 {
                if let a = self.gameListTableView {
                    a.reloadSections(NSIndexSet(index: 1), withRowAnimation: .Automatic, callback: { () -> Void in
                        self.topConstaraintOfGameListTableView.constant = -App.ScreenHeight
                        if let cell = self.gameListTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as? OrangeBackgorundTableViewCell {
                            cell.pullTuRefreshImageView.stopAnimatePullToRefreshImageView()
                            cell.hintTextLabel.text = "下拉刷新"
                        }
                    })
                }
            }
        }
    }

    @IBOutlet weak var gameListTableView: UITableView!
    @IBOutlet weak var allGameCountButton: UIButton!
    @IBOutlet weak var topConstaraintOfGameListTableView: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        App.gameCenterViewController = self
        
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: "gotoLogin")
        
        self.topConstaraintOfGameListTableView.constant = -App.ScreenHeight
        
        self.gameListTableView.allowsSelection = true
        self.gameListTableView.estimatedRowHeight = 180
        self.gameListTableView.rowHeight = UITableViewAutomaticDimension
        
        var nib = UINib(nibName: "GameListTableViewCell", bundle: nil)
        self.gameListTableView.registerNib(nib, forCellReuseIdentifier: "GameListTableViewCell")
        nib = UINib(nibName: "ImagesSlideTableViewCell", bundle: nil)
        self.gameListTableView.registerNib(nib, forCellReuseIdentifier: "ImagesSlideTableViewCell")
        nib = UINib(nibName: "GameOperationTableViewCell", bundle: nil)
        self.gameListTableView.registerNib(nib, forCellReuseIdentifier: "GameOperationTableViewCell")
        nib = UINib(nibName: "OrangeBackgorundTableViewCell", bundle: nil)
        self.gameListTableView.registerNib(nib, forCellReuseIdentifier: "OrangeBackgorundTableViewCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        App.changeToOrangeBackground(self.navigationController?.navigationBar)
        
        dispatch_once(&GameCenterViewController.token) { () -> Void in
            self.refreshData()
        }
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if self.tableViewCanPullDown {
            let offsetY = -scrollView.contentOffset.y
            if offsetY >= 70 {
                scrollView.contentOffset.y = -70
            }
        }
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == self.gameListTableView {
            let offsetY = -scrollView.contentOffset.y
            if offsetY >= 70 {
                self.tableViewCanPullDown = false
                self.topConstaraintOfGameListTableView.constant = -App.ScreenHeight + 70
                if let cell = self.gameListTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as? OrangeBackgorundTableViewCell {
                    cell.pullTuRefreshImageView.animatePullToRefreshImageView()
                    cell.hintTextLabel.text = "加载中..."
                    App.getMessageJSONArray({ () -> Void in
                        self.gameListTableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: .Automatic)
                    })
                    self.refreshData({ () -> Void in
                        cell.hintTextLabel.text = "刷新成功"
                        self.tableViewCanPullDown = true
                    })
                }
            }
        }
    }
    func refreshData(callback: (() -> Void)? = nil) {
        if self.gameCardsJSONArray.count == 0 { self.pleaseWaitWithDiankai() }
        Network.POSTWithAlert("home-show", params: ["user_id": App.userInfo.userID != 0 ? App.userInfo.userID.description : (App.youkeID ?? 0)], errorCallback: { (error) -> Void in
            
            self.topConstaraintOfGameListTableView.constant = 0
            }) { (json) -> Void in
                switch json["status"] {
                case 0:
                    callback?()
                    self.clearAllNotice()
                    if let cell = self.topCell {
                        cell.gameCenterViewController = self
                        cell.imagesJSONArray = json["values"]["banners"]["content"].arrayValue
                    }
                    self.gameCardsJSONArray = json["values"]["cards"].arrayValue
                    
                    let text = NSMutableAttributedString(string: "查看全部 ", attributes: nil)
                    text.appendAttributedString(NSAttributedString(string: json["values"]["games_count"].stringValue, attributes: [NSForegroundColorAttributeName: App.GlobalOrangeLight!]))
                    text.appendAttributedString(NSAttributedString(string: " 款游戏", attributes: nil))
                    self.allGameCountButton.setAttributedTitle(text, forState: .Normal)
                default:
                    self.noticeError("未知错误")
                    break
                }
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return [10, 10, 0][section]
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return [2, 1, self.gameCardsJSONArray.count][section]
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("OrangeBackgorundTableViewCell", forIndexPath: indexPath) as! OrangeBackgorundTableViewCell
                cell.heightConstraint.constant = App.ScreenHeight
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("ImagesSlideTableViewCell", forIndexPath: indexPath) as! ImagesSlideTableViewCell
                self.topCell = cell
                return cell
            }
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("GameCenterMessageTableViewCell", forIndexPath: indexPath) as! GameCenterMessageTableViewCell
            let callback = { () -> Void in
                let json = App.messageJSONArray.first!
                cell.contentLabel.text = json["words"].stringValue
                cell.mainImageView.kf_setImageWithURL(NSURL(string: json["icon_url"].stringValue)!, placeholderImage: UIImage(named: "消息中心-信封图标-黄"))
            }
            if App.messageJSONArray.count > 0 {
                callback()
            } else {
                App.getMessageJSONArray(callback)
            }
            return cell
        case 2:
            let json = self.gameCardsJSONArray[indexPath.row]
            if let a = json["card_type"].string {
                switch a {
                case "game", "game_played":
                    let cell = tableView.dequeueReusableCellWithIdentifier("GameListTableViewCell", forIndexPath: indexPath) as! GameListTableViewCell
                    cell.gameId = json["game_id"].intValue
                    cell.url = App.GameURLBasePrefix + cell.gameId.description
                    cell.gameCenterViewController = self
                    cell.bannerImageView.kf_setImageWithURL(NSURL(string: json["image_url"].stringValue)!)
                    cell.logoImageView.kf_setImageWithURL(NSURL(string: json["icon_url"].stringValue)!)
                    cell.titleLabel.text = json["name"].stringValue
                    if a == "game" {
                        cell.descriptionLabel.text = json["game_type"].stringValue
                    } else {
                        let text = NSMutableAttributedString(string: "我的排名 ")
                        text.appendAttributedString(NSAttributedString(string: json["rank"].stringValue, attributes: [NSForegroundColorAttributeName: App.GlobalOrangeLight!]))
                        let rank_changed = json["rank_changed"].intValue
                        text.appendAttributedString(NSAttributedString(string: " " + (rank_changed > 0 ? "上升" : "下降") + abs(rank_changed).description + "位", attributes: nil))
                        cell.descriptionLabel.attributedText = text
                    }
                    cell.xxv.data = DataForXingXingsView(xingxingNumber: Int(json["score"].stringValue), playerNumber: Int(json["players"].stringValue))
                    return cell
                case "operation":
                    let cell = tableView.dequeueReusableCellWithIdentifier("GameOperationTableViewCell", forIndexPath: indexPath) as! GameOperationTableViewCell
                    cell.backgroundColor = UIColor.clearColor()
                    cell.bannerImageView.kf_setImageWithURL(NSURL(string: json["image_url"].stringValue)!)
                    cell.titleLabel.text = json["title"].stringValue
                    cell.subTitleLabel.text = json["sub_title"].stringValue
                    
                    return cell
                default:
                    return UITableViewCell()
                }
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}