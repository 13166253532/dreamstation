//
//  DSMineViewController+Http.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/2.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

extension DSMineViewController{
    

    
    //MARK:-----获取项目方用户信息
    func httpGetProductsInfoRequire(){
        let cmd:DSHttpPerProductsCmd = DSHttpPerProductsCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpPerProductsCmd
        let block:httpBlock = {(result:RequestResult!,useInfo:AnyObject!)->()in
            self.httpGetProductsInfoResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_PerProducts_id] = DSAccountInfo.sharedInstance().personId
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpGetProductsInfoResponse(result:RequestResult){
        let r:DSHttpPerProductsResult = result as! DSHttpPerProductsResult
        if r.isOk() {
            self.getAllPerInfoData(r.getAllContent())
            self.getFollowNum()
        }
    }
    
    func getAllPerInfoData(array:NSMutableArray){
        let info = array[0] as! DSProductsInfo
       
        if info.companyName != nil && info.position != nil {
           self.mineHeadInfo.subTitle = info.companyName?.stringByAppendingString("  "+info.position!)
        }else if info.companyName != nil && info.position == nil {
            self.mineHeadInfo.subTitle = info.companyName
        }
        DSAccountInfo.sharedInstance().productsId = info.id
        //DSAccountInfo.sharedInstance().categories = info.categories
        DSAccountInfo.sharedInstance().companyName = info.companyName
        DSAccountInfo.sharedInstance().address = info.address
        DSAccountInfo.sharedInstance().videoUrl = info.videoUrl
        DSAccountInfo.sharedInstance().productsName = info.brief
        self.myTableView.reloadData()

        
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
        self.mineHeadInfo.subTitle = info?.institutioner?.institution?.company?.stringByAppendingFormat("  "+(info?.institutioner?.title)!)
        self.myTableView.reloadData()
    }
    
}