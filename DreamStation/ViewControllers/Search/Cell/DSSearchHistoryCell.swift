//
//  DSSearchHistoryCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/1.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSSearchHistoryCell: HTBaseTableViewCell {

    @IBOutlet var label: UILabel!
    var xinfo:DSSearchHistoryCellModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func configurateTheCell(xinfo: HTBaseCellModel) {
        
        let xinfo:DSSearchHistoryCellModel = xinfo as! DSSearchHistoryCellModel
        self.xinfo = xinfo
        self.label.text = xinfo.labelValue
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}


class DSSearchHistoryCellModel: HTBaseCellModel {
    
    var labelValue:String!
    
}
