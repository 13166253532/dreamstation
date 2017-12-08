//
//  DSParkDetailsIntroduceCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/28.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSParkDetailsImageCell: HTBaseTableViewCell {

    @IBOutlet weak var parkImageButton: UIButton!

    @IBOutlet weak var parkImagesView: UIImageView!
   
  
    @IBOutlet weak var numImageBtn: UIButton!
    @IBOutlet var parkImgBottomLine: NSLayoutConstraint!
    var anBlock:passParameterBlock!
    
    var imageBlock:selectBlock!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.numImageBtn.userInteractionEnabled = false
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func configurateTheCell(xinfo:HTBaseCellModel){
        let info:DSParkDetailsCellModel = xinfo as! DSParkDetailsCellModel
        if let url = info.image {
            self.parkImagesView.sd_setImageWithURL(NSURL.init(string:url), placeholderImage: UIImage.init(named: "Park_centerImage"))
            parkImgBottomLine.constant = 10
        }else{
            parkImgBottomLine.constant = 10+parkImagesView.frame.height
        }
        self.imageBlock = info.imageBlock
        //self.numImageLabel.text = info.subTitle
        self.numImageBtn.setTitle(info.subTitle, forState: .Normal)
    }
    
    @IBAction func parkImageArray(sender: UIButton) {
        
        self.imageBlock()
    }
    
    
    
}
