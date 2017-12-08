//
//  DSProjectTenthCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/16.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSProjectTenthCell: HTBaseTableViewCell {
    @IBOutlet var rightConstraint: NSLayoutConstraint!

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var btn: UIButton!
    
    var xinfo:DSProjectTenthCellModel!
    var block:selectBlock!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func configurateTheCell(xinfo: HTBaseCellModel) {
        let xinfo:DSProjectTenthCellModel = xinfo as! DSProjectTenthCellModel
        self.block = xinfo.block
        self.btn.hidden = xinfo.hiddenBtn!
        
        if self.btn.hidden == true{
            self.rightConstraint.constant = -20
            self.titleLabel.font = UIFont.systemFontOfSize(14)
            self.titleLabel.textColor = blackContentColor
            self.titleLabel.attributedText = xinfo.titleValue1
        }else{
            let attri:NSMutableAttributedString = NSMutableAttributedString.init(string: xinfo.titleValue!)
            let attch:NSTextAttachment = NSTextAttachment.init()
            attch.image = UIImage.init(named: "homePage_biaoji")
            attch.bounds = CGRectMake(0, 5, 5, 5)
            let string = NSAttributedString.init(attachment: attch)
            
            attri.insertAttributedString(string, atIndex: 4)
            attri.insertAttributedString(string, atIndex: ((xinfo.titleValue?.characters.count)!+1))
            self.titleLabel.attributedText = attri
            //self.titleLabel.text = xinfo.titleValue
        }
       
    }
    
    @IBAction func btnOfClick(sender: UIButton) {
        self.block()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class DSProjectTenthCellModel: HTBaseCellModel {
    var titleValue:String?
    var titleValue1:NSAttributedString?
    var block:selectBlock!
    var hiddenBtn:Bool?
}







