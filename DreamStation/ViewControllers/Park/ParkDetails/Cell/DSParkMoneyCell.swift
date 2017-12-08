//
//  DSParkMoneyCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/27.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSParkMoneyCell: HTBaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var subTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func configurateTheCell(xinfo:HTBaseCellModel){
        let info:DSParkDetailsCellModel = xinfo as! DSParkDetailsCellModel
        self.titleLabel.text = info.title
        self.subTitleLabel.text = info.subTitle
        
    }
    
}
