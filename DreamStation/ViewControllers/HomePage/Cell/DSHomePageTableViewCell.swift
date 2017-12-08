//
//  DSHomePageTableViewCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/21.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSHomePageTableViewCell: HTBaseTableViewCell {

    @IBOutlet var cellBGImage: UIImageView!
    
    @IBOutlet var cellText: UILabel!
    
    @IBOutlet weak var leftImage: UIImageView!
    
    var block:selectBlock!
    var xinfo:DSHomePageCellModel!
    var bizhiBlock:passParameterBlock!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.whiteColor()
    }

    override func configurateTheCell(info: HTBaseCellModel) {
    
        let xinfo:DSHomePageCellModel = info as! DSHomePageCellModel
        self.xinfo = xinfo
        if let url=xinfo.imageText {
            self.cellBGImage.sd_setImageWithURL(NSURL.init(string: url), placeholderImage: UIImage.init(named: "homePage_defaultImg"))
        }else{
            self.cellBGImage.image = UIImage.init(named:"homePage_defaultImg")
        }
        self.getOrder(xinfo)
        self.cellText.text = xinfo.labelText
        self.block = xinfo.block
    }
    
    func getOrder(httpinfo:DSHomePageCellModel) {
        var typeStr = String()
        if httpinfo.type != nil {
            typeStr = httpinfo.type!
        }
        switch typeStr {
        case "PROVIDER":
            self.leftImage.image = UIImage.init(named: "homePage_greenLeft")
            break
        case "INDIVIDUAL":
            self.leftImage.image = UIImage.init(named: "homePage_orangeLeft")
            break
        case "PARK":
            self.leftImage.image = UIImage.init(named: "homePage_purpleLeft")
            break
        default:
            break
        }
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.separatorInset=UIEdgeInsetsMake(0, SCREEN_WHIDTH(), 0, 0)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected == true {
            self.block()
        }
    }
}

class DSHomePageCellModel: HTBaseCellModel {
    var type:String?
    var labelText:String!
    var imageText:String!
    var block:selectBlock!
    
}
