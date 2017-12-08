//
//  DSGetProjectChangeInfo.swift
//  DreamStation
//
//  Created by xjb on 2016/12/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSGetProjectChangeInfo: NSObject {

    var status:String?
    var userId:String?
    var reason:String?
    var id:String?
    var role:String?
    var applyTime:String?
    var applyLogin:String?
    var message = DSGetProjectChangeInfoMessage()
    var resultTime:String?
    var type:String?
}
class DSGetProjectChangeInfoMessage: NSObject {
    var id:String?
    var company = DSGetProjectChangeInfoCompany()
    var detail = DSGetProjectChangeInfoDetail()
    var projectId:String?
    var type:String?
    var cats = NSMutableArray()
}
class DSGetProjectChangeInfoCompany: NSObject {
    var companyName:String?
    var licenceUrl:String?
    var address:String?
    var myName:String?
    var homePage:String?
    var weichatPublic:String?
    var businessCard:String?
    var individualMail:String?
    var weichat:String?
    var linkedin:String?
    var onShow:String?
}

class DSGetProjectChangeInfoDetail: NSObject {
    var amountMin:String?
    var amountMax:String?
    var login:String?
    var highLight:String?
    var market:String?
    var businessMode:String?
    var advantages:String?
    var businessPlan:String?
    var depthRecommend:String?
    var amount:String?
    var ratio:String?
    var brief:String?
    var videoUrl:String?
    var needMoreService:String?
    var needShow:String?
    var needIncubator:String?
}
class DSGetProjectChangeInfoCats: NSObject {
    /// id
    var catName:String?
    /// 用户id
    var descriptions:String?
}

