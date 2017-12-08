//
//  DSHotVideoTableViewCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/28.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSHotVideoTableViewCell: HTBaseTableViewCell {

    var block:selectBlock!
    var xinfo:DSHotVideoCellModel!
    
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var layoutConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clearColor()
       
        // Initialization code
    }
    
    override func configurateTheCell(xinfo: HTBaseCellModel) {
        let xinfo:DSHotVideoCellModel = xinfo as! DSHotVideoCellModel
        self.xinfo = xinfo
        self.block = xinfo.block
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected == true {
            self.block()
        }
    }
    
}

class DSHotVideoCellModel: HTBaseCellModel {
    var block:selectBlock!
    var videoUrl:String?
}
