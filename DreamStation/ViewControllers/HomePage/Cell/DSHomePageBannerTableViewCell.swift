//
//  DSHomePageBannerTableViewCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/22.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSHomePageBannerTableViewCell:HTBaseTableViewCell,SDCycleScrollViewDelegate{

    @IBOutlet weak var bannerView: SDCycleScrollView!
    
    var xinfo:DSHomePageImagePlayerModel!
    
    var hasInit: Bool=false
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        bannerView.delegate=self
    }
    
    override func configurateTheCell(info: HTBaseCellModel) {

        xinfo = info as! DSHomePageImagePlayerModel
        if xinfo.data.count>0{
            var  imagesURLStrings=NSArray()
            var  titles=NSArray()
            for index in 0..<xinfo.data.count{
                let aa:DSBannerInfo = xinfo.data[index] as! DSBannerInfo
                //let imageUrl:String = baseImageUrl.stringByAppendingFormat("/resource/view/"+aa.image!)
                imagesURLStrings=imagesURLStrings.arrayByAddingObject(aa.image!)
                titles=titles.arrayByAddingObject("     "+aa.text!)
            }
            bannerView.imageURLStringsGroup = imagesURLStrings as [AnyObject]
            bannerView.titlesGroup = titles as [AnyObject]
            bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
            bannerView.currentPageDotImage = UIImage.init(named: "banner_selected")
            bannerView.pageDotImage = UIImage.init(named: "banner_unSelected")
            bannerView.titleLabelHeight=36
            bannerView.titleLabelBackgroundColor = UIColor.clearColor()
            bannerView.autoScrollTimeInterval=5
            bannerView.titleLabelBGImage = UIImage.init(named: "homePage_bottomGray")
            bannerView.placeholderImage=UIImage(named: "homePage_defaultImg")
        }
    }
    
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        
        let aa:DSBannerInfo = xinfo.data[index] as! DSBannerInfo
        self.xinfo.block(aa.video!)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


class DSHomePageImagePlayerModel: HTBaseCellModel {
    var data:NSMutableArray=NSMutableArray()
    var block:passParameterBlock!
    
}

class DSHomePageImageDetail:NSObject{
    var imageAddress:String?
    
    var id:String?
    var title:String?
    var url:String?
    var type:String?
    var block:selectBlock!
    
}


