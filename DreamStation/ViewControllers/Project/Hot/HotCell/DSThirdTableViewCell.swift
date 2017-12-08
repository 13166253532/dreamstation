//
//  DSThirdTableViewCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/29.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSThirdTableViewCell: HTBaseTableViewCell {

    
    @IBOutlet weak var isShowImageView: UIImageView!
    
    @IBOutlet weak var isShowLabel: UILabel!
    @IBOutlet weak var isDeepImageView: UIImageView!
    
    @IBOutlet weak var isDeepLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func configurateTheCell(info: HTBaseCellModel) {
        let xinfo:DSThirdCellModel = info as! DSThirdCellModel
        let list = NSMutableArray()
        if xinfo.isShow != nil {
            if xinfo.isShow! == "是" {
                list .addObject("上过梦想下一站节目")
            }
        }
        if xinfo.IsDeep != nil {
            if xinfo.IsDeep! == "是" {
                list .addObject("深度推荐")
            }
        }
        if list.count == 1 {
            self.isShowImageView.image = UIImage.init(named: "Hot_OK")
            self.isShowLabel.text = list[0] as? String
        }else if list.count == 2{
            self.isShowImageView.image = UIImage.init(named: "Hot_OK")
            self.isShowLabel.text = list[0] as? String
            self.isDeepImageView.image = UIImage.init(named: "Hot_OK")
            self.isDeepLabel.text = list[1] as? String
        }
//        if xinfo.IsDeep! == "1" {
//            self.isDeepImageView.image = UIImage.init(named: "Hot_OK")
//            self.isDeepLabel.text = "深度推荐"
//        }
//        if xinfo.isShow! == "1" {
//            self.isShowImageView.image = UIImage.init(named: "Hot_OK")
//            self.isShowLabel.text = "上过极客出发节目"
//        }
    }
}
class DSThirdCellModel: HTBaseCellModel {
    var isShow:String?
    var IsDeep:String?
    
}
