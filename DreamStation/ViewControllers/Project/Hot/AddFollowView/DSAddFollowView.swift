//
//  DSAddFollowView.swift
//  DreamStation
//
//  Created by xjb on 2017/1/12.
//  Copyright © 2017年 QPP. All rights reserved.
//

import UIKit

class DSAddFollowView: UIView {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var confirmBtn: UIButton!
   
    @IBOutlet weak var cancelBtn: UIButton!

    @IBOutlet weak var titleLabel: UILabel!
    var conBlock:selectBlock!
    var canBlock:selectBlock!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.confirmBtn.setTitleColor(greenNavigationColor, forState: .Normal)
        self.cancelBtn.setTitleColor(grayColor, forState: .Normal)
        self.backgroundColor = UIColor.clearColor()
        self.view.backgroundColor = UIColorFromRGB(0x555555)
        self.view.alpha = 0.5
    }
    func getData(title:String,conBlock:selectBlock,canBlock:selectBlock){
        self.titleLabel.text = title
        self.conBlock = conBlock
        self.canBlock = canBlock
    }
    func show(){
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
    }
    @IBAction func btn1(sender: AnyObject) {
        self.conBlock()
        self.bgView.hidden = true
        self.view.hidden = true
    }
    
    @IBAction func btn2(sender: AnyObject) {
        self.canBlock()
        self.bgView.hidden = true
        self.view.hidden = true
    }
    deinit{
        
        print("------------------------------")
        print(NSStringFromClass(self.classForCoder)+"释放")
        print("------------------------------")
    }
}
