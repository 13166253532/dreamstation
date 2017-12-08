//
//  DSLoginUserIDTableViewCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/20.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSLoginUserIDTableViewCell: HTBaseTableViewCell {

    @IBOutlet var investorBtn: UIButton!  //投资方
    
    @IBOutlet var projectBtn: UIButton!   //项目方
    
    var xinfo:DSLoginUserCellModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        investorBtn.setBackgroundImage(UIImage.init(named: "userIDSelect"), forState: .Normal)
        self.projectBtn.setBackgroundImage(UIImage.init(named: "userIDUnselect"), forState:.Normal)
        
    }
    
    override func configurateTheCell(info: HTBaseCellModel){
    
        let xinfo:DSLoginUserCellModel = info as! DSLoginUserCellModel
        self.xinfo = xinfo
        
    }

    @IBAction func projectBtnOfClick(sender: UIButton) {

        self.xinfo.btnBlock2()
        sender.setBackgroundImage(UIImage.init(named: "userIDSelect"), forState: .Normal)
        sender.setTitleColor(greenNavigationColor, forState: UIControlState.Normal)
        self.investorBtn.setBackgroundImage(UIImage.init(named: "userIDUnselect"), forState: .Normal)
        self.investorBtn.setTitleColor(grayColor, forState: UIControlState.Normal)

    }
    
    @IBAction func investorBtnOfClick(sender: UIButton) {
        
        self.xinfo.btnBlock()
        sender.setBackgroundImage(UIImage.init(named: "userIDSelect"), forState: .Normal)
        sender.setTitleColor(greenNavigationColor, forState: UIControlState.Normal)
        self.projectBtn.setBackgroundImage(UIImage.init(named: "userIDUnselect"), forState:.Normal)
        self.projectBtn.setTitleColor(grayColor, forState: UIControlState.Normal)
       
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class DSLoginUserCellModel:HTBaseCellModel{

    
    var btnBlock:selectBlock!
    var btnBlock2:selectBlock!
}
