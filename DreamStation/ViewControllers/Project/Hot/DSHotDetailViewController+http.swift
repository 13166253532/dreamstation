//
//  DSHotDetailViewController+http.swift
//  DreamStation
//
//  Created by xjb on 2016/11/14.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

extension DSHotDetailViewController {

    //MARK:---------------查看是否收藏------------------
    func httpIsCollectionsRequire(){
        let cmd:HttpCommand=DSHttpIsCollectionsCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self?.httpIsCollectionResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        let dict:NSMutableDictionary=NSMutableDictionary()
        dict[kHttpParamKey_IsCollections_groupId]=DSAccountInfo.sharedInstance().institutionId
        
        dict[kHttpParamKey_IsCollections_collections]=self.projectId
        dict[kHttpParamKey_IsCollections_type]="PRODUCT"
        cmd.requestInfo=dict as [NSObject:AnyObject]
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    func httpIsCollectionResponse(result:RequestResult){
        let r:DSHttpIsCollectionsResult = result as! DSHttpIsCollectionsResult
        if result.isOk() {
            self.getHttpData(r.getTheContent())
            self.tableView .reloadData()
        }
    }
    func getHttpData(data:NSMutableArray){
        listInfo = data.lastObject as! DSHttpCollectionsListInfo
        
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
        self.initCollectionBtn()
    }
    
    //MARK:---------------查看是否约谈------------------
    func httpIsFollowRequire(){
        let cmd:HttpCommand=DSHttpIsFollowCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self?.httpIsFollowResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_IsFollow_model] = "INTERVIEW"
        dic[kHttpParamKey_IsFollow_investorId] = DSAccountInfo.sharedInstance().personId         //投资者ID
        dic[kHttpParamKey_IsFollow_productUserId] = self.info.userId      //项目UserId
        dic[kHttpParamKey_IsFollow_productId] = self.info.id    //项目ID
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    func httpIsFollowResponse(result:RequestResult){
        let r:DSHttpIsFollowResult = result as! DSHttpIsFollowResult
        if r.isOk() {
            //self.getHttpIsFollowData(r.getAllContent())
            self.isFollow = false
            
        }else{
            self.isFollow = true
        }
        self.tableView .reloadData()
        initFollowBtn()
    }
    //MARK:---------------获取浏览量------------------
    func getHttpGetStatisticsRequire(){
        let cmd:HttpCommand = DSHttpGetStatisticsCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {(result:RequestResult!,useInfo:AnyObject!)->() in
            self.httpGetStatisticsResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_GetStatistics_targetId] = self.projectId
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block:block,withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        self.detailUrl = cmd.getUrl()
        cmd.execute()
    }
    func httpGetStatisticsResponse(result:RequestResult){
        let r:DSHttpGetStrtisticsResult = result as! DSHttpGetStrtisticsResult
        if r.isOk() {
            self.readString = r.getAllTheContent()
//            self.initTableView()
            self.updateReadString()
//            self.tableView.reloadData()
        }
    }
    //MARK:---------------获取热度------------------
    func getHttpGetFollowCountRequire(){
        let cmd:HttpCommand = DSHttpFollowCountNumCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {(result:RequestResult!,useInfo:AnyObject!)->() in
            self.httpGetFollowCountResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_FollowCountNum_role] = "PROVIDER"
        dic[kHttpParamKey_FollowCountNum_id] = self.projectId
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block:block,withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        self.detailUrl = cmd.getUrl()
        cmd.execute()
    }
    func httpGetFollowCountResponse(result:RequestResult){
        let r:DSHttpFollowCountNumResule = result as! DSHttpFollowCountNumResule
        if r.isOk() {
            self.hotString = r.getCount()
            self.tableView.reloadData()
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
        dic[kHttpParamKey_PostStatistics_targetId] = self.projectId
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block:block,withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        self.detailUrl = cmd.getUrl()
        cmd.execute()
    }
    func httpPostStatisticsResponse(result:RequestResult){
        let r:DSHttpPostStatisticsResult = result as! DSHttpPostStatisticsResult
        if r.isOk() {
            
        }
    }
    //MARK:---------------加载项目详细------------------
    func getHttpProjectdetailsRequire(){
        let cmd:HttpCommand = DSHttpProductsDetailsCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {(result:RequestResult!,useInfo:AnyObject!)->() in
            self.httpProjectdetailsResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_productsDetails_id] = self.projectId
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
            self.httpIsFollowRequire()
            self.getHttpGetStatisticsRequire()
            self.getHttpPostStatisticsRequire()
            //self.getHttpGetFollowCountRequire()
            self.updateTabeView()
           
            self.tableView.reloadData()
        }
    }
    func getHttptData(data:NSMutableArray){
        self.info = data[0] as! DSProductsDetailsInfo
    }
    //MARK:---------------实现收藏------------------
    func httpCollectionsRequire(){
        let cmd:HttpCommand=DSHttpCollectionCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self?.httpCollectionResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_Collection_userGroupId] = DSAccountInfo.sharedInstance().institutionId
        dic[kHttpParamKey_Collection_collections] = self.projectId
        dic[kHttpParamKey_Collection_collectionsType] = "PRODUCT"
        dic[kHttpParamKey_Collection_username] = DSAccountInfo.sharedInstance().name
        dic[kHttpParamKey_Collection_mark] = collectionMessage
        let contentDic:NSMutableDictionary = NSMutableDictionary()
        contentDic[kHttpParamKey_Collection_collectionsContent_id] = self.projectId
        contentDic[kHttpParamKey_Collection_collectionsContent_titleName] = self.info.brief
        
        contentDic[kHttpParamKey_Collection_collectionsContent_videoUrl] = self.info.videoUrl
        contentDic[kHttpParamKey_Collection_collectionsContent_level] = self.info.Inthearea
        
        let datas = try! NSJSONSerialization.dataWithJSONObject(self.info.industryList, options: NSJSONWritingOptions.PrettyPrinted)
        let typeTag = String(data: datas,encoding: NSUTF8StringEncoding)
        contentDic[kHttpParamKey_Collection_collectionsContent_typeTag] = typeTag

        contentDic[kHttpParamKey_Collection_collectionsContent_favoriteNotes] = self.info.amountPhase
        
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
            self.initCollectionBtn()
        }
    }
    //MARK:---------------取消收藏收藏------------------
    func httpCollectionDeleteRequire(){
        let cmd:HttpCommand=DSHttpCollectionDeleteCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock={[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self?.httpCollectionDeleteResponse(result)
        }
        let dict:NSMutableDictionary=NSMutableDictionary()
        dict[kHttpParamKey_Collection_collectionId]=self.projectId
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
            self.initCollectionBtn()
        }
    }
    //MARK:---------------获得当前用户信息----------------
    func httpPersonAccountRequire(){
        let cmd:HttpCommand=DSHttpGetPersonAccountCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock={[weak self](result:RequestResult!,useInfo:AnyObject!)->() in
            self?.httpPersonAccountResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_GetPersonAccount_person_id] = DSAccountInfo.sharedInstance().personId
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    func httpPersonAccountResponse(result:RequestResult){
        let r:DSHttpGetPersonAccountResult = result as! DSHttpGetPersonAccountResult
        if result.isOk() {
            self.getPersonAccountData(r.getAllData())
        }else{
            SMToast("请查看当前网络状态！")
        }
    }
    func getPersonAccountData(arr:NSMutableArray){
        self.perInfo = arr.lastObject as! DSGetPersonAccountInfo
        self.httpRequestInterviewRequire()
    }
    func getDomainPhase(catList:NSMutableArray?,shaiString:String!) -> (String) {
        var str:String?
        let list = catList
        if list != nil && list?.count != 0{
            for index in 0...(list?.count)!-1 {
                let catInfo = list![index] as! DSGetPersonAccountCatsInfo
                if catInfo.catName == shaiString {
                    if str != nil {
                        str = str!+" "+catInfo.descriptions!
                    }else{
                        str = catInfo.descriptions!
                    }
                }
            }
            return str == nil ? "" : str!
        }
        return ""
    }
    
    //MARK:---------------发起约谈----------------
    func httpRequestInterviewRequire(){
        let cmd:HttpCommand=DSHttpRequestFollowCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self?.httpRequestInterviewResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        let diction:NSMutableDictionary = NSMutableDictionary()
        let list:NSMutableArray = NSMutableArray()
        dic[kHttpParamKey_RequestFollow_model] = "INTERVIEW"
        
        let providerDic:NSMutableDictionary = NSMutableDictionary()
        providerDic[kHttpParamKey_RequestFollow_items_productName] = self.info.brief
        providerDic[kHttpParamKey_RequestFollow_items_categories] = self.info.cat//项目 分类
        providerDic[kHttpParamKey_RequestFollow_items_productUrl] = self.info.videoUrl//项目视频地址
        providerDic[kHttpParamKey_RequestFollow_items_productId] = self.info.id//项目id
        providerDic[kHttpParamKey_RequestFollow_items_productUserId] = self.info.userId//项目方 卖方id
        providerDic[kHttpParamKey_RequestFollow_items_userName] = self.info.userName//项目方名字
        providerDic[kHttpParamKey_RequestFollow_items_address] = self.info.address//项目认证地址
        providerDic[kHttpParamKey_RequestFollow_items_account] = ""//项目方账号
        
        
        
        let individualDic:NSMutableDictionary = NSMutableDictionary()
        individualDic[kHttpParamKey_RequestFollow_items_investmentUserId] = DSAccountInfo.sharedInstance().personId//投资人id
        individualDic[kHttpParamKey_RequestFollow_items_account] = DSAccountInfo.sharedInstance().phoneNum//投资人账号
//        individualDic[kHttpParamKey_RequestFollow_items_userName] = DSAccountInfo.sharedInstance().name//投资人名字
//        individualDic[kHttpParamKey_RequestFollow_items_avaterUrl] = DSAccountInfo.sharedInstance().avatar//投资人头像
        individualDic[kHttpParamKey_RequestFollow_items_userName] = self.perInfo.name//投资人名字
        individualDic[kHttpParamKey_RequestFollow_items_avaterUrl] = self.perInfo.avatar//投资人头像
        individualDic[kHttpParamKey_RequestFollow_items_domain] = self.getDomainPhase(self.perInfo.individual?.cats, shaiString: "关注领域")//所属行业
        individualDic[kHttpParamKey_RequestFollow_items_phase] = self.getDomainPhase(self.perInfo.individual?.cats, shaiString: "投资阶段")//融资阶段
        individualDic[kHttpParamKey_RequestFollow_items_videoUrl] = self.perInfo.individual?.videoUrl//介绍视频地址
        individualDic[kHttpParamKey_RequestFollow_items_wechat] = self.perInfo.individual?.wechat//微信号
        individualDic[kHttpParamKey_RequestFollow_items_introduceImgUrl] = self.perInfo.individual?.videoImage//介绍缩略图
        individualDic[kHttpParamKey_RequestFollow_items_introduceDesc] = self.perInfo.individual?.videoTitle//介绍标题,描述
        
        
        
        let institutionerDic = NSMutableDictionary()
        institutionerDic[kHttpParamKey_RequestFollow_items_investmentUserId] = DSAccountInfo.sharedInstance().personId//投资人id
        institutionerDic[kHttpParamKey_RequestFollow_items_userGroupId] = self.perInfo.institutioner?.institution?.id //投资机构id
        institutionerDic[kHttpParamKey_RequestFollow_items_account] = DSAccountInfo.sharedInstance().phoneNum//投资人账号
        institutionerDic[kHttpParamKey_RequestFollow_items_userName] = DSAccountInfo.sharedInstance().name//投资人名字
        
        institutionerDic[kHttpParamKey_RequestFollow_items_avaterUrl] = DSAccountInfo.sharedInstance().avatar//投资机构头像
        
        institutionerDic[kHttpParamKey_RequestFollow_items_domain] = self.getDomainPhase(self.perInfo.institutioner?.cats, shaiString: "关注领域")//所属行业
        institutionerDic[kHttpParamKey_RequestFollow_items_phase] = self.getDomainPhase(self.perInfo.institutioner?.cats, shaiString: "投资阶段")//融资阶段
        institutionerDic[kHttpParamKey_RequestFollow_items_videoUrl] = self.perInfo.institutioner?.institution?.videoUrl//机构介绍视频地址
        institutionerDic[kHttpParamKey_RequestFollow_items_wechat] = self.perInfo.institutioner?.institution?.weichat//微信号
        institutionerDic[kHttpParamKey_RequestFollow_items_companyName] = self.perInfo.institutioner?.name//公司名字
        institutionerDic[kHttpParamKey_RequestFollow_items_introduceImgUrl] = self.perInfo.institutioner?.institution?.videoImg//介绍缩略图
        institutionerDic[kHttpParamKey_RequestFollow_items_introduceDesc] = self.perInfo.institutioner?.institution?.videoText//介绍标题,描述
        
        
        if DSAccountInfo.sharedInstance().role == "INDIVIDUAL" {
            diction[kHttpParamKey_RequestFollow_individual] = individualDic
        }else{
            diction[kHttpParamKey_RequestFollow_institutioner] = institutionerDic
        }
        diction[kHttpParamKey_RequestFollow_provider] = providerDic
        list.addObject(diction)
        dic[kHttpParamKey_RequestFollow_items] = list
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
        
    }
    func httpRequestInterviewResponse(result:RequestResult){
        let r:DSHttpRequestFollowResult = result as! DSHttpRequestFollowResult
        if r.isOk() {
            self.isFollow = true
            //            SMToast("约谈成功！")
            SMAlertView.showOnlyButtonAlert("您已成功提交了约谈意向。当项目热度较高时，平台将为您安排线下路演对接，请留意我们的平台通知。",title:"提交成功!")
            
            self.initFollowBtn()
        }else{
            //            SMToast("约谈失败！")
            SMAlertView.showOnlyButtonAlert(result.errMsg,title:"约谈失败!")
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        if buttonIndex == 0 {//否
            NSLog("000")
        }else if buttonIndex == 1{//是
            collectionViewShow()
            //NSLog("111")
            //           httpCollectionsRequire()
            //            collectMarkView();
        }
    }

}
