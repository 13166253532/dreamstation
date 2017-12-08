//
//  DSActivityDetailThirdCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/25.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSActivityDetailThirdCell: HTBaseTableViewCell {

    
    @IBOutlet var introducLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configurateTheCell(xinfo: HTBaseCellModel) {
        let xinfo:DSDetailThirdCellModel = xinfo as! DSDetailThirdCellModel
        self.introducLabel.text = xinfo.introducValue
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class DSDetailThirdCellModel: HTBaseCellModel {
    var introducValue:String!
}

