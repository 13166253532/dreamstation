//
//  DSInvestorsCellModel.swift
//  DreamStation
//
//  Created by xjb on 16/7/29.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSInvestorsCellModel: HTBaseCellModel {
    /// 投资者Id
    var InvesId:String?
    /// 公司名字
    var company:String?
    /// 公司名字
    var logo:String?
    /// 投资者头像Url
    var InvesHeadImageUrl:String?
    /// 投资者名字
    var InvesName:String?
    /// 投资者类型
    var InvesType:String?
    /// 投资者行业
    var Invesindustry:String?
    /// 投资者投资阶段
    var InvesPhase:String?
    /// 投资者视频图像Url
    var videoImg:String?
    /// 投资者视频Url
    var videoUrl:String?
    /// 视频简介
    var videoText:String?
    ///浏览量
    var InvesBrowse:String?
    ///热度
    var InvesHeat:String?
    /// 投资者简介
    var introduction:String?
    /// 关注领域
    var InvesFocusareas:String?
    /// 投资地点
    var InvesLocation:String?
    /// 投资币种
    var InvesCurrency:String?
    /// 最小投资
    var investMin:String?
    /// 最大投资
    var investMax:String?
    /// 过往案例
    var cases:String?
    /// 投资者账号
    var Invesaccount:String?
    /// 投资偏好
    var preferences:String?
    /// 微信号
    var weichat:String?
    /// 邮箱
    var mail:String?
    /// 合伙人数组
    var partners = NSMutableArray()
    /// 地址
    var address:String?
    ///
    /// 订单id
    var orderId:String?
    /// itemId
    var itemId:String?
    var InvesLines:String?
    var block:selectBlock!
    var videoBlock:selectBlock!
    var isVideo:Bool!
    var isAplay = false
    
    
}
