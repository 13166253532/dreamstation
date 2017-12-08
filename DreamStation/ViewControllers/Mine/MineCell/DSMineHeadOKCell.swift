//
//  DSMineHeadOKCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/20.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSMineHeadOKCell: HTBaseTableViewCell {

    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var leadLayout: NSLayoutConstraint!

    @IBOutlet weak var rightImgConstraint: NSLayoutConstraint!
    var myInfo:DSMineHeadCellModel!
    
    @IBOutlet weak var bagImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bagImageView.backgroundColor = greenNavigationColor
        self.headImage.layer.cornerRadius=self.headImage.frame.size.width/2
        self.headImage.layer.masksToBounds=true
        if SCREEN_WHIDTH()>320{
            self.rightImgConstraint.constant=20
        }
    }
   
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected==true {
            self.myInfo.block()
        }
    }
    override func configurateTheCell(info: HTBaseCellModel) {
        myInfo = info as! DSMineHeadCellModel
        
        if let image=myInfo.headImage{
            headImage.sd_setImageWithURL(NSURL.init(string: image), placeholderImage: UIImage(named: "mine_default_headImg"))
        }else{
            headImage.image=UIImage(named: "mine_default_headImg")
        }
        
        if myInfo.hideHeadImage==true{
            self.leadLayout.constant = -70
        }else{
            self.leadLayout.constant = 15
        }
        nameLabel.text = myInfo.name
        typeLabel.text = myInfo.peopleType
        subLabel.text = myInfo.subTitle
        
    }
    
}
