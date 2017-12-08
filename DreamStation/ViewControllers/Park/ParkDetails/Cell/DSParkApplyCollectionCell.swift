//
//  DSParkApplyCollectionCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/28.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSParkApplyCollectionCell: HTBaseTableViewCell {
    let grayButnColor=UIColorFromRGB(0x999999)

    
    @IBOutlet weak var collectionImage: UIImageView!
 
    @IBOutlet weak var playButton: UIButton!

    @IBOutlet weak var collectionButton: UIButton!
    
    /// 是否申请
    var isPlay:Bool!
    /// 是否收藏
    var isCollection:Bool!
    /// 申请
    var playBlock:selectBlock!
    /// 收藏
    var collectionBlock:selectBlock!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func configurateTheCell(xinfo:HTBaseCellModel){
        let info:DSParkDetailsCellModel = xinfo as! DSParkDetailsCellModel
        self.isPlay = info.isPlay
        self.isCollection = info.isCollection
        self.playBlock = info.playBlock
        self.collectionBlock = info.collectionBlock
        if self.isPlay == false {
            self.playButton.setTitle("申请入驻", forState: UIControlState.Normal)
            self.playButton.backgroundColor = greenNavigationColor
        }else{
            self.playButton.setTitle("已申请", forState: UIControlState.Normal)
            self.playButton.backgroundColor = grayButnColor
            self.playButton.adjustsImageWhenDisabled = false
        }
        
        if self.isCollection == false{
            collectionImage.image = UIImage.init(named: "Park_NoCollection")
        }else{
            collectionImage.image = UIImage.init(named: "Park_YesCollection")
            self.playButton.adjustsImageWhenDisabled = false
        }
        
    }
    
    @IBAction func playAction(sender: AnyObject) {
        self.playBlock()
    }
    
    @IBAction func collectionAction(sender: AnyObject) {
        self.collectionBlock()
    }
    
    
    
}
