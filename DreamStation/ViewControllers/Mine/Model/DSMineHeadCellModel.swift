//
//  DSMineHeadCellModel.swift
//  DreamStation
//
//  Created by xjb on 16/7/20.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSMineHeadCellModel: HTBaseCellModel {
    
    /// 头像
    var headImage:String?
    /// 投资者名字
    var name:String?
    /// 投资者类型
    var peopleType:String?
    /// 投资者注释
    var subTitle:String?
    /// 响应方法
    var block:selectBlock!
    
    var hideHeadImage=false
}
