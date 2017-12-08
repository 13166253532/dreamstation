//
//  DSAgencySeventhCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/5.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSAgencySeventhCell: HTBaseTableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailBtn: UIButton!
    
    @IBOutlet weak var iImage: UIImageView!
    @IBOutlet weak var imageRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageRightConstrant2: NSLayoutConstraint!
    @IBOutlet var biaojiImage: UIImageView!
    
    
    var xinfo:DSAgencySeventhCellModel!
    var block:selectBlock!
    var isHidden:Bool!
    
    override func configurateTheCell(xinfo: HTBaseCellModel) {
        
        self.iImage.contentMode = .ScaleToFill
        
        let xinfo:DSAgencySeventhCellModel = xinfo as! DSAgencySeventhCellModel
        self.xinfo = xinfo
        self.titleLabel.text = xinfo.titleValue
        self.block = xinfo.block
        self.biaojiImage.hidden = xinfo.isHidden
//        self.accessoryType = .DisclosureIndicator
       
        
        if let imageUrl=xinfo.imageUrl{
//            self.iImage.sd_setImageWithURL(NSURL.init(string: imageUrl))
            self.iImage.sd_setImageWithURL(NSURL.init(string: imageUrl), placeholderImage: UIImage.init(named: "Agency_shenfenzheng"))
        }
        if xinfo.backImage != nil{
            self.iImage.image = xinfo.backImage
        }
        if xinfo.isHiddenArrow==false{
            self.imageRightConstraint.constant=0
            self.imageRightConstrant2.constant=0
            self.accessoryType = .DisclosureIndicator
        }
        
        

    }
    
    @IBAction func ClickOfBtn(sender: UIButton) {
        self.block()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.separatorInset=UIEdgeInsetsMake(0, SCREEN_WHIDTH(), 0, 0)
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

class DSAgencySeventhCellModel: HTBaseCellModel {
    var titleValue:String!
    var imageUrl:String?
    var block:selectBlock!
    var isHidden:Bool!
    var isHiddenArrow=true
    var backImage:UIImage!
}
