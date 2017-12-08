//
//  DSMineHeadTableViewCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/20.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSMineHeadTableViewCell: HTBaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
 
    @IBOutlet weak var pleaseLabel: UILabel!
    
    @IBOutlet weak var rightImgConstraint: NSLayoutConstraint!
    var info:DSMineHeadCellModel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.pleaseLabel.textColor=grayBgColor
        
        if SCREEN_WHIDTH()>320{
            self.rightImgConstraint.constant=20
        }
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected==true {
            self.info.block()
        }
    }
    override func configurateTheCell(info: HTBaseCellModel) {
        self.info = info as! DSMineHeadCellModel
        self.titleLabel.text = self.info.name
        self.pleaseLabel.text = self.info.subTitle
    }
}
