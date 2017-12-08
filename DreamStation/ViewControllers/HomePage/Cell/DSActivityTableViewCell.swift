//
//  DSActivityTableViewCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/25.
//  Copyright © 2016年 QPP. All rights reserved.


import UIKit

class DSActivityTableViewCell: HTBaseTableViewCell {

    
    @IBOutlet var activityImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var statusBtn: UIButton!
    
    var selectCell:selectBlock!
    
//    var selectCell:activityBlock!
    
    var xinfo:DSActivityCellModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func configurateTheCell(xinfo: HTBaseCellModel) {
        
        let xinfo:DSActivityCellModel = xinfo as! DSActivityCellModel
        self.xinfo = xinfo
        
        if let url = xinfo.activityImage{
            self.activityImage.sd_setImageWithURL( NSURL.init(string:url ), placeholderImage: UIImage.init(named: "homePage_activityNom"))
        }else{
            self.activityImage.image = UIImage.init(named: "homePage_activityNom")
        }
        
        self.titleLabel.text = xinfo.titleValue
        self.locationLabel.text = xinfo.locationValue
        self.dateLabel.text = xinfo.dateValue
        
        self.selectCell = xinfo.block
        
        if xinfo.status != nil && xinfo.status == "UNDERWAY" {
            self.statusBtn.setTitle("进行中", forState: .Normal)
            self.statusBtn.setBackgroundImage(UIImage.init(named: "homePage_activityIng"), forState: .Normal)
        }else if xinfo.status != nil && xinfo.status == "SIGN_UP_END"{
            self.statusBtn.setTitle("已结束", forState: .Normal)
            self.statusBtn.setBackgroundImage(UIImage.init(named: "homePage_activityend"), forState: .Normal)
        }else{
            self.statusBtn.setTitle("报名中", forState: .Normal)
            self.statusBtn.setBackgroundImage(UIImage.init(named: "homePage_activityJoin"), forState: .Normal)
        }
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected == true {
            self.selectCell()
        }
        
        // Configure the view for the selected state
    }
    
}

class DSActivityCellModel: HTBaseCellModel {
    
    var activityImage:String?
    var titleValue:String!
    var locationValue:String!
    var dateValue:String!
    var status:String!
    var block:selectBlock!
    var detailValue:String!
    
}

