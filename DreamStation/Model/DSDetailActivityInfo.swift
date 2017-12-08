//
//  DSDetailActivityInfo.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/8.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSDetailActivityInfo: NSObject {

    var id:String?              //活动id
    var name:String?            //活动名称
    var address:String?         //活动地点
    var beginTime:String?       //开始时间
    var endTime:String?         //结束时间
    var description2:String?    //活动描述
    var smartImage:String?      //列表图
    var builder:String?         //创建者
    var userSign:String?        //该用户是否报名该活动
    var sortNumber:String?      //
    var status:String?          //活动状态
    var users:DSDetailActivityUserInfo?
    
}

class DSDetailActivityUserInfo: NSObject {
    
    var userId:String?
    var name:String?
    var phone:String?
    var company:String?
    var position:String?
    var landLine:String?
    
}
