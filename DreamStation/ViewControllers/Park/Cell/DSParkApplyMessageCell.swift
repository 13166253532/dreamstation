//
//  DSParkApplyMessageCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/26.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSParkApplyMessageCell: HTBaseTableViewCell {
    var block:selectBlock!
    var goBlock:passParameterBlock!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected==true {
            self.block()
        }
    }
    
    override func configurateTheCell(xinfo:HTBaseCellModel){
        let info:DSParkCellModel = xinfo as! DSParkCellModel
        self.block = info.block
        self.goBlock = info.goBlock

    }
    
  
    @IBAction func action(sender: AnyObject) {
        self.goBlock(sender)
    }

   

}
