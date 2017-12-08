//
//  DSPerInvesDetailsViewController+http.swift
//  DreamStation
//
//  Created by xjb on 2016/11/14.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

extension DSPerInvesDetailsViewController {

    //MARK:---------------获取浏览量------------------
    func getHttpGetStatisticsRequire(){
        let cmd:HttpCommand = DSHttpGetStatisticsCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {(result:RequestResult!,useInfo:AnyObject!)->() in
            self.httpGetStatisticsResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_GetStatistics_targetId] = self.person_id
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block:block,withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    func httpGetStatisticsResponse(result:RequestResult){
        let r:DSHttpGetStrtisticsResult = result as! DSHttpGetStrtisticsResult
        if r.isOk() {
            self.infoData.InvesBrowse = r.getAllTheContent()
            self.initTableView()
            self.initDataSource()
            self.myTableView.reloadData()
        }
    }

    //MARK:---------------添加浏览次数------------------
    func getHttpPostStatisticsRequire(){
        let cmd:HttpCommand = DSHttpPostStatisticsCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {(result:RequestResult!,useInfo:AnyObject!)->() in
            self.httpPostStatisticsResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_PostStatistics_userId] = DSAccountInfo.sharedInstance().personId
        dic[kHttpParamKey_PostStatistics_targetId] = self.person_id
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block:block,withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    func httpPostStatisticsResponse(result:RequestResult){
        let r:DSHttpPostStatisticsResult = result as! DSHttpPostStatisticsResult
        if r.isOk() {
            
        }
    }
    //MARK:---------------获取热度------------------
    func getHttpGetFollowCountRequire(){
        let cmd:HttpCommand = DSHttpFollowCountNumCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {(result:RequestResult!,useInfo:AnyObject!)->() in
            self.httpGetFollowCountResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_FollowCountNum_role] = self.tihauanRole()
        dic[kHttpParamKey_FollowCountNum_id] = self.person_id
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block:block,withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        //        self.detailUrl = cmd.getUrl()
        cmd.execute()
    }
    func httpGetFollowCountResponse(result:RequestResult){
        let r:DSHttpFollowCountNumResule = result as! DSHttpFollowCountNumResule
        if r.isOk() {
            self.followNum = r.getCount()
            
            self.myTableView.reloadData()
        }
    }
    func tihauanRole() -> (String) {
        if self.info.role == "INSTITUTION" {
            return "INSTITUTION"
        }else{
            return "INDIVIDUAL"
        }
    }

    //MARK:------------获取投资者信息---------------
    func httpGetPersonAccountRequire(){
        let cmd:HttpCommand=DSHttpGetPersonAccountCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock={[weak self](result:RequestResult!,useInfo:AnyObject!)->() in
            self?.httpGetPersonAccountResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_GetPersonAccount_person_id] = self.person_id
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    func httpGetPersonAccountResponse(result:RequestResult){
        let r:DSHttpGetPersonAccountResult = result as! DSHttpGetPersonAccountResult
        if result.isOk() {
            self.getGetPersonAccountData(r.getAllData())
            self.httpIsFollowRequire()
            self.httpIsCollectionsRequire()
            self.getHttpGetStatisticsRequire()
            self.getHttpPostStatisticsRequire()
            self.getHttpGetFollowCountRequire()
            self.myTableView .reloadData()
        }
    }
    func getGetPersonAccountData(arr:NSMutableArray){
        self.info = arr.lastObject as! DSGetPersonAccountInfo
        var list:NSMutableArray?
        if self.info.role == "INSTITUTION" {
            list = self.info!.institution!.cats!
            self.infoData.InvesHeadImageUrl = self.info.institution?.logo
            self.infoData.cases = self.info.institution?.cases
            self.infoData.investMin = self.info.institution?.investMin
            self.infoData.investMax = self.info.institution?.investMax
            self.infoData.InvesName = self.info.institution?.company
            self.infoData.videoText = self.info.institution?.videoText
            self.infoData.videoUrl = self.info.institution?.videoUrl
            self.infoData.videoImg = self.info.institution?.videoImg
            self.infoData.introduction = self.info.institution?.introduction
            self.withContent = self.info.institution?.introduction
            self.infoData.weichat = self.info.institution?.weichat
            self.infoData.videoText = self.info.institution?.videoText
            self.followNum = self.info.institution?.followCount
            //self.infoData.InvesBrowse = self.info.institution.
        }else{
            list = self.info!.individual!.cats!
            self.infoData.InvesHeadImageUrl = self.info.avatar
            self.infoData.investMin = self.info.individual?.investMin
            self.infoData.investMax = self.info.individual?.investMax
            self.infoData.InvesName = self.info.name
            self.infoData.videoText = self.info.individual?.videoTitle
            self.infoData.videoUrl = self.info.individual?.videoUrl
            self.infoData.videoImg = self.info.individual?.videoImage
            self.infoData.introduction = self.info.individual?.introduction
            self.withContent = self.info.individual?.introduction
            self.infoData.weichat = self.info.individual?.wechat
            self.infoData.cases = self.info.individual?.cases
            self.infoData.videoText = self.info.individual?.videoTitle
            self.followNum = self.info.individual?.followCount
        }
        for index in 0..<list!.count {
            let cats:DSGetPersonAccountCatsInfo = list![index] as! DSGetPersonAccountCatsInfo
            if cats.catName == "关注领域" {
                if self.infoData.Invesindustry != nil{
                    self.infoData.Invesindustry = self.infoData.Invesindustry!+" "+cats.descriptions!
                }else{
                    self.infoData.Invesindustry = cats.descriptions
                }
            }else if cats.catName == "投资阶段" {
                if self.infoData.InvesPhase != nil{
                    self.infoData.InvesPhase = self.infoData.InvesPhase!+" "+cats.descriptions!
                }else{
                    self.infoData.InvesPhase = cats.descriptions
                }
            }else if cats.catName == "投资地域"{
                if self.infoData.InvesLocation != nil{
                    self.infoData.InvesLocation = self.infoData.InvesLocation!+" "+cats.descriptions!
                }else{
                    self.infoData.InvesLocation = cats.descriptions
                }
                //self.infoData.InvesLocation = cats.descriptions
            }else if cats.catName == "主投币种"{
                self.infoData.InvesCurrency = cats.descriptions
            }else if cats.catName == "投资偏好"{
                self.infoData.preferences = cats.descriptions
            }
        }
        self.initTableView()
        self.initDataSource()
        self.myTableView .reloadData()
    }
    //MARK:---------------查看是否关注------------------
    func httpIsFollowRequire(){
        let cmd:HttpCommand=DSHttpIsFollowCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self?.httpIsFollowResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_IsFollow_model] = "FOLLOW"
        //投资者ID
        if self.info.role == "INSTITUTION" {
            dic[kHttpParamKey_IsFollow_investmentId] = self.person_id
        }else{
            dic[kHttpParamKey_IsFollow_investorId] = self.person_id
        }
        dic[kHttpParamKey_IsFollow_productUserId] =  DSAccountInfo.sharedInstance().personId     //项目UserId
        dic[kHttpParamKey_IsFollow_productId] = DSAccountInfo.sharedInstance().productsId    //项目ID
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    func httpIsFollowResponse(result:RequestResult){
        let r:DSHttpIsFollowResult = result as! DSHttpIsFollowResult
        
        if r.isOk() {
            self.isFollow = false
            
        }else{
            self.isFollow = true
        }
        self.addFollowBtn()
    }
    //MARK:---------------判断是否收藏----------------
    func httpIsCollectionsRequire(){
        let cmd:HttpCommand=DSHttpIsCollectionsCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self?.httpIsCollectionResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        let dict:NSMutableDictionary=NSMutableDictionary()
        dict[kHttpParamKey_IsCollections_groupId]=self.info.id
        dict[kHttpParamKey_IsCollections_collections]=self.info.id
        dict[kHttpParamKey_IsCollections_type]="INVESTMENT"
        cmd.requestInfo=dict as [NSObject:AnyObject]
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    func httpIsCollectionResponse(result:RequestResult){
        let r:DSHttpIsCollectionsResult = result as! DSHttpIsCollectionsResult
        if result.isOk() {
            self.getHttpData(r.getTheContent())
            self.myTableView .reloadData()
        }
    }
    func getHttpData(data:NSMutableArray){
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

    //MARK:---------------实现收藏----------------
    func httpCollectionsRequire(){
        let cmd:HttpCommand=DSHttpCollectionCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self?.httpCollectionResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_Collection_userGroupId] = self.info.id
        dic[kHttpParamKey_Collection_collections] = self.info.id
        dic[kHttpParamKey_Collection_collectionsType] = "INVESTMENT"
        dic[kHttpParamKey_Collection_username] = self.info.name
        
        let contentDic:NSMutableDictionary = NSMutableDictionary()
        contentDic[kHttpParamKey_Collection_collectionsContent_id] = self.info.id;
        contentDic[kHttpParamKey_Collection_collectionsContent_titleName] = self.infoData.InvesName
        contentDic[kHttpParamKey_Collection_collectionsContent_level] = self.infoData.Invesindustry
        contentDic[kHttpParamKey_Collection_collectionsContent_videoUrl] = self.infoData.videoUrl
        contentDic[kHttpParamKey_Collection_collectionsContent_favoriteNotes] = self.infoData.InvesPhase
        //contentDic[kHttpParamKey_Collection_collectionsContent_level] = ""
        contentDic[kHttpParamKey_Collection_collectionsContent_iconUrl] = self.infoData.InvesHeadImageUrl
        contentDic[kHttpParamKey_Collection_collectionsContent_videoPicUrl] = self.infoData.videoImg
        contentDic[kHttpParamKey_Collection_collectionsContent_videoTitle] = self.infoData.videoText
        let data = try! NSJSONSerialization.dataWithJSONObject(contentDic, options: NSJSONWritingOptions.PrettyPrinted)
        let strJson = String(data: data,encoding: NSUTF8StringEncoding)
        dic[kHttpParamKey_Collection_collectionsContent]=strJson!
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    func httpCollectionResponse(result:RequestResult){
        let r:DSHttpCollectionResult = result as! DSHttpCollectionResult
        if r.isOk() {
            self.isCollection = true
            SMToast("收藏成功！")
            self.addCollectionBtn()
        }
    }
    //MARK:---------------取消收藏----------------
    func httpCollectionDeleteRequire(){
        let cmd:HttpCommand=DSHttpCollectionDeleteCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock={[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self?.httpCollectionDeleteResponse(result)
        }
        let dict:NSMutableDictionary=NSMutableDictionary()
        dict[kHttpParamKey_Collection_collectionId]=self.info.id
        cmd.requestInfo=dict as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    func httpCollectionDeleteResponse(result:RequestResult){
        let r:DSHttpCollectionDeleteResult = result as! DSHttpCollectionDeleteResult
        if r.isOk() {
            self.isCollection = false
            SMToast("取消收藏！")
            self.addCollectionBtn()
        }else{
            SMToast("请查看当前网络状态！")
        }
    }
    
    
    
    //MARK:---------------求关注----------------
    func httpRequestFollowRequire(){
        let cmd:HttpCommand=DSHttpRequestFollowCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self?.httpRequestFollowResponse(result)
        }
        
        let dic:NSMutableDictionary = NSMutableDictionary()
        let diction:NSMutableDictionary = NSMutableDictionary()
        let list:NSMutableArray = NSMutableArray()
        
        let providerDic:NSMutableDictionary = NSMutableDictionary()
        providerDic[kHttpParamKey_RequestFollow_items_productName] = DSAccountInfo.sharedInstance().productsName
        providerDic[kHttpParamKey_RequestFollow_items_categories] = DSAccountInfo.sharedInstance().categories//项目 分类
        providerDic[kHttpParamKey_RequestFollow_items_productUrl] = DSAccountInfo.sharedInstance().videoUrl//项目视频地址
        providerDic[kHttpParamKey_RequestFollow_items_productId] = DSAccountInfo.sharedInstance().productsId//项目id
        providerDic[kHttpParamKey_RequestFollow_items_productUserId] = DSAccountInfo.sharedInstance().personId//项目方 卖方id
        providerDic[kHttpParamKey_RequestFollow_items_userName] = DSAccountInfo.sharedInstance().name//项目方名字
        providerDic[kHttpParamKey_RequestFollow_items_address] = DSAccountInfo.sharedInstance().address//项目认证地址
        providerDic[kHttpParamKey_RequestFollow_items_account] = DSAccountInfo.sharedInstance().phoneNum//项目方账号
        providerDic[kHttpParamKey_RequestFollow_items_companyName] = DSAccountInfo.sharedInstance().companyName//项目方公司名字
        
        let individualDic:NSMutableDictionary = NSMutableDictionary()
        individualDic[kHttpParamKey_RequestFollow_items_investmentUserId] = self.info.id//投资人id
        individualDic[kHttpParamKey_RequestFollow_items_account] = self.info.login//投资人账号
        individualDic[kHttpParamKey_RequestFollow_items_userName] = self.info.name//投资人名字
        individualDic[kHttpParamKey_RequestFollow_items_avaterUrl] = self.infoData.InvesHeadImageUrl//投资人头像
        individualDic[kHttpParamKey_RequestFollow_items_domain] = self.infoData.Invesindustry//所属行业
        individualDic[kHttpParamKey_RequestFollow_items_phase] = self.infoData.InvesPhase//融资阶段
        individualDic[kHttpParamKey_RequestFollow_items_videoUrl] = self.infoData.videoUrl//介绍视频地址
        individualDic[kHttpParamKey_RequestFollow_items_wechat] = self.infoData.weichat//微信号
        individualDic[kHttpParamKey_RequestFollow_items_introduceImgUrl] = self.infoData.videoImg//介绍缩略图
        individualDic[kHttpParamKey_RequestFollow_items_introduceDesc] = self.infoData.videoText //介绍标题,描述
        
        
        
        let institutionerDic = NSMutableDictionary()
        //institutionerDic[kHttpParamKey_RequestFollow_items_investmentUserId] = self.info.id//投资人id
        institutionerDic[kHttpParamKey_RequestFollow_items_userGroupId] = self.info.id//投资机构id
        //institutionerDic[kHttpParamKey_RequestFollow_items_account] = self.info.login//投资人账号
        //institutionerDic[kHttpParamKey_RequestFollow_items_userName] = self.info.name//投资人名字
        institutionerDic[kHttpParamKey_RequestFollow_items_avaterUrl] = self.infoData.InvesHeadImageUrl//投资机构头像
        institutionerDic[kHttpParamKey_RequestFollow_items_domain] = self.infoData.Invesindustry//所属行业
        institutionerDic[kHttpParamKey_RequestFollow_items_phase] = self.infoData.InvesPhase//融资阶段
        institutionerDic[kHttpParamKey_RequestFollow_items_videoUrl] = self.infoData.videoUrl//机构介绍视频地址
        institutionerDic[kHttpParamKey_RequestFollow_items_wechat] = self.infoData.weichat//微信号
        institutionerDic[kHttpParamKey_RequestFollow_items_companyName] = self.infoData.InvesName//公司名字
        institutionerDic[kHttpParamKey_RequestFollow_items_introduceImgUrl] = self.infoData.videoImg//介绍缩略图
        institutionerDic[kHttpParamKey_RequestFollow_items_introduceDesc] = self.infoData.videoText //介绍标题,描述
        
        
        if self.info.role != "INDIVIDUAL" {
            diction[kHttpParamKey_RequestFollow_institutioner] = institutionerDic
        }else{
            diction[kHttpParamKey_RequestFollow_individual] = individualDic
        }
        diction[kHttpParamKey_RequestFollow_provider] = providerDic
        
        list.addObject(diction)
        
        dic[kHttpParamKey_RequestFollow_model] = "FOLLOW"
        dic[kHttpParamKey_RequestFollow_items] = list
        
        cmd.requestInfo = dic as [NSObject:AnyObject]
        
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
        
    }
    func httpRequestFollowResponse(result:RequestResult){
        let r:DSHttpRequestFollowResult = result as! DSHttpRequestFollowResult
        if r.isOk() {
            self.isFollow = true
            //            SMToast("求关注成功！")
            SMAlertView.showOnlyButtonAlert("您已成功向投资人提交了关注请求。如投资方有兴趣，会主动约谈您，当您的项目热度较高时，平台会为您安排线下路演对接，请您留意我们平台的通知。",title:"提交成功!")
            self.addFollowBtn()
        }else{
            SMToast("求关注失败！")
        }
    }
    func initCell(arr:NSMutableArray,cell:String,title:String?,subTitle:String?){
        let info = DSInvesDetailsHeadCelscrollViewDidScrolllModel()
        info.className = cell
        info.title = title
        info.subTitle = subTitle
        arr.addObject(info)
    }
    func initPartnerCell(arr:NSMutableArray,cell:String,headImage:String?,name:String?,position:String?,subTitle:String?){
        let info = DSInvesDetailsHeadCellModel()
        info.className = cell
        if headImage != nil {
            info.InvesHeadImageUrl = HTHttpConfig.sharedInstance().getServerAddress("").stringByAppendingFormat("/resource/view/"+headImage!)
        }
        info.InvesName = name
        info.title = position
        info.subTitle = subTitle
        arr.addObject(info)
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY : CGFloat = scrollView.contentOffset.y
        if offsetY > 100{
            let alpha = min(1, 1 - ((100 + 64 - offsetY) / 64));
            self.navigationController!.navigationBar.lt_setBackgroundColor(greenNavigationColor.colorWithAlphaComponent(alpha))
        }else {
            self.navigationController!.navigationBar.lt_setBackgroundColor(greenNavigationColor.colorWithAlphaComponent(0))
        }
    }

    
}
