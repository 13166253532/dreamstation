//
//  DSAgencySixthCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/3.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSAgencySixthCell: HTBaseTableViewCell {

    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var biaojiImage: UIImageView!
    
    
    var block:selectBlock!
    var xinfo:DSAgencySixthCellModel!
    var isHidden:Bool!
    
    override func configurateTheCell(xinfo: HTBaseCellModel) {
        let xinfo:DSAgencySixthCellModel = xinfo as! DSAgencySixthCellModel
        self.xinfo = xinfo
        self.firstLabel.text = xinfo.firstValue
        self.secondLabel.text = xinfo.secondValue
        self.colocr(self.firstLabel)
        self.colocr(self.secondLabel)
        self.block = xinfo.block
        self.biaojiImage.hidden = xinfo.isHidden
    }
    func colocr(label:UILabel){
        if label.text == "请选择" {
            label.textColor = UIColorFromRGB(0xA0A0A0)
        }else{
            label.textColor = UIColorFromRGB(0x000000)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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

class DSAgencySixthCellModel: HTBaseCellModel {
    var firstValue:String!
    var secondValue:String!
    var block:selectBlock!
    var isHidden:Bool!
}
