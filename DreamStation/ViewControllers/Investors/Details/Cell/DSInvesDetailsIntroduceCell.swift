//
//  DSInvesDetailsIntroduceCell.swift
//  DreamStation
//
//  Created by xjb on 16/8/1.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSInvesDetailsIntroduceCell: HTBaseTableViewCell {

    @IBOutlet weak var guanButton: UIButton!

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var labelLayout: NSLayoutConstraint!
    /// 是否展开
    var isAn = false
    
    var guanBlock:passParameterBlock!
    
    var heigh:CGFloat!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelLayout.constant = 30
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    override func configurateTheCell(xinfo:HTBaseCellModel){
        let info:DSInvesDetailsHeadCellModel = xinfo as! DSInvesDetailsHeadCellModel
//        if info.isAn == false {
//            self.isAn = info.isAn
//        }
        if !self.isAn {
            self.guanButton.setTitle("更多", forState: UIControlState.Normal)
            if info.title != nil {
                 self.heigh = CGFloat((info.title!.characters.count/21-3)*16)
            }else{
                self.heigh = 0
            }
        }else{
            self.guanButton.setTitle("收回", forState: UIControlState.Normal)
            self.heigh = 0
        }
        self.guanBlock = info.guanBlock
        if info.title != nil {
            let att = NSMutableAttributedString.init(string: info.title!)
            let par = NSMutableParagraphStyle.init()
            par.lineSpacing = 9
            att.addAttribute(NSParagraphStyleAttributeName, value: par, range: NSMakeRange(0,(info.title?.characters.count)!))
            self.titleLabel.attributedText = att
            if info.title!.characters.count/21 <= 4 {
                labelLayout.constant = 0
                self.guanButton.alpha = 0
                self.guanButton.adjustsImageWhenDisabled = false
            }
        }
    }
    @IBAction func action(sender: UIButton) {
        self.isAn = !self.isAn
        self.guanBlock(self.heigh)
    }
  

    
}
