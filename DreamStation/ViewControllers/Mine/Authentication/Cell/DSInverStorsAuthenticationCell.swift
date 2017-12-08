//
//  DSInverStorsAuthenticationCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/2.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSInverStorsAuthenticationCell: HTBaseTableViewCell {

    @IBOutlet var BGBtn: UIButton!
    @IBOutlet var roleImage: UIImageView!
    @IBOutlet var statusImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    
    @IBOutlet var BGBtn2: UIButton!
    @IBOutlet var titleLabel2: UILabel!
    @IBOutlet var statusImage2: UIImageView!
    
    
    
    var block:passParameterBlock!
    
    var xinfo:DSInverStorsAuthenticationCellModel!
    
    override func configurateTheCell(xinfo: HTBaseCellModel) {
        
        let xinfo:DSInverStorsAuthenticationCellModel = xinfo as! DSInverStorsAuthenticationCellModel
        self.xinfo = xinfo
        self.block = xinfo.block
        self.block(1)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.statusImage2.hidden = true
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.separatorInset=UIEdgeInsetsMake(0, SCREEN_WHIDTH(), 0, 0)
    }
    
    @IBAction func btnOfClick(sender: UIButton) {
        self.BGBtn.setBackgroundImage(UIImage.init(named: "Authentication_xuanBG"), forState: .Normal)
        self.statusImage.hidden = false
        self.statusImage.image = UIImage.init(named: "Authentication_btnStatus")
        self.titleLabel.textColor = UIColor.whiteColor()
        self.detailLabel.textColor = UIColor.whiteColor()
        self.BGBtn2.setBackgroundImage(UIImage.init(named: "Authentication_weixuanBG"), forState: .Normal)
        self.statusImage2.hidden = true
        self.titleLabel2.textColor = UIColor.blackColor()
        self.block(1)
    }
    @IBAction func btnOfClick2(sender: UIButton) {
        self.BGBtn2.setBackgroundImage(UIImage.init(named: "Authentication_xuanBG"), forState: .Normal)
        self.statusImage2.hidden = false
        self.statusImage2.image = UIImage.init(named: "Authentication_btnStatus")
        self.titleLabel2.textColor = UIColor.whiteColor()

        self.BGBtn.setBackgroundImage(UIImage.init(named: "Authentication_weixuanBG"), forState: .Normal)
        self.statusImage.hidden = true
        self.titleLabel.textColor = UIColor.blackColor()
        self.detailLabel.textColor = UIColor.blackColor()
        
        self.block(2)
        
    }
   
}

class DSInverStorsAuthenticationCellModel: HTBaseCellModel {
    var block:passParameterBlock!
}

