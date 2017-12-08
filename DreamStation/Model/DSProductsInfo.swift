//
//  DSProductsInfo.swift
//  DreamStation
//
//  Created by QPP on 16/8/5.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSProductsInfo: NSObject {
    ///项目iD
    var id:String?
    ///公司名字
    var companyName:String?
    ///licence URl
    var licenceUrl:String?
    ///公司地址
    var address:String?
    ///用户名字
    var myName:String?
    ///官网
    var homePage:String?
    ///微信公众号
    var wxPublicAccount:String?
    ///名片地址
    var cardUrl:String?
    ///职位
    var position:String?
    ///邮箱地址
    var email:String?
    ///微信号
    var wxAccount:String?
    ///linked 帐号
    var linkedIn:String?
    ///是否上过节目
    var hasShow:String?
    ///融资金额
    var amount:String?
    ///占股比例
    var ratio:String?
    ///一句话标题
    var brief:String?
    ///视频Url
    var videoUrl:String?
    ///是否需要更多服务
    var needMoreService:String?
    ///是否希望上节目
    var needShow:String?
    ///是否希望进孵化器
    var needIncubator:String?
    ///投资亮点
    var highLight:String?
    ///行业及市场
    var market:String?
    ///商业模式
    var businessMode:String?
    ///产品或服务优势
    var advantages:String?
    ///商业计划书
    var businessPlan:String?
    ///是否深度推荐
    var depthRecommend:String?
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
    /// 是否上过节目
    var catneedShow:String?
    var createTime:String?
    var interviewNum:String?
    var productStatus:String?
    
    var categoriesList:NSMutableArray=NSMutableArray()
    var categories:DSProductsCategoriesInfo?
   
    var catList = NSMutableArray()
    var jsonCat:String?
}

class DSProductsCategoriesInfo: NSObject {
    var name:String?
    var descriptio:String?
}


