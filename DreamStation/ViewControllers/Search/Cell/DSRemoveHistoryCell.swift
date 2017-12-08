//
//  DSRemoveHistoryCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/22.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSRemoveHistoryCell: HTBaseTableViewCell {

    
    @IBOutlet var clearBtn: UIButton!
    
    var block:selectBlock!
    var xinfo:DSRemoveHistoryCellModel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clearBtn.setTitleColor(greenNavigationColor, forState: .Normal)
        // Initialization code
    }
    
    override func configurateTheCell(xinfo: HTBaseCellModel) {
        let xinfo:DSRemoveHistoryCellModel = xinfo as! DSRemoveHistoryCellModel
        self.xinfo = xinfo
        self.block = xinfo.block
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func clearBtn(sender: UIButton) {
        self.block()
    }
    
}

class DSRemoveHistoryCellModel: HTBaseCellModel {
    var block:selectBlock!
}
