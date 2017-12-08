//
//  DSVideoPlayerTitleCell.swift
//  DreamStation
//
//  Created by xjb on 2016/12/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSVideoPlayerTitleCell: HTBaseTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected==true {
          
        }
    }
    
    override func configurateTheCell(info: HTBaseCellModel) {
        //let xinfo: DSSetingCellModel = info as! DSSetingCellModel
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.separatorInset=UIEdgeInsetsMake(0, SCREEN_WHIDTH(), 0, 0)
    }
    
    
    
}
