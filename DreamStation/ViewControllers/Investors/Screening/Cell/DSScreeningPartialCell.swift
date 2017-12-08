//
//  DSScreeningPartialCell.swift
//  DreamStation
//
//  Created by xjb on 16/8/2.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSScreeningPartialCell: HTBaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    var blocks:selectBlock!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    override func configurateTheCell(xinfo:HTBaseCellModel){
        let info:DSScreeningCellModel = xinfo as! DSScreeningCellModel
        self.blocks = info.blocks
    }

    @IBAction func action(sender: AnyObject) {
        self.blocks()
    }
    
}
