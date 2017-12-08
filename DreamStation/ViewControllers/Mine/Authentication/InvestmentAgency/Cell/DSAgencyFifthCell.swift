//
//  DSAgencyFifthCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/3.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSAgencyFifthCell: HTBaseTableViewCell {

    @IBOutlet var nextBtn: UIButton!
    var titleValue:String!
    
    var xinfo:DSAgencyFifthCellModel!
    var block:selectBlock!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configurateTheCell(xinfo: HTBaseCellModel) {
        
        let xinfo:DSAgencyFifthCellModel = xinfo as! DSAgencyFifthCellModel
        self.nextBtn.setTitle(xinfo.titleValue, forState: .Normal)
        self.block = xinfo.block
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.separatorInset=UIEdgeInsetsMake(0, SCREEN_WHIDTH(), 0, 0)
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func nextBtnOfClick(sender: UIButton) {
        self.block()
    }
}

class DSAgencyFifthCellModel: HTBaseCellModel {
    var titleValue:String!
    var block:selectBlock!
}
