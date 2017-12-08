//
//  DSMineMyProjectCell.swift
//  DreamStation
//
//  Created by xjb on 16/8/23.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSMineMyProjectCell: HTBaseTableViewCell {

    @IBOutlet weak var companyLabel: UILabel!
  
    @IBOutlet weak var subLabel: UILabel!
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
     let xinfo: DSMineMyProjectCellModel = info as! DSMineMyProjectCellModel
        self.companyLabel.text = xinfo.title
        self.subLabel.text = xinfo.subTitle
        self.block = xinfo.block
    }
}
class DSMineMyProjectCellModel: HTBaseCellModel {
    var title:String?
    var subTitle:String?
    var block:selectBlock!
    
}