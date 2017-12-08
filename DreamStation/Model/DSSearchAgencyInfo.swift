//
//  DSSearchAgencyInfo.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/7.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSSearchAgencyInfo: NSObject {
    /// id
    var id:String?
    /// 头像
    var avatar:String?
    /// 身份证号码
    var card_no:String?
    /// 公司名
    var company:String?
    /// logo
    var logo:String?
    /// 执照
    var licence:String?
    /// 电话
    var phone:String?
    /// 邮箱
    var mail:String?
    /// 地址
    var address:String?
    /// 网址
    var homePage:String?
    /// 简介
    var introduction:String?
    /// cases
    var cases:String?
    /// 最大额度
    var investMax:String?
    /// 最小额度
    var investMin:String?
    /// 视频url
    var video_url:String?
    /// 视频标题
    var video_title:String?
    /// 视频图片
    var video_pic:String?
    /// cats
    var cats:NSMutableArray?
    /// partners
    var partners:NSMutableArray?
    /// createTime
    var createTime:String?
    /// adminLogin
    var adminLogin:String?
    /// followNum
    var followNum:String?
    
    
}

class DSSearchAgencyCats: NSObject {
    var catName:String?
    var descriptions:String?
}

class DSSearchAgencyPartners: NSObject {
    var name:String?
    var avatar:String?
    var position:String?
    var brief:String?
}
