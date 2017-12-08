//
//  DSInvestorsFollowListInfo.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSInvestorsFollowListInfo: NSObject {
    /// 项目名称
    var productName:String?
    /// 项目分类
    var categories = NSMutableArray()
    /// 投资方ID
    var investmentUserId:String?
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
    /// 视频url
    var videoUrl:String?
    
    var videoUrl4Provider:String?
    
    
    var catego = NSMutableArray()
}
class DSInvestorsCategoriesInfo: NSObject {
    var catName:String?
    var descriptio:String?
}
