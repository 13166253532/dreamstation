//
//  DSHotTableViewCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/28.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSHotTableViewCell: HTBaseTableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    
    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var btn2: UIButton!
    
    @IBOutlet weak var btn3: UIButton!
    
    var block:selectBlock!
    var xinfo:DSHotCellModel!
    var count:Int!
    
    @IBOutlet weak var layoutConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btn1.setBackgroundImage(UIImage(named:"Project_twoWord"), forState: UIControlState.Normal)
        self.backgroundColor = UIColor.clearColor()
    }
    override func configurateTheCell(xinfo: HTBaseCellModel) {
        let xinfo:DSHotCellModel = xinfo as! DSHotCellModel
        self.xinfo = xinfo
        self.titleLabel.text = xinfo.titleValue
        self.detailLabel.text = xinfo.detailValue
        self.block = xinfo.block
        if SCREEN_WHIDTH() <= 320 {
            self.count = 24
        }else{
            self.count = 36
        }
        if xinfo.detailValue?.characters.count > self.count {
            self.layoutConstraint.constant = 0
        }else{
            self.layoutConstraint.constant = 6
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
        }else if xinfo.categories.count>=3{
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
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected == true {
            self.block()
        }
    }
}
class DSHotCellModel: HTBaseCellModel {
    var titleValue:String?
    var detailValue:String?
    var categories:NSMutableArray=NSMutableArray()
    var block:selectBlock!
}
