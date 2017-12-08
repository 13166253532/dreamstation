//
//  DSAccountInfo.swift
//  electricVCP
//
//  Created by QPP on 16/3/3.
//  Copyright © 2016年 qbshen. All rights reserved.
//

import UIKit
private let HTAccountInfo_nickname:String="HTAccountInfo_nickname"
private let HTAccountInfo_acceptOrders:String="HTAccountInfo_acceptOrders"
private let HTAccountInfo_acceptGroupClass:String="HTAccountInfo_acceptGroupClass"
private let HTAccountInfo_clientHeader:String="HTAccountInfo_clientHeader"
private let HTAccountInfo_accessToken:String="HTAccountInfo_accessToken"
private let HTAccountInfo_phoneNum:String="HTAccountInfo_phoneNum"
private let HTAccountInfo_password:String="HTAccountInfo_password"
private let HTAccountInfo_accessType:String="HTAccountInfo_accessType"
private let HTAccountInfo_defaultAddress:String="HTAccountInfo_defaultAddress"
private let HTAccountInfo_avatar:String="HTAccountInfo_avatar"
private let HTAccountInfo_role:String="HTAccountInfo_role"
private let HTAccountInfo_id:String="HTAccountInfo_id"
private let HTAccountInfo_authorized:String="HTAccountInfo_authorized"
private let HTAccountInfo_name:String="HTAccountInfo_name"
private let HTAccountInfo_job:String="HTAccountInfo_job"

private let HTAccountInfo_productsSX:String="HTAccountInfo_productsSX"
private let HTAccountInfo_institutionSX:String="HTAccountInfo_institutionSX"

private let HTAccountInfo_productsSX1:String="HTAccountInfo_productsSX1"
private let HTAccountInfo_institutionSX1:String="HTAccountInfo_institutionSX1"

private let HTAccountInfo_parkName:String="HTAccountInfo_parkName"

private let HTAccountInfo_productsId:String="HTAccountInfo_productsId"
private let HTAccountInfo_companyName:String="HTAccountInfo_companyName"
private let HTAccountInfo_position:String = "HTAccountInfo_position"
private let HTAccountInfo_videoUrl:String="HTAccountInfo_videoUrl"
private let HTAccountInfo_address:String="HTAccountInfo_address"
private let HTAccountInfo_categories:String="HTAccountInfo_categories"
private let HTAccountInfo_productsName:String="HTAccountInfo_productsName"
private let HTAccountInfo_productsmyName:String="HTAccountInfo_productsmyName"
private let HTAccountInfo_Authentication:String="HTAccountInfo_Authentication"
private let HTAccountInfo_AuthenticationStatus:String="HTAccountInfo_AuthenticationStatus"

private let HTAccountInfo_institutionId:String="HTAccountInfo_institutionId"
private let HTAccountInfo_institutionCompany:String="HTAccountInfo_institutionCompany"
private let HTAccountInfo_messageIsRead:String = "HTAccountInfo_messageIsRead"
private let HTAccountInfo_PleaseFocusIsRead:String = "HTAccountInfo_PleaseFocusIsRead"
private let HTAccountInfo_productStatus:String = "HTAccountInfo_productStatus"
private let HTAccountInfo_isOpenMessageVC:String = "HTAccountInfo_HTAccountInfo_isOpenMessageVC"
private let HTAccountInfo_perPhoneNum:String = "HTAccountInfo_HTAccountInfo_perPhoneNum"


class DSAccountInfo: NSObject {
    var isOpenMessageVC:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_isOpenMessageVC)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_isOpenMessageVC) as? String
        }
    }
    
    var PleaseFocusIsRead:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_PleaseFocusIsRead)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_PleaseFocusIsRead) as? String
        }
    }
    
    var productsSX:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_productsSX)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_productsSX) as? String
        }
    }
    var institutionSX:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_institutionSX)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_institutionSX) as? String
        }
    }
    var productsSX1:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_productsSX1)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_productsSX1) as? String
        }
    }
    var institutionSX1:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_institutionSX1)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_institutionSX1) as? String
        }
    }
    
    
    
    var institutionId:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_institutionId)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_institutionId) as? String
        }
    }

    var job:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_job)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_job) as? String
        }
    }
    var institutionCompany:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_institutionCompany)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_institutionCompany) as? String
        }
    }

    
    var personId:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_id)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_id) as? String
        }
    }
    
    var AuthenticationStatus:String?{
        set {
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_AuthenticationStatus)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_AuthenticationStatus) as? String
        }
    }
    
    var isAuthentication:Bool?{
        set{
            let userData:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_Authentication)
        }
        get{
            let userData:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            if userData.objectForKey(HTAccountInfo_Authentication) as? Bool==nil{
                return false
            }
            return userData.objectForKey(HTAccountInfo_Authentication) as? Bool
        }
    }
    
    var isRead:String?{
        set{
            let userData:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_messageIsRead)
        }
        get{
            let userData:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_messageIsRead) as? String
        }
    }
    
    //MARK:园区名字
    var parkName:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            if newValue==nil{
                userData.setObject("", forKey: HTAccountInfo_parkName)
            }else{
                userData.setObject(newValue, forKey: HTAccountInfo_parkName)
            }
            
            
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_parkName) as? String
        }
    }
    
    //MARK:项目方项目id
    var productsId:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_productsId)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_productsId) as? String
        }
    }
    //MARK:项目方项目状态
    var productStatus:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_productStatus)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_productStatus) as? String
        }
    }
    
    //MARK:项目名字
    var productsName:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_productsName)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_productsName) as? String
        }
    }
    //MARK:项目个人名字
    var productsmyName:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_productsmyName)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_productsmyName) as? String
        }
    }
    //MARK:公司名
    var companyName:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_companyName)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_companyName) as? String
        }
    }

    //MARK:视频地址
    var videoUrl:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_videoUrl)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_videoUrl) as? String
        }
    }
    //MARK:地址
    var address:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_address)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_address) as? String
        }
    }
    //MARK:类别
    var categories:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_categories)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_categories) as? String
        }
    }
    
    var position:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_position)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_position) as? String
        }
    }

    
    
    var authorized:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_authorized)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_authorized) as? String
        }
    }
    
    var role:String!{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_role)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_role) as? String
        }
    }
    var name:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_name)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_name) as? String
        }
    }

    
    var phoneNum:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_phoneNum)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_phoneNum) as? String
        }
    }
    var perPhoneNum:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_perPhoneNum)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_perPhoneNum) as? String
        }
    }
    
    var password:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_password)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_password) as? String
        }
    }
    

    var access_token:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_accessToken)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_accessToken) as? String
        }
    }
    
    var access_type:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_accessType)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_accessType) as? String
        }
    }
    
    
    
    var nickName:String? {
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_nickname)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_nickname) as? String
        }
    }
    var defaultAddress:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_defaultAddress)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_defaultAddress) as? String
        }
    }
    var avatar:String?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_avatar)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            return userData.objectForKey(HTAccountInfo_avatar) as? String
        }
    }
    var acceptOrders:Bool?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_acceptOrders)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            if userData.objectForKey(HTAccountInfo_acceptOrders)==nil{
                return true
            }
            return userData.objectForKey(HTAccountInfo_acceptOrders) as? Bool
        }
    }
    var acceptGroupClass:Bool?{
        set{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            userData.setObject(newValue, forKey: HTAccountInfo_acceptGroupClass)
        }
        get{
            let userData:NSUserDefaults=NSUserDefaults.standardUserDefaults()
            if userData.objectForKey(HTAccountInfo_acceptGroupClass)==nil{
                return true
            }
            return userData.objectForKey(HTAccountInfo_acceptGroupClass) as? Bool
        }
    }
    class func sharedInstance()->DSAccountInfo {
       struct SharedStatic {
            static var token: dispatch_once_t = 0
            static var instance: DSAccountInfo? = nil
        }
        dispatch_once(&SharedStatic.token) {
            SharedStatic.instance = DSAccountInfo()
        }
        return SharedStatic.instance!
    }
    func clearAccount(){
        DSAccountInfo.sharedInstance().access_token = nil
        DSAccountInfo.sharedInstance().phoneNum = nil
        DSAccountInfo.sharedInstance().role = nil
        DSAccountInfo.sharedInstance().personId = nil
        DSAccountInfo.sharedInstance().authorized = nil
        DSAccountInfo.sharedInstance().name = nil
        DSAccountInfo.sharedInstance().avatar = nil
        DSAccountInfo.sharedInstance().AuthenticationStatus = nil
        DSAccountInfo.sharedInstance().parkName = nil
        DSAccountInfo.sharedInstance().job = nil
        DSAccountInfo.sharedInstance().productsId = nil
        DSAccountInfo.sharedInstance().productsName = nil
        DSAccountInfo.sharedInstance().companyName = nil
        DSAccountInfo.sharedInstance().videoUrl = nil
        DSAccountInfo.sharedInstance().address = nil
        DSAccountInfo.sharedInstance().categories = nil
        DSAccountInfo.sharedInstance().isAuthentication = nil
        DSAccountInfo.sharedInstance().productsmyName = nil
        DSAccountInfo.sharedInstance().productsSX = nil
        DSAccountInfo.sharedInstance().institutionSX = nil
        DSAccountInfo.sharedInstance().productsSX1 = nil
        DSAccountInfo.sharedInstance().institutionSX1 = nil
        DSAccountInfo.sharedInstance().isRead = nil
        DSAccountInfo.sharedInstance().productStatus = nil
        DSAccountInfo.sharedInstance().PleaseFocusIsRead = nil
        DSAccountInfo.sharedInstance().perPhoneNum = nil
        UIApplication.sharedApplication().unregisterForRemoteNotifications()
        //设置别名  cywu
        JPUSHService.setTags(nil, alias:"", fetchCompletionHandle: { (code, tags, alias) in
            NSLog("code : %d", code)
        })
    }
    func isLogin()->Bool{
        return true
    }
    func hasNewMessage()->Bool{
        return true
    }
}
