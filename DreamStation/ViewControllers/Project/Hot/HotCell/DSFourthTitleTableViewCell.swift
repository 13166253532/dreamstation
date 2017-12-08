//
//  DSFourthTitleTableViewCell.swift
//  DreamStation
//
//  Created by QPP on 16/11/23.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSFourthTitleTableViewCell: HTBaseTableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected( selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func configurateTheCell(xinfo: HTBaseCellModel) {
        let info:DSFourthFirstCellModel = xinfo as! DSFourthFirstCellModel
        self.titleLabel.text=info.titleValue
    }
    
}
class DSFourthFirstCellModel: HTBaseCellModel {
    
    var titleValue:String!
}
