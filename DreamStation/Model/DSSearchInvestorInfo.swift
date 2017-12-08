//
//  DSSearchInvestorInfo.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSSearchInvestorInfo: NSObject {
    /// id
    var id:String?
    /// 姓名
    var name:String?
    /// 头像
    var avatar:String?
    /// 简介
    var introduction:String?
    /// case案例
    var cases:String?
    /// 最小额度
    var investMin:String?
    /// 最大额度
    var investMax:String?
    /// cats
    var cats:NSMutableArray?
    /// pv
    var pv:String?
    /// popular
    var popular:String?
    /// 视频url
    var videoUrl:String?
    /// 视频title
    var videoTitle:String?
    /// 视频截图
    var videoImage:String?
    /// 手机账户
    var phone:String?
    /// 微信
    var wechat:String?
    /// linkedin
    var linkedIn:String?
    /// 创建时间
    var createTime:String?
    /// 身份证号
    var cardNo:String?
    /// 身份证正面
    var cardNoFront:String?
    /// 身份证背面
    var cardNoBack:String?
    /// 个人资产
    var personalAssetsCertificate:String?
    /// 账户
    var account:String?
    /// 邮箱
    var mail:String?
    /// 官网
    var homePage:String?
    /// followNum
    var followNum:String?
    /// 地址
    var address:String?
    
}

class DSSearchInvestorCats: NSObject {
    var catName:String?
    var descriptions:String?
}
