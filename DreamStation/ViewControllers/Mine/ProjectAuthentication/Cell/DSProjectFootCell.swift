//
//  DSProjectFootCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/16.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSProjectFootCell: HTBaseTableViewCell {

    @IBOutlet var btn: UIButton!
    var xinfo:DSProjectFootCellModel!
    var block:selectBlock!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.numberOfLines = 0
        self.titleLabel.textColor = greenNavigationColor
    }
    override func configurateTheCell(xinfo: HTBaseCellModel) {
        let xinfo:DSProjectFootCellModel = xinfo as! DSProjectFootCellModel
        
        self.titleLabel.text = "注意：请将视频与BP上传至百度网盘，并创建私密链接"
        self.xinfo = xinfo
        self.btn.setTitle(xinfo.titleValue, forState: .Normal)
        self.block = xinfo.block
    }

    @IBAction func btnOfClick(sender: UIButton) {
        self.block()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

class DSProjectFootCellModel: HTBaseCellModel {
    var titleValue:String?
    var block:selectBlock?
}
