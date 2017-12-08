//
//  DSSecreenMoneyTableViewCell.swift
//  DreamStation
//
//  Created by xjb on 16/8/4.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSSecreenMoneyTableViewCell: HTBaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var smallMoney: UITextField!
    
    @IBOutlet weak var bigMoney: UITextField!
    
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
    override func configurateTheCell(xinfo:HTBaseCellModel){
        let info:DSScreeningCellModel = xinfo as! DSScreeningCellModel
        self.titleLabel.text = info.title
        self.block = info.blocks
        self.smallMoney.text = info.smallTitle
        self.bigMoney.text = info.bigTitle
        self.smallMoney.placeholder = "最低价"
        self.bigMoney.placeholder = "最高价"
        self.smallMoney.userInteractionEnabled = false
        self.bigMoney.userInteractionEnabled = false
    }
}
