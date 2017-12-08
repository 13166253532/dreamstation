//
//  DSActivityDetailSecondCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/25.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSActivityDetailSecondCell: HTBaseTableViewCell {

    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configurateTheCell(xinfo: HTBaseCellModel) {
        let xinfo:DSDetailSecondCellModel = xinfo as! DSDetailSecondCellModel
        self.locationLabel.text = xinfo.locationValue
        self.dateLabel.text = xinfo.datelValue
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


class DSDetailSecondCellModel: HTBaseCellModel {
    var locationValue:String!
    var datelValue:String!
}
