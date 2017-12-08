//
//  DSSearchView.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/29.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSSearchView: UIView ,UITextFieldDelegate{

    @IBOutlet var textField: UITextField!
    @IBOutlet var btn: UIButton!
    var cancelBlock:selectBlock!
    var editBlock:selectBlock!
    var valueBlock:passParameterBlock!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let leftImage:UIImageView = UIImageView.init(frame: CGRectMake(10, 5, 15, 15))
        leftImage.image = UIImage.init(named: "Search_sousuo")
        
        let view:UIView = UIView.init(frame: CGRectMake(0, 0, 25, 25))
        view.addSubview(leftImage)
        
        self.textField.leftView = view
        self.textField.leftViewMode = .Always
        self.textField.backgroundColor = NavigationTextFieldColor
        self.textField.placeholder = "输入项目名称"
        self.textField.layer.cornerRadius = 5
        self.textField.clearButtonMode = .Always
        self.textField.delegate = self
        self.textField.returnKeyType = UIReturnKeyType.Go
        
    }

    @IBAction func cancelOfClick(sender: UIButton) {
        
        self.cancelBlock()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField.text?.characters.count > 0 {
            self.valueBlock(textField.text!)
        }
        
        textField.resignFirstResponder()
        return true
    }
    
}
