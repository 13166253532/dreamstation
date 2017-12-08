//
//  DSInvestorsTableViewCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/29.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSInvestorsTableViewCell: HTBaseTableViewCell {

    @IBOutlet weak var InvesHeadImageView: UIImageView!
  
    @IBOutlet weak var InvesName: UILabel!

    @IBOutlet weak var InvesTypeLabel: UILabel!
    
    @IBOutlet weak var InvesPhaseLabel: UILabel!
    
    @IBOutlet weak var InvesVideoImageView: UIImageView!
    
    @IBOutlet weak var InvesVideoLabel: UILabel!
    
    @IBOutlet weak var InvesVideoPlayImage: UIImageView!
    
    @IBOutlet weak var videoPlayBtn: UIButton!
    
    
    
    @IBOutlet weak var imagees: UIImageView!
    
    
    var block:selectBlock!
    var videoBlock:selectBlock!

   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.InvesHeadImageView.layer.cornerRadius = 30
        self.InvesHeadImageView.layer.masksToBounds = true
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected==true {
            self.block()
        }
    }
    override func configurateTheCell(xinfo:HTBaseCellModel){
        let info:DSInvestorsCellModel = xinfo as! DSInvestorsCellModel
        self.InvesVideoImageView.hidden = false
        self.InvesVideoPlayImage.hidden = false
        self.InvesVideoLabel.hidden = false
        self.videoPlayBtn.hidden = false
        if let url = info.InvesHeadImageUrl {
            self.InvesHeadImageView.sd_setImageWithURL(NSURL.init(string:url), placeholderImage: UIImage.init(named: "Inves_peoheadImage"))
        }else{
            self.InvesHeadImageView.image = UIImage.init(named: "Inves_peoheadImage")
        }
        self.InvesName.text = info.InvesName
        self.InvesTypeLabel.text = info.Invesindustry
        self.InvesPhaseLabel.text = info.InvesPhase
        if info.isAplay == true {
            imagees.alpha = 0
        }else if info.isAplay == false{
            imagees.alpha = 1
        }
    
        if let url = info.videoImg {
            self.InvesVideoImageView.sd_setImageWithURL(NSURL.init(string:url ), placeholderImage: UIImage.init())
        }else{
            self.InvesVideoImageView.image = UIImage.init()
        }
//        self.InvesVideoImageView
        self.InvesVideoLabel.text = info.videoText
        self.block = info.block
        self.videoBlock = info.videoBlock
        if info.isVideo == false {
            self.InvesVideoImageView.hidden = true
            self.InvesVideoPlayImage.hidden = true
            self.InvesVideoLabel.hidden = true
            self.videoPlayBtn.hidden = true
        }
    }
    @IBAction func action(sender: AnyObject) {
        self.videoBlock()
    }
    
}
