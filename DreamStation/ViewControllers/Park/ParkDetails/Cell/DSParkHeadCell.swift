//
//  DSParkHeadCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/27.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSParkHeadCell: HTBaseTableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var subTitleLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.headImageView.layer.cornerRadius = 35
        self.headImageView.layer.masksToBounds = true
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func configurateTheCell(xinfo:HTBaseCellModel){
        let info:DSParkDetailsCellModel = xinfo as! DSParkDetailsCellModel
        if let url = info.image {
            self.headImageView.sd_setImageWithURL(NSURL.init(string:url), placeholderImage: UIImage.init(named: "Park_headImage"))
        }else{
            self.headImageView.image = UIImage.init(named: "Park_headImage")
        }
        self.titleLabel.text = info.title
        self.subTitleLabel.text = info.subTitle
        
    }

    
}
