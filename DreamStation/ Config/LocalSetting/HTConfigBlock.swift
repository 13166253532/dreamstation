//
//  HTConfigBlock.swift
//  HiTeacher
//
//  Created by QPP on 16/4/13.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

typealias selectBlock = ()->()

typealias passParameterBlock = (AnyObject)->()

typealias returnParameterBlock = ()->(AnyObject)

typealias passTwoParameterBlock = (AnyObject,AnyObject)->()

typealias httpBlock = (RequestResult!,AnyObject!)->()


typealias signUpBlock = ()->(String)

typealias activityBlock = ()->(NSMutableArray)


//textView
typealias passTextViewBlock = (AnyObject?)->()
