//
//  DSMyAttentionViewController+DeleteCmd.swift
//  DreamStation
//
//  Created by K.E. on 16/9/23.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

extension DSMyAttentionViewController {
    //MARK:--------删除关注----------
    func httpDeleteFollowRequire(id:String?,itemId:String?,anyobject:AnyObject){
        let cmd:HttpCommand=DSHttpDeleteFollowCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self?.httpDeleteFollowResponse(result,anyobject: anyobject)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_DeleteFollow_id] = id
        dic[kHttpParamKey_DeleteFollow_itemId] = itemId
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpDeleteFollowResponse(result:RequestResult,anyobject:AnyObject){
        let r:DSHttpDeleteFollowResult = result as! DSHttpDeleteFollowResult
        if r.isOk(){
            let indexPath = anyobject as! NSIndexPath
            deleteSuccessBlock(indexPath)
        }
    }

}
