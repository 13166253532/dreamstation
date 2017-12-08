//
//  DSParkListinfo.swift
//  DreamStation
//
//  Created by xjb on 16/8/29.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSParkListinfo: NSObject {
    /// 园区Logo
    var parkLogo:String?
    /// 描述
    var descriptio:String?
    /// 园区视频
    var videoUrl:String?
    /// 园区图片
    var parkImages:String?
    /// 是否提供服务
    var hasService:String?
    ///
    var introduction:String?
    ///
    var login:String?
    /// 视频简介
    var videoTitle:String?
    /// 视频图片
    var videoImage:String?
    /// 是否免费
    var hasFree:String?
    /// 园区地址
    var address:String?
    /// 园区案例
    var cases:String?
    /// 园区名字
    var parkName:String?
    /// 图片
    var images:String?
    /// 创建时间
    var createTime:String?
    
    /// 名字
    var name:String?
    var id:String?
    var detailAddressArray = NSMutableArray()
    
}
class DSParkListDetailAddressinfo: NSObject {
    var city:String?
    var detailAddress:String?
}


