//
//  DSParkDetailsCellModel.swift
//  DreamStation
//
//  Created by xjb on 16/7/27.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSParkDetailsCellModel: HTBaseCellModel {
/// 主要描述
    var title:String?
    /// 注释
    var subTitle:String?
    /// 图片
    var image:String?
    /// 是否申请
    var isPlay:Bool!
    /// 是否收藏
    var isCollection:Bool!
    /// 申请
    var playBlock:selectBlock!
    /// 收藏
    var collectionBlock:selectBlock!
    /// 是否展开
    var isAn:Bool!
    /// 展开 收回
    var anBlock:passParameterBlock!
    var cellHeight:CGFloat?
    
    var imageBlock:selectBlock!
    
}
