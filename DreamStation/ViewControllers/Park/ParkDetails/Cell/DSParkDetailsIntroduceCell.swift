//
//  DSParkDetailsIntroduceCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/28.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSParkDetailsIntroduceCell: HTBaseTableViewCell {

    @IBOutlet weak var parkLabel: UILabel!
    
    @IBOutlet weak var moreButton: UIButton!
    /// 是否展开
    var isAn = false
    /// 展开 收回
    var anBlock:passParameterBlock!
    
    var imageBlock:selectBlock!
    
    var cellHeigt = CGFloat()
    var info = DSParkDetailsCellModel()
    @IBOutlet var titleBottomLine: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleBottomLine.constant = 40
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func configurateTheCell(xinfo:HTBaseCellModel){
       info = xinfo as! DSParkDetailsCellModel
//        self.parkLabel.numberOfLines = info.title!.characters.count/24+1
        if !self.isAn {
            self.moreButton.setTitle("更多", forState: UIControlState.Normal)
            if info.title != nil {
                self.cellHeigt = CGFloat((info.title!.characters.count/24-2)*27)
            }else{
                self.cellHeigt = 0
            }
            
        }else{
            self.moreButton.setTitle("收回", forState: UIControlState.Normal)
            self.cellHeigt = 0
        }
        self.anBlock = info.anBlock
        let att = NSMutableAttributedString.init(string: info.title!)
        let par = NSMutableParagraphStyle.init()
        par.lineSpacing = 9
        att.addAttribute(NSParagraphStyleAttributeName, value: par, range: NSMakeRange(0,(info.title?.characters.count)!))
        self.parkLabel.attributedText = att
        self.parkLabel.lineBreakMode = .ByTruncatingTail
        
        if info.title!.characters.count/21 <= 4 {
            titleBottomLine.constant = 0
            self.moreButton.alpha = 0
            self.moreButton.adjustsImageWhenDisabled = false
        }
    }
    @IBAction func action(sender: AnyObject) {
        self.anBlock(self.cellHeigt)
        self.isAn = !self.isAn
    }
}
