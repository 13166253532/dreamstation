//
//  DSAuthenticationViewCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSAuthenticationViewCell: HTBaseTableViewCell {
   
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!

    var block:selectBlock!
    
    override func configurateTheCell(xinfo: HTBaseCellModel) {
        
        let xinfo:DSAuthenticationViewCellModel = xinfo as! DSAuthenticationViewCellModel
        self.titleLabel.text = xinfo.title
        self.block = xinfo.block
        
        
        if DSAccountInfo.sharedInstance().AuthenticationStatus == "unAuthentication" || DSAccountInfo.sharedInstance().AuthenticationStatus == nil {
            self.subTitleLabel.text = "未认证"
        }else if DSAccountInfo.sharedInstance().AuthenticationStatus == "CHECKING"{
            self.subTitleLabel.text = "认证中"
        }else if DSAccountInfo.sharedInstance().AuthenticationStatus == "REFUSED"{
            self.subTitleLabel.text = "认证未通过"
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.subTitleLabel.textColor=grayColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected==true {
            self.block()
        }
    }
    
}

class DSAuthenticationViewCellModel: HTBaseCellModel {
    var title:String?
    var isAuthentication:Bool?
    var block:selectBlock!
}
