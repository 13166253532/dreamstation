//
//  HTConfigMacro.swift
//  HiTeacher
//
//  Created by QPP on 16/4/12.
//  Copyright © 2016年 QPP. All rights reserved.
//  定义一些宏定义

import UIKit

let TITLESTRINGTABLEID:String="DSTitleStrings"
let AccessTokenExpired:String="AccessTokenExpired"
let WARNING_TABLE_ID:String = "DSWarningStrings"

// RGBA的颜色设置
func kRGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func UIColorFromRGB(rgbValue:UInt)->UIColor {
    return UIColor(red: ((CGFloat)((rgbValue&0xFF0000)>>16))/255.0, green: ((CGFloat)((rgbValue&0xFF00)>>8))/255.0, blue: ((CGFloat)(rgbValue&0xFF))/255.0, alpha: 1.0)
}

func SCREEN_WHIDTH()->CGFloat{
    return UIScreen.mainScreen().bounds.size.width
}

func SCREEN_HEIGHT()->CGFloat{
    return UIScreen.mainScreen().bounds.size.height
}


func SMToast(msg:String?){
    SMToastView.showMessage((UIApplication.sharedApplication().delegate?.window)!, withMessage: msg)
}

