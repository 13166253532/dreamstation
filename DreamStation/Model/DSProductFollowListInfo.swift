//
//  DSProductFollowListInfo.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/15.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSProductFollowListInfo: NSObject {
    /// 项目名称
    var productName:String?
    /// 项目分类
    var categories:String?
    /// 投资方ID
    var investmentUserId:String?
    /// 投资方ID
    var investmentUserIds:String?
    /// 视频地址
    var productUrl:String?
    /// 项目ID
    var productId:String?
    /// 项目方 = 卖方ID
    var productUserId:String?
    /// 类型
    var orderModel:String?
    /// 用户组id
    var userGroupId:String?
    /// 订单id
    var orderId:String?
    /// itemId
    var itemId:String?
    ///
    var investorAccount:String?
    ///介绍图片
    var introduceImg:String?
    ///类型
    var investorType:String?
    ///
    var videoUrl:String?
    ///是平介绍
    var introduceDesc:String?
    ///公司名字
    var companyName:String?
    ///
    var userName:String?
    ///
    var avaterUrl:String?
    ///
    var phase:String?
    ///
    var domain:String?
    var investorId:String?
    
    var categor:NSMutableArray?
    
}
class DSProductFollowCategoriesInfo: NSObject {
    var catName:String?
    var descriptions:String?
}
