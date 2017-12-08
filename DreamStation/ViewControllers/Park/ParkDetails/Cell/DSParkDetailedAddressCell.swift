//
//  DSParkDetailedAddressCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/27.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSParkDetailedAddressCell: HTBaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func configurateTheCell(xinfo:HTBaseCellModel){
//        let info:DSParkDetailsCellModel = xinfo as! DSParkDetailsCellModel
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        //self.separatorInset=UIEdgeInsetsMake(0, SCREEN_WHIDTH(), 0, 0)
    }
}
