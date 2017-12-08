//
//  DSFifthTableViewCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/29.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSFifthTableViewCell: HTBaseTableViewCell {
    var  cellInfo: DSFifthTableViewCelModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func configurateTheCell(xinfo: HTBaseCellModel) {
        let xinfo:DSFifthTableViewCelModel = xinfo as! DSFifthTableViewCelModel
//        self.xinfo = xinfo
//        self.block = xinfo.block
        self.cellInfo = xinfo
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected == true {
            self.cellInfo.block()
        }
    }
    
    
    
}
class DSFifthTableViewCelModel: HTBaseCellModel {
    var block:selectBlock!
    
}

