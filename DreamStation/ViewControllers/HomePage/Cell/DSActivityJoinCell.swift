//
//  DSActivityJoinCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/26.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSActivityJoinCell: HTBaseTableViewCell,UITextFieldDelegate{

    @IBOutlet var label: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var biaoJiImage: UIImageView!
    
    var xinfo:DSActivityJoinCellModel!
    var block:passParameterBlock!
    var isHidden:Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textField.delegate = self
        self.textField.setPlaceholderColor(placeholderColor)
        self.textField.placeholder = "请输入"
        
    }
    
    override func configurateTheCell(xinfo: HTBaseCellModel) {
        let xinfo:DSActivityJoinCellModel = xinfo as! DSActivityJoinCellModel
        self.xinfo = xinfo
        self.label.text = xinfo.labelValue
        self.block = xinfo.block
        self.textField.text = xinfo.textValue
        self.biaoJiImage.hidden = xinfo.isHidden!
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.xinfo.textValue = textField.text
        self.block(textField.text!)
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.xinfo.textValue = textField.text
        self.block(textField.text!)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

class DSActivityJoinCellModel: HTBaseCellModel {
    var labelValue:String!
    var isHidden:Bool?
    var block:passParameterBlock!
    var textValue:String?

}
