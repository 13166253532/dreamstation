//
//  DSScreeningCollectionViewCell.swift
//  DreamStation
//
//  Created by xjb on 16/8/2.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSScreeningCollectionViewCell: HTBaseCollectionViewCell {

    @IBOutlet weak var bagImageView: UIImageView!
   
    @IBOutlet weak var titleLabel: UILabel!
    
    /// 是否选中
    var isSelect:Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func configurateTheCell(xinfo:HTBaseCollectionViewCellModel){
        let info:DSScreenCollectionCellModel = xinfo as! DSScreenCollectionCellModel
        self.titleLabel.text = info.title
        self.isSelect = info.isSelect
        
        if !info.isSelect{
            self.bagImageView.image = UIImage.init(named: "Park_uncheck")
            self.titleLabel.textColor = UIColorFromRGB(0x333333)

        }else{
            self.bagImageView.image = UIImage.init(named: "Park_selected")
            self.titleLabel.textColor = UIColorFromRGB(0x22cccc)
        }
    }
    
    @IBAction func action(sender: UIButton) {
        
        
    }
    
}
