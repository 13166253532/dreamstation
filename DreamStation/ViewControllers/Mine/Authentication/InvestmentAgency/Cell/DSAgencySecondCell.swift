//
//  DSAgencySecondCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/3.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSAgencySecondCell: HTBaseTableViewCell {
    @IBOutlet weak var iImage: UIImageView!

    @IBOutlet weak var btnRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageRightConstraint: NSLayoutConstraint!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailBtn: UIButton!
    @IBOutlet var biaojiImage: UIImageView!
    
    var xinfo:DSAgencySecondCellModel!
    var block:selectBlock!
    var isHidden:Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.iImage.layer.cornerRadius=self.iImage.frame.size.width/2
        self.iImage.layer.masksToBounds=true

    }

    override func configurateTheCell(xinfo: HTBaseCellModel) {
        
        let xinfo:DSAgencySecondCellModel = xinfo as! DSAgencySecondCellModel
        self.xinfo = xinfo
        self.titleLabel.text = xinfo.titleValue
        self.biaojiImage.hidden = xinfo.isHidden
        self.block = xinfo.block
        self.detailBtn.setBackgroundImage(UIImage.init(named: xinfo.detailValue), forState: .Normal)
        
        if xinfo.titleValue == "LOGO"||xinfo.titleValue == "头像" {
            self.iImage.layer.cornerRadius = 30
        }else if xinfo.titleValue == "营业执照或三证合一"{
            self.iImage.layer.cornerRadius = 0
        }
        
        if let url=xinfo.imageUrl{
            self.iImage.sd_setImageWithURL(NSURL.init(string: url), placeholderImage: UIImage.init(named: "Agency_logo"))
            self.accessoryType = .DisclosureIndicator
            self.btnRightConstraint.constant=0
            self.imageRightConstraint.constant=0
        }
        if xinfo.backImage != nil {
            self.iImage.image=xinfo.backImage
        }
   
      
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.separatorInset=UIEdgeInsetsMake(0, SCREEN_WHIDTH(), 0, 0)
    }
    @IBAction func ClickOfBtn(sender: UIButton) {
        self.block()
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

class DSAgencySecondCellModel: HTBaseCellModel {
    var titleValue:String!
    var detailValue:String!
    var imageUrl:String?
    var block:selectBlock!
    var isHidden:Bool!
    var backImage:UIImage!
}
