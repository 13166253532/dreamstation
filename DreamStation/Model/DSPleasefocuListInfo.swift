//
//  DSPleasefocuListInfo.swift
//  DreamStation
//
//  Created by xjb on 16/8/25.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSPleasefocuListInfo: NSObject {
    ///订单
    var orderId:String?
    ///地址
    var storeAddress:String?
    ///微信号
    var wechat:String?
    ///itemId
    var itemId:String?
    ///介绍图片
    var introduceImg:String?
    ///公司
    var storeCompany:String?
    ///项目userId
    var productUserId:String?
    ///
    var investorAccount:String?
    ///投资者类型
    var investorType:String?
    ///
    var storeName:String?
    ///时间
    var time:String?
    ///视频url
    var videoUrl:String?
    ///项目Id
    var productId:String?
    ///投资用户id
    var investmentUserIds:String?
    ///介绍标题描述
    var introduceDesc:String?
    ///阶段
    var phase:String?
    ///头像Url
    var avaterUrl:String?
    ///所属行业
    var domain:String?
    ///
    var storeAccount:String?
    ///项目视频地址
    var productUrl:String?
    ///投资机构id
    var userGroupId:String?
    ///公司名
    var companyName:String?
    ///项目名
    var productName:String?
    ///用户名
    var userName:String?
    ///
    var categories:String?
    
    var catArray = NSMutableArray()
    
    var videoUrl4Provider:String?
    
    ///订单id
    var orderModel:String?
}
class DSPleasefocuListCatInfo: NSObject{
    var name:String?
    var descriptions:String?
}

