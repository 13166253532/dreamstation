//
//  DSAccountsInstituListInfo.swift
//  DreamStation
//
//  Created by xjb on 16/8/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSAccountsInstituListInfo: NSObject {

    /// 最低投资额度
    var investMin:String?
    /// 视频Url
    var video_url:String?
    /// 执照
    var licence:String?
    ///公司名字
    var company:String?
    ///管理员登陆
    var adminLogin:String?
    ///邮箱
    var mail:String?
    /// 视频介绍
    var video_title:String?
    /// 主页
    var homePage:String?
    /// 公司Id
    var id:String?
    ///
    var card_no:String?
    /// 电话
    var phone:String?
    /// 身份
    var avatar:String?
    /// 介绍
    var introduction:String?
    /// 标志
    var logo:String?
    /// 视频图片
    var video_pic:String?
    /// 过往案例
    var cases:String?
    /// 公司地址
    var address:String?
    /// 最大投资额度
    var investMax:String?
    
    var followNum:String?
    var createTime:String?
    
    
    /// 合伙人
    var partners:NSMutableArray?
    /// 细则
    var cats:NSMutableArray?
    
}
class DSAccountsInstituListPartnersInfo: NSObject {
    var brief:String?
    var name:String?
    var position:String?
    var avatar:String?
}
class DSAccountsInstituListCatsInfo: NSObject {
    var catName:String?
    var descriptions:String?
}