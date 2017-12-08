//
//  DSMineSetingOneCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/21.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSMineSetingOneCell: HTBaseTableViewCell {

    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var subTitle: UILabel!
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
        title.text = xinfo.title
        subTitle.text = xinfo.subTitle
        block = xinfo.block
    }
       
}
