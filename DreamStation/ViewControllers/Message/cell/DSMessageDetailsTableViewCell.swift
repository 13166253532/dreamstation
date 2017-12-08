//
//  DSMessageDetailsTableViewCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/25.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSMessageDetailsTableViewCell: HTBaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var redImage: UIImageView!
    var block:selectBlock!
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 
    }
    
    override func configurateTheCell(xinfo: HTBaseCellModel) {
       let info:DSMessageCellModel=xinfo as! DSMessageCellModel
        self.titleLabel.text = info.title
        self.block = info.block

    }

}
