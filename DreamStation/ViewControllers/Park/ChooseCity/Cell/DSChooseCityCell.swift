//
//  DSChooseCityCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/26.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit
class DSChooseCityModel:HTBaseCellModel{
    var title:String?
    var block:selectBlock!
    var isSelect=false
    

}
class DSChooseCityCell: UICollectionViewCell {
    
    @IBOutlet weak var backgrouundImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
     var block:selectBlock!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    func configurateTheCell(xinfo:HTBaseCellModel){
        let info:DSChooseCityModel = xinfo as! DSChooseCityModel
        self.titleLabel.text = info.title
        self.block = info.block
        if info.isSelect==true{
            self.backgrouundImage.image = UIImage.init(named: "Park_selected")
            self.titleLabel.textColor = UIColorFromRGB(0x22cccc)
        }else{
            self.backgrouundImage.image = UIImage.init(named: "Park_uncheck")
            self.titleLabel.textColor = UIColorFromRGB(0x333333)
        }
    }
}
