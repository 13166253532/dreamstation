//
//  DSParkDetailsVC+http.swift
//  DreamStation
//
//  Created by xjb on 2016/11/14.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

extension DSParkDetailsVC {

    //MARK:--------园区详情加载-----------
    func httpGetParkDetailsRequire(){
        let cmd:HttpCommand=DSHttpGetPersonAccountCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock={[weak self](result:RequestResult!,useInfo:AnyObject!)->() in
            self?.httpGetParkDetailsResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_GetPersonAccount_person_id] = self.parkId
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        self.shareUrl = cmd.getUrl()
        cmd.execute()
    }
    func httpGetParkDetailsResponse(result:RequestResult){
        let r:DSHttpGetPersonAccountResult = result as! DSHttpGetPersonAccountResult
        if result.isOk() {
            self.getGetParkDetailsData(r.getAllData())
            self.httpisApplyParkRequire()
            self.httpParkIsCollectionsRequire()
            self.initTableview()
            self.initDataSource()
            self.myTableView .reloadData()
        }
    }
    func getGetParkDetailsData(arr:NSMutableArray){
        self.info = arr.lastObject as! DSGetPersonAccountInfo
    }
    //MARK:---------------判断是否收藏----------------
    func httpParkIsCollectionsRequire(){
        let cmd:HttpCommand=DSHttpIsCollectionsCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self?.httpParkIsCollectionResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        let dict:NSMutableDictionary=NSMutableDictionary()
        dict[kHttpParamKey_IsCollections_groupId]=self.parkId
        dict[kHttpParamKey_IsCollections_collections]=self.parkId
        dict[kHttpParamKey_IsCollections_type]="PARK"
        cmd.requestInfo=dict as [NSObject:AnyObject]
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    func httpParkIsCollectionResponse(result:RequestResult){
        let r:DSHttpIsCollectionsResult = result as! DSHttpIsCollectionsResult
        if result.isOk() {
            self.getParkHttpData(r.getTheContent())
            self.myTableView .reloadData()
        }
    }
    func getParkHttpData(data:NSMutableArray){
        let listInfo:DSHttpCollectionsListInfo = data.lastObject as! DSHttpCollectionsListInfo
        
        switch listInfo.status{
        case "NOT_COLLECTION":
            self.isCollection = false
            break
        case "HAS_COLLECTIONED":
            self.isCollection = true
            break
        case "COLLECTION_CONFLIT":
            self.isCollection = false
            break
        default:
            break
        }
        self.addCollectionBtn()
    }
    //MARK:判断是否申请入驻
    func httpisApplyParkRequire(){
        let cmd:HttpCommand=DSHttpisApplyParkCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock={[weak self](result:RequestResult!,useInfo:AnyObject!)->() in
            self?.httpisApplyParkResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_isApplyPark_projectId] = DSAccountInfo.sharedInstance().productsId//项目id
        dic[kHttpParamKey_isApplyPark_parkId] = self.parkId//园区id
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
        
    }
    func httpisApplyParkResponse(result:RequestResult){
        let r:DSHttpisApplyParkResult = result as! DSHttpisApplyParkResult
        if r.isOk() {
            self.isPlay = false
        }else{
            self.isPlay = true
        }
        self.addPlayBtn()
    }
    //MARK:---------------实现收藏----------------
    func httpParkCollectionsRequire(){
        let cmd:HttpCommand=DSHttpCollectionCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self?.httpParkCollectionResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_Collection_userGroupId] = self.parkId
        dic[kHttpParamKey_Collection_collections] = self.parkId
        dic[kHttpParamKey_Collection_collectionsType] = "PARK"
        dic[kHttpParamKey_Collection_username] = DSAccountInfo.sharedInstance().productsmyName
        
        let contentDic:NSMutableDictionary = NSMutableDictionary()
        contentDic[kHttpParamKey_Collection_collectionsContent_id] = self.parkId
        contentDic[kHttpParamKey_Collection_collectionsContent_titleName] = self.info.park?.parkName
        
        let datas = try! NSJSONSerialization.dataWithJSONObject(self.cityArray, options: NSJSONWritingOptions.PrettyPrinted)
        let typeTag = String(data: datas,encoding: NSUTF8StringEncoding)
        
        contentDic[kHttpParamKey_Collection_collectionsContent_typeTag] = typeTag
        contentDic[kHttpParamKey_Collection_collectionsContent_videoUrl] = self.info.park?.vedioUrl
        contentDic[kHttpParamKey_Collection_collectionsContent_level] = self.info.park?.briefIntroduction
        
        contentDic[kHttpParamKey_Collection_collectionsContent_iconUrl] = self.info.park?.parkLogo
        contentDic[kHttpParamKey_Collection_collectionsContent_videoPicUrl] = self.info.park?.vedioImg
        contentDic[kHttpParamKey_Collection_collectionsContent_videoTitle] = self.info.park?.vedioTitle
        let data = try! NSJSONSerialization.dataWithJSONObject(contentDic, options: NSJSONWritingOptions.PrettyPrinted)
        let strJson = String(data: data,encoding: NSUTF8StringEncoding)
        print(strJson!)
        dic[kHttpParamKey_Collection_collectionsContent]=strJson!
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    func httpParkCollectionResponse(result:RequestResult){
        let r:DSHttpCollectionResult = result as! DSHttpCollectionResult
        if r.isOk() {
            self.isCollection = true
            SMToast("收藏成功！")
            self.addCollectionBtn()
        }
    }
    //MARK:---------------取消收藏----------------
    func httpParkCollectionDeleteRequire(){
        let cmd:HttpCommand=DSHttpCollectionDeleteCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock={[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self?.httpParkCollectionDeleteResponse(result)
        }
        let dict:NSMutableDictionary=NSMutableDictionary()
        dict[kHttpParamKey_Collection_collectionId]=self.info.id
        cmd.requestInfo=dict as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    func httpParkCollectionDeleteResponse(result:RequestResult){
        let r:DSHttpCollectionDeleteResult = result as! DSHttpCollectionDeleteResult
        if r.isOk() {
            self.isCollection = false
            SMToast("取消收藏！")
            self.addCollectionBtn()
            
        }
    }
    //MARK:实现申请入驻
    func httpApplyParkRequire(){
        let cmd:HttpCommand=DSHttpParkApplyCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock={[weak self](result:RequestResult!,useInfo:AnyObject!)->() in
            self?.httpApplyParkResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_ParkApply_phone] = DSAccountInfo.sharedInstance().phoneNum//手机号
        dic[kHttpParamKey_ParkApply_name] = DSAccountInfo.sharedInstance().productsmyName//姓名
        dic[kHttpParamKey_ParkApply_company] = DSAccountInfo.sharedInstance().companyName//公司名字
        dic[kHttpParamKey_ParkApply_title] = DSAccountInfo.sharedInstance().productsName//项目名字
        dic[kHttpParamKey_ParkApply_parkId] = self.parkId//园区id
        dic[kHttpParamKey_ParkApply_projectId] = DSAccountInfo.sharedInstance().productsId//项目id
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        self.shareUrl = cmd.getUrl()
        cmd.execute()
        
    }
    func httpApplyParkResponse(result:RequestResult){
        let r:DSHttpParkApplyResult = result as! DSHttpParkApplyResult
        if r.isOk() {
            SMAlertView.showOnlyButtonAlert("我们将在24小时内联系您，请保持手机畅通",title:"申请已提交")
            //SMToast("申请成功！")
            self.isPlay = true
            self.addPlayBtn()
        }else{
            SMAlertView.showOnlyButtonAlert(result.errMsg,title:"申请提交失败！")
            // SMToast("申请失败！")
        }
    }

    
}
