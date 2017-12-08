//
//  DSHomePageVideoPlayerCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/25.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSHomePageVideoPlayerCell: HTBaseTableViewCell {

    
    @IBOutlet var VideoImageView: UIImageView!
    
    @IBOutlet var VideoLabel: UILabel!
    
    var xinfo:DSHomePageCellModel!
    var block:selectBlock!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.backgroundColor = UIColor.redColor()
    }
    override func configurateTheCell(xinfo: HTBaseCellModel) {
        let xinfo:DSHomePageCellModel = xinfo as! DSHomePageCellModel
        self.xinfo = xinfo
        if let url=xinfo.imageText {
            self.VideoImageView.sd_setImageWithURL(NSURL.init(string:url), placeholderImage: UIImage.init(named: "homePage_defaultImg"))
        }else{
            self.VideoImageView.image = UIImage.init(named:"homePage_defaultImg")
        }
        self.VideoLabel.text = xinfo.labelText
        self.block = xinfo.block
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected == true {
            self.block()
        }
    }
    
}
