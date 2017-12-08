//
//  DSProjectEleventhCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/16.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSProjectEleventhCell: HTBaseTableViewCell,UITextFieldDelegate {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailText: UITextField!
    
    @IBOutlet var biaojiImage: UIImageView!
    
    @IBOutlet weak var placeholderLabel: UILabel!
    
    var xinfo:DSProjectEleventhCellModel!
    var block:passParameterBlock!
    var attentionBlock:selectBlock?
    var isHidden:Bool?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.detailText.delegate = self
        self.placeholderLabel.hidden = true
    }
    
    override func configurateTheCell(xinfo: HTBaseCellModel) {
        let xinfo:DSProjectEleventhCellModel = xinfo as! DSProjectEleventhCellModel
        self.xinfo = xinfo
//        if SCREEN_WHIDTH() <= 320 {
//           addn()
//        }
        addXiaobiaoji()
        //self.titleLabel.text = xinfo.titleValue
        if xinfo.detailValue == nil || xinfo.detailValue?.characters.count == 0 {
            self.placeholderLabel.hidden = false
        }
        self.detailText.text = xinfo.detailValue
        self.placeholderLabel.text = xinfo.placeholderValue
        self.biaojiImage.hidden = xinfo.isHidden!
        self.block = xinfo.block
        self.attentionBlock = xinfo.attentionBlock
    }
    func addXiaobiaoji(){
        let attri:NSMutableAttributedString = NSMutableAttributedString.init(string: xinfo.titleValue!)
        let attch:NSTextAttachment = NSTextAttachment.init()
        attch.image = UIImage.init(named: "homePage_biaoji")
        attch.bounds = CGRectMake(0, 5, 5, 5)
        let string = NSAttributedString.init(attachment: attch)
        attri.insertAttributedString(string, atIndex: (xinfo.titleValue?.characters.count)!)
        self.titleLabel.attributedText = attri
    }

    func addn() {
        if xinfo.placeholderValue?.characters.count > 12 {
            xinfo.placeholderValue?.insert("\n", atIndex: (xinfo.placeholderValue?.startIndex.advancedBy(10))!)
        }
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        self.placeholderLabel.hidden = true
    }
    func textFieldDidEndEditing(textField: UITextField) {
        self.block(textField.text!)
        if textField.text?.characters.count == 0 {
            self.placeholderLabel.hidden = false
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.block(textField.text!)
        if textField.text?.characters.count == 0 {
            self.placeholderLabel.hidden = false
        }
        return true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

class DSProjectEleventhCellModel: HTBaseCellModel {
    var titleValue:String?
    var detailValue:String?
    var placeholderValue:String?
    var isHidden:Bool?
    var block:passParameterBlock?
    var attentionBlock:selectBlock?
}
