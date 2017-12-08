//
//  DSMessageBriefTableViewCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/25.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSMessageTableViewCell: HTBaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
 
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var detailLab: UILabel!
    
    @IBOutlet weak var redImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func configurateTheCell(zinfo:HTBaseCellModel){
        let info:DSMessageCellModel=zinfo as! DSMessageCellModel
        self.titleLabel.text=info.title
        self.subLabel.text=info.subTitle
        self.detailLab.text = info.detailTitle
        if  info.isRead == "1"{
            self.redImage.hidden = true
        }else{
            self.redImage.hidden = false
        }
        
    }

}
