//
//  DSParkDetailsTitleCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/28.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSParkDetailsTitleCell: HTBaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func configurateTheCell(xinfo:HTBaseCellModel){
        let info:DSParkDetailsCellModel = xinfo as! DSParkDetailsCellModel
        self.titleLabel.text = info.title
        
        
    }
}
