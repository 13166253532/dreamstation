//
//  DSMessageCellModel.swift
//  DreamStation
//
//  Created by xjb on 16/7/25.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit
enum JPUSHTYPE : String{
    case ACTIVITY//活动
    case ATTENTION//请求关注
    case AUTHENTICATION_ACCEPTED//认证信息审核已通过
    case AUTHENTICATION_REFUSED//认证信息审核未通过
    case UPDATE_PERSON_ACCEPTED//更新个人信息审核已通过
    case UPDATE_PERSON_REFUSED//更新个人信息审核未通过
    case PROJECT_ACCEPTED//发布项目信息审核已通过
    case PROJECT_REFUSED//发布项目信息审核未通过
    case UPDATE_PROJECT_ACCEPTED//更新项目信息审核已通过
    case UPDATE_PROJECT_REFUSED//更新项目信息审核未通过
    case PRODUCTS_WECHAT_GROUP//已成功建立微信群"), //项目方
    case INVESTORS_WECHAT_GROUP//"已成功建立微信群"), //投资方
    case TURN_AROUND//您有新的约谈
    case PARK_ACCEPTED//园区信息审核已通过
    case PARK_REFUSED//园区信息审核未通过
    case UPDATE_PARK_ACCEPTED//更新园区信息审核已通过
    case UPDATE_PARK_REFUSED//更新园区信息审核未通过
    case OTHER//其它
}


class DSMessageCellModel: HTBaseCellModel {

    var title:String!
    var subTitle:String!
    var detailTitle:String!
    var isRead:String!//0表示未读，1已读
    var messageId :String!// cywu  下个界面接口使用
    var block:selectBlock!
    var blockParam:passParameterBlock!
    var mId:String!
    var type:String!
    var reason:String!
}
