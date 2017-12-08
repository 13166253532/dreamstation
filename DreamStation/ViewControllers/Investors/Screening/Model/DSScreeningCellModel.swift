//
//  DSScreeningCellModel.swift
//  DreamStation
//
//  Created by xjb on 16/8/2.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSScreeningCellModel: HTBaseCellModel {

    var blocks:selectBlock!
    var title:String!
    var optionsDataArry:NSMutableArray!

    var smallTitle:String!
    var bigTitle:String!
    /// 点击展开 收回
    var isAnBlock:passParameterBlock!
    /// Cell宽高
    var sizeMake:CGSize!
    
    var arrayBlock:passParameterBlock!
    
    var resetBool:Bool!
    
    var shaixuanArray = NSMutableArray()
    var isAn = Bool()
    var needUpdate=false
    var isSelected=false
    /**key 根据这个找到前次的选择*/
    var defaultKey:String?
    
}
