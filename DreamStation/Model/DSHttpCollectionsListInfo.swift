//
//  DSHttpCollectionsListInfo.swift
//  DreamStation
//
//  Created by xjb on 16/8/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSHttpCollectionsListInfo: NSObject {
    ///收藏者id
    var userId:String?
    ///
    var id:String?
    ///收藏内容id
    var collections:String?

    ///收藏类型
    var collectionsType:String!
    ///投资机构Id
    var userGroupId:String?
    ///收藏人名字
    var username:String?
    
    ///项目名字
    var titleName:String?
    ///项目类别
    var typeTag = NSMutableArray()
    var favoriteNotes:String?
    ///视频Url
    var videoUrl:String?
    /// 阶段
    var level:String?
    var videoTitle:String?
    /// 头像
    var iconUrl:String?
    /// 视频图片
    var videoPicUrl:String?
    
    var mark:String?
    
    
    
    var status:String!
    var msg:String!
}
