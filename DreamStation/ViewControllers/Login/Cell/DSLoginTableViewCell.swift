
//
//  DSLoginTableViewCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/19.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

let ALPHANUM = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

class DSLoginTableViewCell: HTBaseTableViewCell,UITextFieldDelegate {

    @IBOutlet var textField: UITextField!
    
    @IBOutlet var btn: JKCountDownButton!
    
    var xinfo:DSLoginCellModel!
    var returnBlock:passParameterBlock!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.btn.setTitleColor(greenNavigationColor, forState: .Normal)
        self.textField.delegate = self
        self.textField.setPlaceholderColor(placeholderColor)
    }

    override func configurateTheCell(info: HTBaseCellModel) {
        
        let xinfo:DSLoginCellModel = info as! DSLoginCellModel
        self.xinfo = xinfo
        self.textField.text = xinfo.value
        self.textField.secureTextEntry = xinfo.secureText
        self.textField.placeholder = xinfo.placeholder
        self.returnBlock = xinfo.returnBlock
        if xinfo.hideTheBtn == true {
            self.btn.hidden = true
        }else{
            self.btn.hidden = false
            self.btn.setTitle(xinfo.btnTitle, forState: .Normal)
        }
        if xinfo.btnHasBound == true {
            self.btn.setBackgroundImage(UIImage.init(named: "signUp_btn_Bg"), forState: .Normal)
            //self.btn.setTitleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
            self.btn.titleLabel?.font = UIFont.systemFontOfSize(12)
        }
        if xinfo.btnFontSize>0{
            self.btn.titleLabel?.font=UIFont.systemFontOfSize(CGFloat(xinfo.btnFontSize))
        }
    }

    func textFieldDidEndEditing(textField: UITextField) {
        if self.returnBlock != nil{
            self.returnBlock(textField.text!)
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func ClickBtn(sender: JKCountDownButton) {
        self.xinfo.btnBlock()
        
        if self.xinfo.startCountdown==true {
            sender.enabled = false
            sender.startWithSecond(60)
            sender.didChange({ (countDownButton:JKCountDownButton!, second:Int32) -> String! in
                let str:String = String(format:" %d s",second)
                return str
            })
            sender.didFinished({ (countDownButton:JKCountDownButton!, second:Int32) -> String! in
                countDownButton.enabled = true
                return self.xinfo.btnTitle
            })
        }
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

class DSLoginCellModel: HTBaseCellModel {
    
    var placeholder:String!
    var hideTheBtn:Bool!
    var btnTitle:String!
    var text:String?
    
    var btnHasBound:Bool=false

    var secureText:Bool = false
    var value:String?
    
    var btnBlock:selectBlock!
    var startCountdown:Bool=false
    
    var returnBlock:passParameterBlock!
    
    var btnFontSize=0
}

