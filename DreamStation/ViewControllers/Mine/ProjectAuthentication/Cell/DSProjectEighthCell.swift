//
//  DSProjectEighthCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/15.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSProjectEighthCell: HTBaseTableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var switchBtn: UISwitch!
    @IBOutlet var biaojiImage: UIImageView!
    
    
    var xinfo:DSProjectEighthCellModel!
    var block:passParameterBlock!
    var isHidden:Bool!
    
    override func configurateTheCell(xinfo: HTBaseCellModel) {
        let xinfo:DSProjectEighthCellModel = xinfo as! DSProjectEighthCellModel
        self.xinfo = xinfo
        self.switchBtn.on = xinfo.isAn
        self.titleLabel.text = xinfo.titleValue
        self.block = xinfo.block
        self.biaojiImage.hidden = xinfo.isHidden
    }
    
    @IBAction func switchOfClick(sender: UISwitch) {
        
        self.block(sender.on)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}


class DSProjectEighthCellModel: HTBaseCellModel {
    var titleValue:String!
    var block:passParameterBlock!
    var isHidden:Bool!
    var isAn:Bool!
    
}