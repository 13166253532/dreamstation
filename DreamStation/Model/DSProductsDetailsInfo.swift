//
//  DSProductsDetailsInfo.swift
//  DreamStation
//
//  Created by xjb on 16/8/15.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSProductsDetailsInfo: NSObject {
    ///LinkedIn帐号
    var linkedIn:String?
    ///是否深度推荐
    var depthRecommend:String?
    ///职位
    var position:String?
    ///微信号
    var wxAccount:String?
    ///融资金额
    var amount:String?
    ///是否需要更多服务
    var needMoreService:String?
    ///行业及市场
    var market:String?
    ///
    var hasShow:String?
    ///一句话标题
    var brief:String?
    ///官网
    var homePage:String?
    ///视频Url
    var videoUrl:String?
    ///投资亮点
    var highLight:String?
    ///项目id
    var id:String?
    ///微信公众号
    var wxPublicAccount:String?
    ///名片地址
    var cardUrl:String?
    ///个人邮箱
    var email:String?
    ///执照
    var licenceUrl:String?
    ///希望进孵化器
    var needIncubator:String?
    
    var companyName:String?
    ///商业模式
    var businessMode:String?
    ///产品或服务优势
    var advantages:String?
    ///占股比
    var ratio:String?
    ///商业计划书
    var businessPlan:String?
    ///是否有商业计划书
    var isBusinessPlan:String?
    ///用户名字
    var userName:String?
    var myName:String?
    ///是否希望上节目
    var needShow:String?
    ///地址
    var address:String?
    ///个人id
    var userId:String?
    ///所在地区
    var Inthearea:String?
    ///融资阶段
    var amountPhase:String?
    ///投资币种
    var currency:String?
    ///投资偏好
    var preferences:String?
    /// 所属行业
    var industry:String?
    ///类别
    var cat:String?
    ///类别
    var categories = NSMutableArray()
    ///类别
    var categoriesArray = NSMutableArray()
    var interviewNum:String?

    var industryList = NSMutableArray()
    var productStatus:String?
    var extractionCode:String?
    var downloadLink:String?
}

class DSProductsDetailsCategoriesInfo: NSObject {
    var catName:String?
    var descriptions:String?
}


class DSProductsDetailsCatsInfo: NSObject {
    var name:String?
    var descriptions:String?
}

