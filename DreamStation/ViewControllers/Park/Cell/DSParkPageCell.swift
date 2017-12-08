//
//  DSParkPageCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/27.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSParkPageCell: HTBaseTableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    
    @IBOutlet weak var parkNameLabel: UILabel!
    
    @IBOutlet weak var parkSubLabel: UILabel!
    
    @IBOutlet weak var parkCityLabel: UILabel!
    

    @IBOutlet weak var parkVideoView: UIImageView!
 
    @IBOutlet weak var parkSubVideoLabel: UILabel!
    
    
    @IBOutlet weak var playVideoBtn: UIButton!
    @IBOutlet var playVideoMaxBtn: UIButton!
    
    var block:selectBlock!
    var goBlock:passParameterBlock!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.headImageView.layer.cornerRadius = 30
        self.headImageView.layer.masksToBounds = true
        self.headImageView.layer.borderColor=UIColorFromRGB(0xe3e5e9).CGColor
        self.headImageView.layer.borderWidth=1
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected==true {
            self.block()
        }
    }
    override func configurateTheCell(xinfo:HTBaseCellModel){
        let info:DSParkCellModel = xinfo as! DSParkCellModel

        if let url = info.headImage {
            self.headImageView.sd_setImageWithURL(NSURL.init(string:url), placeholderImage: UIImage.init(named: "Park_headImage"))
        }else{
            self.headImageView.image = UIImage.init(named: "Park_headImage")
        }
        
        if let url = info.videoImage {
            self.parkVideoView.sd_setImageWithURL(NSURL.init(string: url), placeholderImage: UIImage.init(named: "homePage_defaultImg"))
        }else{
            self.parkVideoView.image = UIImage.init(named: "homePage_defaultImg")
        }
        
        self.playVideoBtn.setBackgroundImage(UIImage.init(named: "homePage_videoPlayer"), forState: UIControlState.Normal)
        self.parkNameLabel.text = info.parkName
        self.parkSubLabel.text = info.parkSub
        self.parkCityLabel.text = info.cityName
        self.parkSubVideoLabel.text = info.videoSub
        self.block = info.block
        self.goBlock = info.goBlock
    }
    

    @IBAction func parkVideoButtonAction(sender: AnyObject) {
//        self.goBlock(sender)
    }
    
    @IBAction func parkVideoMaxButtonAction(sender: UIButton) {
        self.goBlock(sender)
    }
    

    
    
}
