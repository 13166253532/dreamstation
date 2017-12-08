//
//  DSProjectNinthCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/16.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSProjectNinthCell: HTBaseTableViewCell,UITextFieldDelegate {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailText: UITextField!
    @IBOutlet var suffixLabel: UILabel!
    
    var xinfo:DSProjectNinthCellModel!
    var block:passParameterBlock!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.detailText.delegate = self
    }
    
    override func configurateTheCell(xinfo: HTBaseCellModel) {
        
        let xinfo:DSProjectNinthCellModel = xinfo as! DSProjectNinthCellModel
        self.titleLabel.text = xinfo.titleValue
        self.detailText.placeholder = xinfo.detailValue
        if xinfo.numKeyboardType == true {
          self.detailText.keyboardType = UIKeyboardType.DecimalPad
        }
        self.detailText.text = xinfo.text
        self.suffixLabel.text = xinfo.suffixValue
        self.block = xinfo.block
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.block(textField.text!)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.block(textField.text!)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

class DSProjectNinthCellModel: HTBaseCellModel {
    var titleValue:String?
    var detailValue:String?
    var suffixValue:String?
    var text:String?
    var block:passParameterBlock!
    var numKeyboardType = false
    
}
