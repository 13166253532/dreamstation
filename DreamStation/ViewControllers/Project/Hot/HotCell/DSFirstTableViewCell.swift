//
//  DSFirstTableViewCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/28.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSFirstTableViewCell: HTBaseTableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var readLabel: UILabel!
    @IBOutlet var hotLabel: UILabel!
    
    var xinfo:DSFirstCellModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func configurateTheCell(xinfo: HTBaseCellModel) {
        let xinfo:DSFirstCellModel = xinfo as! DSFirstCellModel
        self.xinfo = xinfo
        
        self.titleLabel.text = xinfo.titleValue
        self.detailLabel.text = xinfo.detailValue
        self.readLabel.text = xinfo.readValue
        self.hotLabel.text = xinfo.hotValue
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


class DSFirstCellModel: HTBaseCellModel {
    var titleValue:String?
    var detailValue:String?
    var readValue:String?
    var hotValue:String?
}