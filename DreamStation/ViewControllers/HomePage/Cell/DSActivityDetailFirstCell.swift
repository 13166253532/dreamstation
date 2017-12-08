//
//  DSActivityDetailFirstCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/25.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSActivityDetailFirstCell: HTBaseTableViewCell {

    
    @IBOutlet var titleImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var statusBtn: UIButton!
    
    var xinfo:DSDetailFirstCellModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func configurateTheCell(xinfo: HTBaseCellModel) {
        let xinfo:DSDetailFirstCellModel = xinfo as! DSDetailFirstCellModel
        self.xinfo = xinfo
    
        if let url = xinfo.titleImageValue{
            self.titleImageView.sd_setImageWithURL(NSURL.init(string: url), placeholderImage:UIImage.init(named: "homePage_activityNom"))
        }else{
            self.titleImageView.image = UIImage.init(named: "homePage_activityNom")
        }
        
        self.titleLabel.text = xinfo.titleLabelValue
   
        if xinfo.status == "UNDERWAY" {
            self.statusBtn.setTitle("进行中", forState: .Normal)
            self.statusBtn.setBackgroundImage(UIImage.init(named: "homePage_activityIng"), forState: .Normal)
           
        }else if xinfo.status == "SIGN_UP_END"{
            self.statusBtn.setTitle("已结束", forState: .Normal)
            self.statusBtn.setBackgroundImage(UIImage.init(named: "homePage_activityend"), forState: .Normal)
        }else{
            self.statusBtn.setTitle("报名中", forState: .Normal)
            self.statusBtn.setBackgroundImage(UIImage.init(named: "homePage_activityJoin"), forState: .Normal)
        }
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

class DSDetailFirstCellModel: HTBaseCellModel {
    
    var titleImageValue:String!
    var titleLabelValue:String!
    var status:String?
}
