//
//  DSSearchProductInfo.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/6.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSSearchProductInfo: NSObject {
    /// 项目id
    var id:String?
    /// 公司名称
    var companyName:String?
    /// 执照
    var licenceUrl:String?
    /// 地址
    var address:String?
    /// 用户姓名
    var myName:String?
    /// 官网
    var homePage:String?
    /// 微信公众号
    var wxPublicAccount:String?
    /// 名片
    var cardUrl:String?
    /// 职位
    var position:String?
    /// 个人邮箱
    var email:String?
    /// 微信
    var wxAccount:String?
    /// linked
    var linkedIn:String?
    /// 上过节目
    var hasShow:String?
    /// 融资金额
    var amount:String?
    /// 占股比
    var ratio:String?
    /// 一句话标题
    var brief:String?
    /// 视频连接
    var videoUrl:String?
    /// 是否需要更多服务
    var needMoreService:String?
    /// 希望上节目
    var needShow:String?
    /// 希望进孵化器
    var needIncubator:String?
    /// 投资亮点
    var highLight:String?
    /// 行业及市场
    var market:String?
    /// 商业模式
    var businessMode:String?
    /// 产品或服务优势
    var advantages:String?
    /// 商业计划书
    var businessPlan:String?
    /// 是否深度推荐
    var depthRecommend:String?
    /// cats
    var categories:NSMutableArray?
}

class DSSearchProductCatsInfo: NSObject {
    var name:String?
    var descriptions:String?
}
