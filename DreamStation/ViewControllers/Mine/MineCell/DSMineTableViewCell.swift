//
//  DSMineTableViewCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/19.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSMineTableViewCell: HTBaseTableViewCell {

    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var labelSubTitle: UILabel!
    
    @IBOutlet weak var redPoint: UIImageView!

    @IBOutlet weak var rightLayout: NSLayoutConstraint!

    var block:selectBlock!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.labelSubTitle.textColor=grayColor
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected==true {
            self.block()
        }
    }

    override func configurateTheCell(info: HTBaseCellModel) {
        let xinfo: DSMineCellModel = info as! DSMineCellModel
        self.imageV.image = UIImage(named: xinfo.image)
        self.labelTitle.text = xinfo.title
        self.block = xinfo.block
        if xinfo.subTitle == nil{
            self.labelSubTitle.hidden = true
        }else{
            self.labelSubTitle.hidden = false
            self.labelSubTitle.text = xinfo.subTitle
        }
        
        if xinfo.numOfPeople != nil{
            self.accessoryType = .None
            self.rightLayout.constant=15
            let str:String = xinfo.numOfPeople!+xinfo.subTitle!
            let myMutableString = NSMutableAttributedString(string: str)
            myMutableString.addAttribute(NSForegroundColorAttributeName, value:greenNavigationColor, range:NSRange(location:0,length:xinfo.numOfPeople!.characters.count))
            self.labelSubTitle.attributedText = myMutableString
            
        }else{
            self.accessoryType = .DisclosureIndicator
        }
        self.redPoint.hidden = !xinfo.hasRedPoint
    }
}

class DSMineCellModel: HTBaseCellModel {
    var image:String!/// 图片名
    var title:String!/// cell名
    var subTitle:String?/// cell注释
    var hasRedPoint:Bool=false
    var numOfPeople:String?//投资人数
    
    var block:selectBlock!/// cell的响应事件
}
