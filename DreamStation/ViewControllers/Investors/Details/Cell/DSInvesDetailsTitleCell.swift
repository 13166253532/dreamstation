//
//  DSInvesDetailsTitleCell.swift
//  DreamStation
//
//  Created by xjb on 16/8/1.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSInvesDetailsTitleCell: HTBaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    override func configurateTheCell(xinfo:HTBaseCellModel){
        let info:DSInvesDetailsHeadCellModel = xinfo as! DSInvesDetailsHeadCellModel
        self.titleLabel.text = info.title
    }

}
