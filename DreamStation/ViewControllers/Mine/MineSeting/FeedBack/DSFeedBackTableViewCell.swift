//
//  DSFeedBackTableViewCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/25.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit


class HISTextViewCellInfo : HTBaseCellModel {
    var tv : BRPlaceholderTextView?
    var title : String = ""
    var content : String?
    var placeholder : String?
    var chose : Bool = false
    var gotoNextBlock : ((AnyObject)->Void)?
    var height : CGFloat = 44
}
class DSFeedBackTableViewCell: HTBaseTableViewCell {
    var info = HISTextViewCellInfo()
    let tv = BRPlaceholderTextView()
 
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.whiteColor()
        tv.frame = CGRectMake(15, 0, SCREEN_WHIDTH()-20, CGRectGetHeight(self.frame))
        tv.setPlaceholderFont(UIFont.systemFontOfSize(15))
        tv.font = UIFont.systemFontOfSize(15)
        tv.setPlaceholderColor(UIColor.lightGrayColor())
        self.contentView.addSubview(tv)
    }
    override func configurateTheCell(cellInfo: HTBaseCellModel) {
        info = cellInfo as! HISTextViewCellInfo
        info.tv = tv
        tv.placeholder = info.placeholder
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.separatorInset=UIEdgeInsetsMake(0, SCREEN_WHIDTH(), 0, 0)
    }

}
