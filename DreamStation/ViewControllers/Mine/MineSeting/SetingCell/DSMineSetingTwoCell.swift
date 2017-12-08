//
//  DSMineSetingTwoCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/21.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSMineSetingTwoCell: HTBaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    var block:selectBlock!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected==true {
            self.block()
        }
    }
    
    override func configurateTheCell(info: HTBaseCellModel) {
        let xinfo: DSSetingCellModel = info as! DSSetingCellModel
        titleLabel.text = xinfo.title
        block = xinfo.block
    }
    
   
  
}
