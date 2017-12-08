//
//  DSMinePleaseFocusCell.swift
//  DreamStation
//
//  Created by xjb on 16/8/25.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSMinePleaseFocusCell: HTBaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subLabel: UILabel!
    
    @IBOutlet weak var btn1: UIButton!
    
    
    @IBOutlet weak var btn2: UIButton!
    
    @IBOutlet weak var btn3: UIButton!
    
    @IBOutlet weak var layout: NSLayoutConstraint!
    
    
    var block:selectBlock!
    var videoBlock:selectBlock!
    var xinfo:DSPleaseFocusCellModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clearColor()
        btn1.setBackgroundImage(UIImage(named:"Project_twoWord"), forState: UIControlState.Normal)
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected==true {
            self.block()
        }
    }
    
    override func configurateTheCell(xinfo: HTBaseCellModel) {
        let xinfo:DSPleaseFocusCellModel = xinfo as! DSPleaseFocusCellModel
        self.xinfo = xinfo
        self.titleLabel.text = xinfo.titleValue
        self.subLabel.text = xinfo.detailValue
        self.block = xinfo.block
        self.videoBlock = xinfo.videoBlock
        if xinfo.detailValue?.characters.count > 27 {
            self.layout.constant = 0
        }else{
            self.layout.constant = 6
        }
        
        if xinfo.categories.count==0{
            self.btn1.hidden=true
            self.btn2.hidden=true
            self.btn3.hidden=true
        }else if xinfo.categories.count==1{
            self.btn1.hidden=false
            self.btn2.hidden=true
            self.btn3.hidden=true
            chooseBtnWithTitle(btn1, title: xinfo.categories[0] as! String)
        }else if xinfo.categories.count==2{
            self.btn1.hidden=false
            self.btn2.hidden=false
            self.btn3.hidden=true
            chooseBtnWithTitle(btn1, title: xinfo.categories[0] as! String)
            chooseBtnWithTitle(btn2, title: xinfo.categories[1] as! String)
        }else if xinfo.categories.count==3{
            self.btn1.hidden=false
            self.btn2.hidden=false
            self.btn3.hidden=false
            chooseBtnWithTitle(btn1, title: xinfo.categories[0] as! String)
            chooseBtnWithTitle(btn2, title: xinfo.categories[1] as! String)
            chooseBtnWithTitle(btn3, title: xinfo.categories[2] as! String)
        }
    }

    func chooseBtnWithTitle(btn:UIButton,title:String){
        if title.characters.count==2{
            btn.setBackgroundImage(UIImage(named: "Project_twoWord"), forState: UIControlState.Normal)
        }else if title.characters.count==3{
            btn.setBackgroundImage(UIImage(named: "Project_threeWord"), forState: UIControlState.Normal)
        }else if title.characters.count==4{
            btn.setBackgroundImage(UIImage(named: "Project_fourWord"), forState: UIControlState.Normal)
        }else if title.characters.count==4{
            btn.setBackgroundImage(UIImage(named: "Project_fiveWord"), forState: UIControlState.Normal)
        }
        btn.setTitle(title, forState:UIControlState.Normal)
    }

    
    @IBAction func videoBtn(sender: AnyObject) {
        self.videoBlock()
    }
}

class DSPleaseFocusCellModel: HTBaseCellModel {
    var titleValue:String?
    var detailValue:String?
    ///订单
    var orderId:String?
    ///itemId
    var itemId:String?
    var categories:NSMutableArray=NSMutableArray()
    var block:selectBlock!
    var videoBlock:selectBlock!
    
}
