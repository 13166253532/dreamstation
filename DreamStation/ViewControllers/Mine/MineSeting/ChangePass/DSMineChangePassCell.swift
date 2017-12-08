//
//  DSMineChangePassCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/21.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSMineChangePassCell: HTBaseTableViewCell ,UITextFieldDelegate{

    @IBOutlet weak var myTextField: UITextField!
    
    var xinfo:DSSetingPassModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.myTextField.delegate = self
        self.myTextField.setPlaceholderColor(placeholderColor)
    }
    
    override func configurateTheCell(info: HTBaseCellModel) {
        
        let xinfo:DSSetingPassModel = info as! DSSetingPassModel
        self.xinfo = xinfo
        self.myTextField.secureTextEntry = true
        self.myTextField.placeholder = xinfo.placeholder
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.xinfo.value = textField.text
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }

}
