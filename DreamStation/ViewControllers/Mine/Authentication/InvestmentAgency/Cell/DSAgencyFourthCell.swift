//
//  DSAgencyFourthCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/3.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSAgencyFourthCell: HTBaseTableViewCell,UITextViewDelegate{
    @IBOutlet var titleLabel: UILabel!
    var isFirst:Bool!
    
    var detailText: BRPlaceholderTextView!
    var xinfo:DSAgencyFourthCellModel!
    var block:passParameterBlock!
    var contBlock:selectBlock!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.detailText = BRPlaceholderTextView.init(frame: CGRectMake(15, 45, SCREEN_WHIDTH()-30,CGRectGetHeight(self.frame)-45))
        //self.detailText = BRPlaceholderTextView.init()
        self.detailText.setPlaceholderFont(UIFont.systemFontOfSize(14))
        self.detailText.font = UIFont.systemFontOfSize(14)
        self.detailText.setPlaceholderColor(UIColor.lightGrayColor())
        self.detailText.delegate = self
//        self.detailText.addMaxTextLengthWithMaxLength(150) { (detailText) in
//            self.contBlock()
//        }
//        self.detailText.addMaxTextLengthWithMaxLength(150,andEvent({
//            [weak self] in
//            self.contBlock()
//        }))
        self.detailText.maxTextLength = 150
        self.contentView.addSubview(self.detailText)
    }
    override func configurateTheCell(xinfo: HTBaseCellModel) {
        let xinfo:DSAgencyFourthCellModel = xinfo as! DSAgencyFourthCellModel
        self.xinfo = xinfo
        self.isFirst = false
        self.titleLabel.text = xinfo.titleValue
        self.detailText.placeholder = xinfo.placeHolder
        if xinfo.contBlock != nil {
            self.contBlock = xinfo.contBlock
        }
        self.block = xinfo.block
        if xinfo.content?.characters.count>0 {
            self.detailText.text = xinfo.content
        }
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        IQKeyboardManager.sharedManager().enable = true
    }
    
    
    
    
    
    //字数限制
//    func textViewDidChange(textView: UITextView) {
//        print("输入的字数=",textView.text.characters.count)
//        if textView.text.characters.count >= 150 && self.isFirst == false{
//            if self.contBlock != nil {
//                self.contBlock()
//                self.isFirst = true
//            }
//        }else{
//            self.isFirst = false
//        }
//    }
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        print("输入的字数=",textView.text.characters.count)
        var str = textView.text as NSString
        if str.length > 150 && self.isFirst == false {
            if self.contBlock != nil {
                str = str.substringToIndex(150)
                textView.text = str as String
                self.contBlock()
                self.isFirst = true
            }
        }else{
            self.isFirst = false
        }
        return true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.separatorInset=UIEdgeInsetsMake(0, SCREEN_WHIDTH(), 0, 0)
    }
    func textViewDidEndEditing(textView: UITextView) {
        self.block(textView.text)
    }
}
class DSAgencyFourthCellModel: HTBaseCellModel {
    var titleValue:String!
    var placeHolder:String!
    var content:String?
    var block:passParameterBlock!
    var contBlock:selectBlock!
}

