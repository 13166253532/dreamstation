//
//  DSFourthTableViewCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/29.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSFourthTableViewCell: HTBaseTableViewCell {

    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var moreBtn: UIButton!
    
    @IBOutlet weak var bottomLayout: NSLayoutConstraint!
    var info:DSFourthCellModel!
    
    var block:passParameterBlock!
    var cellHeight:CGFloat!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func configurateTheCell(xinfo: HTBaseCellModel) {
        
        self.info  = xinfo as! DSFourthCellModel
        let att = NSMutableAttributedString.init(string: info.detailValue)
        let par = NSMutableParagraphStyle.init()
        par.lineSpacing = 9
        att.addAttribute(NSParagraphStyleAttributeName, value: par, range: NSMakeRange(0,(info.detailValue?.characters.count)!))
        self.detailLabel.attributedText = att
        
        self.detailLabel.lineBreakMode = .ByTruncatingTail
        
        let height = self.getSizeFromString(info.detailValue).height
        if height<26{
            self.moreBtn.hidden=true
            self.bottomLayout.constant=6
        }else if self.getSizeFromString(info.detailValue).height<94{
            self.moreBtn.hidden=true
            self.bottomLayout.constant=10
        }else{
            self.bottomLayout.constant=30
            self.moreBtn.hidden=false
        }
    }
    
    @IBAction func moreBtnOfClick(sender: UIButton) {
        
        sender.selected = !sender.selected
        if sender.selected == true {
            sender.setTitle("返回", forState: .Normal)
            info.isOpen=true
            info.block(0)
            
        }else{
            sender.setTitle("更多", forState: .Normal)
            info.isOpen=false
            info.block(0)
        }
}
    
    
    private func getSizeFromString(str:String)->CGRect{
        let par = NSMutableParagraphStyle.init()
        par.lineSpacing = 9
        
        let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(14),NSParagraphStyleAttributeName:par]
        
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        
        let rect:CGRect = str.boundingRectWithSize(CGSizeMake(SCREEN_WHIDTH()-30, 1000), options: option, attributes: attributes, context: nil)
        return rect
    }

    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}



class DSFourthCellModel: HTBaseCellModel {
    
    var titleValue:String!
    var detailValue:String!
    var block:passParameterBlock!
    var cellHeight:CGFloat!
    var isOpen=false
    
    
    
}

