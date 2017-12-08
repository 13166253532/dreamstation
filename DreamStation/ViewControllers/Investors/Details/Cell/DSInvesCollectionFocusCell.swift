//
//  DSInvesCollectionFocusCell.swift
//  DreamStation
//
//  Created by xjb on 16/8/2.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSInvesCollectionFocusCell: HTBaseTableViewCell {
    let grayButnColor=UIColorFromRGB(0x999999)
    
    @IBOutlet weak var collectionButton: UIButton!

    @IBOutlet weak var focusButton: UIButton!

    @IBOutlet weak var collectionImageView: UIImageView!
    
    var isCollection:Bool!
    var isFocus:Bool!
    var collectionBlock:selectBlock!
    var focusBlock:selectBlock!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func configurateTheCell(xinfo:HTBaseCellModel){
        let info:DSInvesDetailsHeadCellModel = xinfo as! DSInvesDetailsHeadCellModel
        self.isFocus = info.isFocus
        self.isCollection = info.isCollection
        self.collectionBlock = info.isCollectionBlock
        self.focusBlock = info.isFocusBlock
        if !self.isFocus {
            self.focusButton.setTitle("求关注", forState: UIControlState.Normal)
            self.focusButton.backgroundColor = greenNavigationColor
        }else{
            self.focusButton.setTitle("已申请", forState: UIControlState.Normal)
            self.focusButton.backgroundColor = grayButnColor
            self.focusButton.adjustsImageWhenDisabled = false
        }
        if !self.isCollection {
            collectionImageView.image = UIImage.init(named: "Park_NoCollection")
        }else{
            collectionImageView.image = UIImage.init(named: "Park_YesCollection")
        }
    }
    @IBAction func collectionAction(sender: AnyObject) {
        self.collectionBlock()
    }
    
    @IBAction func focusAction(sender: AnyObject) {
        self.focusBlock()
    }
    
}
