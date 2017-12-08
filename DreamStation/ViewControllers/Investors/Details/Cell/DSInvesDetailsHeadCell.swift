//
//  DSInvesDetailsHeadCell.swift
//  DreamStation
//
//  Created by xjb on 16/8/1.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSInvesDetailsHeadCellModel: HTBaseCellModel {
    
    /// 投资者头像
    var InvesHeadImage:UIImage!
    /// 投资者头像Url
    var InvesHeadImageUrl:String?
    /// 投资者名字
    var InvesName:String?
    /// 投资者类型
    var InvesType:String?
    /// 浏览数
    var BrowseNum:String?
    /// 热度
    var HeatNum:String?
    /// 主要内容
    var title:String?
    /// 注释
    var subTitle:String?
    /// 是否展开
    var isAn:Bool!
    /// 是否收藏
    var isCollection:Bool!
    /// 是否关注
    var isFocus:Bool!
    /// 收藏
    var isCollectionBlock:selectBlock!
    /// 关注
    var isFocusBlock:selectBlock!
    ///
    var cellHeight:CGFloat?
    
    
    var block:selectBlock!
    var guanBlock:passParameterBlock!
    
    
    
}


class DSInvesDetailsHeadCell: HTBaseTableViewCell {
    
    @IBOutlet weak var invesHeadImage: UIImageView!

    @IBOutlet weak var nameTitleLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
   
    
    @IBOutlet weak var browseLabel: UILabel!
    
    @IBOutlet weak var heatLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.invesHeadImage.layer.cornerRadius = 30
        self.invesHeadImage.layer.masksToBounds = true
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
   
    }
    override func configurateTheCell(xinfo:HTBaseCellModel){
        let info:DSInvesDetailsHeadCellModel = xinfo as! DSInvesDetailsHeadCellModel
        if let url = info.InvesHeadImageUrl {
            self.invesHeadImage.sd_setImageWithURL(NSURL.init(string:url ), placeholderImage: UIImage.init(named: "Inves_peoheadImage"))
        }else{
            self.invesHeadImage.image = UIImage.init(named: "Inves_peoheadImage")
        }
        self.nameTitleLabel.text = info.InvesName
        self.subTitleLabel.text = info.InvesType
        self.browseLabel.text = info.BrowseNum
        self.heatLabel.text = info.HeatNum
    }
}
