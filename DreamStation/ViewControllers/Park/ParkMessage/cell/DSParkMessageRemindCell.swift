//
//  DSParkMessageRemindCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/25.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSParkMessageRemindCell: HTBaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func configurateTheCell(zinfo:HTBaseCellModel){
        let info:DSParkMessageCellInfo=zinfo as! DSParkMessageCellInfo
        self.titleLabel.text=info.title
    }
    

}
