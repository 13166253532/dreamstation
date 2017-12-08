//
//  DSInvesDetailsPartnerCell.swift
//  DreamStation
//
//  Created by xjb on 16/8/2.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSInvesDetailsPartnerCell: HTBaseTableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
  
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var positionLabel: UILabel!
    
    @IBOutlet weak var introduceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.headImageView.layer.masksToBounds = true
        self.headImageView.layer.cornerRadius = 26
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    override func configurateTheCell(xinfo:HTBaseCellModel){
        let info:DSInvesDetailsHeadCellModel = xinfo as! DSInvesDetailsHeadCellModel
        
        if let url = info.InvesHeadImageUrl {
            self.headImageView.sd_setImageWithURL(NSURL.init(string:url ), placeholderImage: UIImage.init(named: "Inves_peoheadImage"))
        }else{
            self.headImageView.image = UIImage.init(named: "Inves_peoheadImage")
        }
        self.nameLabel.text = info.InvesName
        self.positionLabel.text = info.title
        
        let att = NSMutableAttributedString.init(string: info.subTitle!)
        let par = NSMutableParagraphStyle.init()
        par.lineSpacing = 9
        att.addAttribute(NSParagraphStyleAttributeName, value: par, range: NSMakeRange(0,(info.subTitle?.characters.count)!))
        self.introduceLabel.attributedText = att
    }
}
