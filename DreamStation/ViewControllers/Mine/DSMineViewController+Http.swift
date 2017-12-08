//
//  DSMineViewController+Http.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/2.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

extension DSMineViewController{
    
    //MARK:---------------加载园区详细------------------
    //MARK:---------------加载项目详细------------------
    func getHttpProjectdetailsRequire(){
        let cmd:HttpCommand = DSHttpProductsDetailsCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {(result:RequestResult!,useInfo:AnyObject!)->() in
            self.httpProjectdetailsResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        
        dic[kHttpParamKey_productsDetails_id] = DSAccountInfo.sharedInstance().productsId
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block:block,withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }

    func httpProjectdetailsResponse(result:RequestResult){
        let r:DSHttpProductsDetailsResult = result as! DSHttpProductsDetailsResult
        if result.isOk() {
            self.getHttptData(r.getAllContent())
        }
        self.getFollowNum()
    }
    func getHttptData(data:NSMutableArray){
        let info = data[0] as? DSProductsDetailsInfo
        DSAccountInfo.sharedInstance().companyName = info?.companyName
        DSAccountInfo.sharedInstance().position = info?.position
        DSAccountInfo.sharedInstance().job = info?.position
        DSAccountInfo.sharedInstance().name = info?.myName
        self.myTableView .reloadData()
    }
    
    //MARK:--------我的约谈数量--------
    func getFollowNum(){
        let cmd:HttpCommand=DSHttpFollowNumCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self?.httpFollowNumResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_Follow_Project_id] = DSAccountInfo.sharedInstance().productsId
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
    }
    func httpFollowNumResponse(result:RequestResult){
        let r:DSHttpFollowNumResule = result as! DSHttpFollowNumResule
        if r.isOk() {
            self.followNum = r.getTheCount()
            //print(self.followNum)
            dateMeInfo.numOfPeople=self.followNum
            self.myTableView .reloadData()
        }
    }
    
    
    //MARK:--------获取投资页面信息接口
    func httpGetPersonAccountRequire(){
        let cmd:DSHttpGetPersonAccountCmd = DSHttpGetPersonAccountCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpGetPersonAccountCmd
        let block:httpBlock = {(result:RequestResult!,useInfo:AnyObject!)->() in
            self.httpGetPersonAccountResponse(result)
        }
        
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_GetPersonAccount_person_id] = DSAccountInfo.sharedInstance().personId
        cmd.requestInfo = dic as [NSObject:AnyObject]
        
        let complegeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate = complegeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpGetPersonAccountResponse(result:RequestResult){
        let r:DSHttpGetPersonAccountResult = result as! DSHttpGetPersonAccountResult
        if r.isOk() {
            self.getHttpData(r.getAllData())
        }
    }
    
    func getHttpData(data:NSMutableArray){
        let info = data.firstObject as? DSGetPersonAccountInfo
        if info?.role == "INDIVIDUAL" || info?.role == "ROLE_INDIVIDUAL" {
           //self.mineHeadInfo.headImage = info!.avatar
            self.mineHeadInfo.name = info!.name
            DSAccountInfo.sharedInstance().avatar = info?.avatar
            DSAccountInfo.sharedInstance().name = info?.name
        }else if(info?.role == "PARK_ADMIN"){
            self.mineHeadInfo.name = info?.park?.name
            //self.mineHeadInfo.subTitle = info?.park?.parkName?.stringByAppendingString(""+(info?.park?.job))
            self.mineHeadInfo.subTitle = self.tihuan(info?.park?.parkName, str2: info?.park?.job)
            DSAccountInfo.sharedInstance().name = info?.park?.name
            DSAccountInfo.sharedInstance().perPhoneNum = info?.park?.phone
            DSAccountInfo.sharedInstance().job = info?.park?.job
        }
        else{
            self.mineHeadInfo.subTitle = info?.institutioner?.institution?.company?.stringByAppendingFormat("  "+(info?.institutioner?.title)!)
            self.mineHeadInfo.name = info?.institutioner?.name
            DSAccountInfo.sharedInstance().name = info?.institutioner?.name
        }
        self.myTableView.reloadData()
    }
    func tihuan(str1:String?,str2:String?) -> (String?) {
        if str1==nil && str2==nil {
            return ""
        }else if(str1 != nil && str2 == nil){
            return str1
        }else if(str1 == nil && str2 != nil){
            return str2
        }else{
            return str1!+" "+str2!
        }
    }
}
