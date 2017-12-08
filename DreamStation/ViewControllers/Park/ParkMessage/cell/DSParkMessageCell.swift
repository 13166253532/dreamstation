//
//  DSParkMessageCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/25.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit
class DSParkMessageCellInfo : HTBaseCellModel {
    var textField :UITextField?
    
    var title : String?
}
class DSParkMessageCell: HTBaseTableViewCell {

   
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var myTextField: UITextField!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func configurateTheCell(zinfo:HTBaseCellModel){
        let info:DSParkMessageCellInfo=zinfo as! DSParkMessageCellInfo
        info.textField = self.myTextField
        self.titleLabel.text=info.title
        self.myTextField.placeholder = "请输入"
        
    }
}
