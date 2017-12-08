//
//  DSAgencyFirstCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/3.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSAgencyFirstCell: HTBaseTableViewCell,UITextFieldDelegate{

    @IBOutlet var titleLabel: UILabel!
   
    @IBOutlet var biaojiImage: UIImageView!
    
    @IBOutlet weak var detailText: UITextField!
    var isHidden:Bool!
    var xinfo:DSAgencyFirstCellModel!
    var block:passParameterBlock!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.detailText.delegate = self
        self.detailText.textColor = blackContentColor
    }

    override func configurateTheCell(xinfo: HTBaseCellModel) {
        
        let xinfo:DSAgencyFirstCellModel = xinfo as! DSAgencyFirstCellModel
        self.xinfo = xinfo
        self.titleLabel.text = xinfo.titleValue
        self.detailText.tintColor = UIColorFromRGB(0x000000)
        
        self.detailText.text=xinfo.detailValue
        self.detailText.placeholder = xinfo.placeholderValue
        self.block = xinfo.block
        self.biaojiImage.hidden = xinfo.isHidden!
        self.detailText.addTarget(self, action: #selector(arrowResponse), forControlEvents: UIControlEvents.EditingChanged)
        
    }
    func arrowResponse(textField:UITextField){
        self.block(textField.text!)
        //print(self.detailText.bounds.size.width)
        //getSizeW(textField.text!)
        
    }
    func getSizeW(str:String){
        let par = NSMutableParagraphStyle.init()
        let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(14),NSParagraphStyleAttributeName:par]
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let rect:CGRect = str.boundingRectWithSize(CGSizeMake(SCREEN_WHIDTH(), 1000), options: option, attributes: attributes, context: nil)
        print(rect.width)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.block(textField.text!)
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.block(textField.text!)
    }

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return self.xinfo.isCanEdit
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.separatorInset=UIEdgeInsetsMake(0, SCREEN_WHIDTH(), 0, 0)
    }
    
}

class DSAgencyFirstCellModel: HTBaseCellModel {
    
    var titleValue:String!
    var detailValue:String?
    var placeholderValue:String?
    var block:passParameterBlock!
    var isHidden:Bool!
    var isCanEdit:Bool!
    
}
