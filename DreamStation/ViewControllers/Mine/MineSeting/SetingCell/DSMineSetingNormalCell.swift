//
//  DSMineSetingNormalCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/21.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSMineSetingNormalCell: HTBaseTableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
   
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
        labelTitle.text = xinfo.title
        block = xinfo.block
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.separatorInset=UIEdgeInsetsMake(0, SCREEN_WHIDTH(), 0, 0)
    }
    
}
