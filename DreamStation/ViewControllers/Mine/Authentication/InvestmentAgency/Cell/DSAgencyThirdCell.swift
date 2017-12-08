//
//  DSAgencyThirdCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/3.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSAgencyThirdCell:  HTBaseTableViewCell{

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var biaojiImage: UIImageView!
    
    var isHidden:Bool!
    var xinfo:DSAgencyThirdCellModel!
    var block:selectBlock!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configurateTheCell(xinfo: HTBaseCellModel) {
        let xinfo:DSAgencyThirdCellModel = xinfo as! DSAgencyThirdCellModel
        self.xinfo = xinfo
        self.titleLabel.text = xinfo.titleValue
        if xinfo.detailValue == nil {
            self.detailLabel.alpha = 1
            self.detailLabel.text = xinfo.placdholder
            self.detailLabel.textColor = UIColorFromRGB(0x999999)
        }else if xinfo.detailValue == "请选择"{
            self.detailLabel.alpha = 1
            self.detailLabel.text = xinfo.detailValue
            self.detailLabel.textColor = UIColorFromRGB(0x999999)
        }else{
            self.detailLabel.text = xinfo.detailValue
            self.detailLabel.textColor = UIColorFromRGB(0x000000)
            self.detailLabel.alpha = 0.8
        }
        self.block = xinfo.block
        self.biaojiImage.hidden = xinfo.isHidden
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.separatorInset=UIEdgeInsetsMake(0, SCREEN_WHIDTH(), 0, 0)
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected == true {
            self.block()
        }
    }
}

class DSAgencyThirdCellModel: HTBaseCellModel {
    var titleValue:String!
    var detailValue:String!
    var block:selectBlock!
    var placdholder : String!
    var isHidden:Bool!
}
