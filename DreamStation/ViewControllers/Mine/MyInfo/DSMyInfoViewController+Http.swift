//
//  DSMyInfoViewController+Http.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/2.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

extension DSMyInfoViewController{
    
    //MARK:--------网络接口部分
    
    //MARK:-------获取当前用户的项目，得出项目id
    
    func httpGetPerProductsRequire(){
        let cmd:DSHttpPerProductsCmd = DSHttpPerProductsCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpPerProductsCmd
        let block:httpBlock = {(result:RequestResult!,useInfo:AnyObject!)->()in
            self.httpGetPerProductsResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_PerProducts_id] = DSAccountInfo.sharedInstance().personId
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpGetPerProductsResponse(result:RequestResult){
        let r:DSHttpPerProductsResult = result as! DSHttpPerProductsResult
        if r.isOk() {
            self.getAllPerData(r.getAllContent())
        }
    }
    
    func getAllPerData(array:NSMutableArray){
        let info = array[0] as! DSProductsInfo
        
        //self.httpGetProductAccountRequire(info.id!)
        self.projectID = info.id
    }
    
    
    
    //MARK:-------获取项目页面信息接口
    func httpGetProductAccountRequire(){
        
        let cmd:DSHttpProductsDetailsCmd = DSHttpProductsDetailsCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpProductsDetailsCmd
        let block:httpBlock = {(result:RequestResult!,useInfo:AnyObject!)->() in
            self.httpGetProductAccountResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_productsDetails_id] = DSAccountInfo.sharedInstance().productsId
        cmd.requestInfo = dic as [NSObject:AnyObject]
        
        let complegeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate = complegeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpGetProductAccountResponse(result:RequestResult){
        
        let r:DSHttpProductsDetailsResult = result as! DSHttpProductsDetailsResult
        if r.isOk() {
            self.getAllContent(r.getAllContent())
        }
    }
    
    func getAllContent(content:NSMutableArray){
        self.productInfo = content[0] as! DSProductsDetailsInfo
        self.initFiveStatus()
        self.tableView.reloadData()
    }
    
    
    //MARK:--------获取投资页面信息接口
    func httpGetPersonAccountRequire(type:MineStatus){
        let cmd:DSHttpGetPersonAccountCmd = DSHttpGetPersonAccountCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpGetPersonAccountCmd
        let block:httpBlock = {(result:RequestResult!,useInfo:AnyObject!)->() in
            self.httpGetPersonAccountResponse(result,type:type)
        }
        
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_GetPersonAccount_person_id] = DSAccountInfo.sharedInstance().personId
        cmd.requestInfo = dic as [NSObject:AnyObject]
        
        let complegeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate = complegeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpGetPersonAccountResponse(result:RequestResult,type:MineStatus){
        let r:DSHttpGetPersonAccountResult = result as! DSHttpGetPersonAccountResult
        if r.isOk() {
            self.getHttpData(r.getAllData(),type:type)
        }
    }
    
    func getHttpData(data:NSMutableArray,type:MineStatus){
        self.httpInfo = data.firstObject as? DSGetPersonAccountInfo
        if type == .MineInvestors_login_authentication_child {
            self.initThirdStatus()
        }else if type == .MineInvestors_login_authentication_father{
            self.initTheSecondStatus()
        }else if type == .MinePark_login_authentication{
            self.parkInfo = self.httpInfo.park
            self.parkPerInfo()
        }
        self.tableView.reloadData()
    }
    
    
    //MARK:-----修改项目方信息 接口
    func httpProjectChangeRequire(){
        let cmd:DSHttpApplyProjectChangeCmd = DSHttpApplyProjectChangeCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpApplyProjectChangeCmd
        let block:httpBlock = {[weak self](result:RequestResult!,useInfo:AnyObject!)->()in
            self!.httpProjectChangeResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_ApplyProjectChange_user_id] = DSAccountInfo.sharedInstance().personId
        dic[kHttpParamKey_ApplyProjectChange_role_name] = DSAccountInfo.sharedInstance().role
        //dic[kHttpParamKey_ApplyProjectChange_projectId] = self.projectID
        dic[kHttpParamKey_ApplyProjectChange_projectId] = DSAccountInfo.sharedInstance().productsId
        //2c928085599631f4015996869072001b
        dic[kHttpParamKey_ApplyProjectChange_applyLogin] = DSAccountInfo.sharedInstance().phoneNum
        
        let projectDic:NSMutableDictionary = NSMutableDictionary()
        
        
        let companyDic:NSMutableDictionary = NSMutableDictionary()
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_myName] = self.productInfo.myName
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_companyName] = self.productInfo.companyName
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_address] = self.productInfo.address
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_homePage] = self.productInfo.homePage
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_weichatPublic] = self.productInfo.wxPublicAccount
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_job] = self.productInfo.position
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_individualMail] = self.productInfo.email
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_weichat] = self.productInfo.wxAccount
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_linkedin] = self.productInfo.linkedIn
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_businessCard] = self.productInfo.cardUrl
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_licenceUrl] = self.productInfo.licenceUrl
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_isOnShow] = self.productInfo.hasShow != "是" ? false:true
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_hasShow] = self.productInfo.hasShow != "是" ? false:true
        projectDic[kHttpParamKey_ApplyProjectChange_project_company] = companyDic
        
        
        let detailDic:NSMutableDictionary = NSMutableDictionary()
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_amount] = self.productInfo.amount
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_ratio] = self.productInfo.ratio
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_brief] = self.productInfo.brief
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_videoUrl] = self.productInfo.videoUrl
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_extractionCode] = self.productInfo.extractionCode
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_downloadLink] = self.productInfo.downloadLink
        
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_needMoreService] = self.productInfo.needMoreService != "1" ? false:true
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_needShow] = self.productInfo.needShow != "1" ? false:true
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_needIncubator] = self.productInfo.needIncubator != "1" ? false:true
        
        detailDic[kHttpParamKey_ApplyProjectChange_project_company_highLight] = self.productInfo.highLight
        detailDic[kHttpParamKey_ApplyProjectChange_project_company_businessMode] = self.productInfo.businessMode
        detailDic[kHttpParamKey_ApplyProjectChange_project_company_market] = self.productInfo.market
        detailDic[kHttpParamKey_ApplyProjectChange_project_company_advantages] = self.productInfo.advantages
        detailDic[kHttpParamKey_ApplyProjectChange_project_company_businessPlan] = self.productInfo.businessPlan
        
        projectDic[kHttpParamKey_ApplyProjectChange_project_detail] = detailDic
        
//        let catsList:NSMutableArray = NSMutableArray()
//        
//        catsList.addObject(self.catDicAppend("所属行业", str2: self.productInfo.industry))
//        catsList.addObject(self.catDicAppend("投资偏好", str2: self.productInfo.preferences))
//        catsList.addObject(self.catDicAppend("融资阶段", str2: self.productInfo.amountPhase))
//        catsList.addObject(self.catDicAppend("所在地区", str2: self.productInfo.Inthearea))
//        catsList.addObject(self.catDicAppend("投资币种", str2: self.productInfo.currency))
//        catsList.addObject(self.catDicAppend("上过节目", str2: self.productInfo.hasShow))
        
        projectDic[kHttpParamKey_ApplyProjectChange_project_type] = "ACCOUNT"
        
        projectDic[kHttpParamKey_ApplyProjectChange_project_cats] = self.genggaiShow()
        
        dic[kHttpParamKey_ApplyProjectChange_project] = projectDic
        
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url == ",cmd.getUrl())
        cmd.execute()
    }
    func genggaiShow()->(NSMutableArray) {
        let array = NSMutableArray()
        var isHasShow = false
        for index in 0..<self.productInfo.categoriesArray.count {
            let dic = self.productInfo.categoriesArray[index] as! NSMutableDictionary
            let name = dic["catName"] as! String
            var description = dic["description"] as! String
            if name == "上过节目" {
                description = self.productInfo.hasShow!
                isHasShow = true
            }
            array .addObject(self.catDicAppend(name, str2: description))
        }
        if isHasShow == false {
            array .addObject(self.catDicAppend("上过节目", str2: self.productInfo.hasShow!))
        }
        return array
    }
    func catDicAppend(str1:String!,str2:String?)->(NSMutableDictionary){
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic["catName"] = str1
        dic["description"] = self.judgeString(str2)
        return dic
    }
    
    func httpProjectChangeResponse(result:RequestResult){
        let r:DSHttpApplyProjectChangeResult = result as! DSHttpApplyProjectChangeResult
        if r.isOk() {
            SMToast("正在审核，需要一个工作日")
            self.navigationController?.popViewControllerAnimated(true)
        }else{
            SMToast("请查看当前网络状态！")
        }
    }
    
    //MARK:-----修改园区页面信息提交接口
    func httpChangeParkPerInfoRequire(){
        let cmd:DSHttpChangeParkPerInfoCmd = DSHttpChangeParkPerInfoCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpChangeParkPerInfoCmd
        let block:httpBlock = {[weak self](result:RequestResult!,useInfo:AnyObject!)->()in
            self?.httpChangeParkPerInfoResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_ChangeParkPerInfo_user_id] = DSAccountInfo.sharedInstance().personId
        dic[kHttpParamKey_ChangeParkPerInfo_parkName] = self.parkInfo.parkName
        dic[kHttpParamKey_ChangeParkPerInfo_parkLogo] = self.httpInfo.park?.parkLogo
        dic[kHttpParamKey_ChangeParkPerInfo_licence] = self.httpInfo.park?.licence
        dic[kHttpParamKey_ChangeParkPerInfo_officeRent] = self.httpInfo.park?.officeRent != "0" ? true:false
        dic[kHttpParamKey_ChangeParkPerInfo_investService] = self.httpInfo.park?.investService != "0" ? true:false
        
        dic[kHttpParamKey_ChangeParkPerInfo_address] = self.httpInfo.park?.address
        dic[kHttpParamKey_ChangeParkPerInfo_introducePic] = self.httpInfo.park?.introducePic
        dic[kHttpParamKey_ChangeParkPerInfo_introductionText] = self.httpInfo.park?.introductionText
        dic[kHttpParamKey_ChangeParkPerInfo_incubationCase] = self.httpInfo.park?.incubationCase
        dic[kHttpParamKey_ChangeParkPerInfo_joinCondition] = self.httpInfo.park?.joinCondition
        dic[kHttpParamKey_ChangeParkPerInfo_briefIntroduction] = self.httpInfo.park?.briefIntroduction
        dic[kHttpParamKey_ChangeParkPerInfo_vedioUrl] = self.httpInfo.park?.vedioUrl
        dic[kHttpParamKey_ChangeParkPerInfo_vedioTitle] = self.httpInfo.park?.vedioTitle
        dic[kHttpParamKey_ChangeParkPerInfo_vedioImg] = self.httpInfo.park?.vedioImg
        dic[kHttpParamKey_ChangeParkPerInfo_name] = self.parkInfo.name
        dic[kHttpParamKey_ChangeParkPerInfo_job] = self.parkInfo.job
        dic[kHttpParamKey_ChangeParkPerInfo_phone] = self.parkInfo.phone
        dic[kHttpParamKey_ChangeParkPerInfo_wechat] = self.parkInfo.wechat
        dic[kHttpParamKey_ChangeParkPerInfo_email] = self.parkInfo.email
        dic[kHttpParamKey_ChangeParkPerInfo_linkdin] = self.parkInfo.linkdin
        dic[kHttpParamKey_ChangeParkPerInfo_card] = self.parkInfo.card
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url == ",cmd.getUrl())
        cmd.execute()
    }
    func httpChangeParkPerInfoResponse(result:RequestResult){
        let r:DSHttpChangeParkPerInfoResult = result as! DSHttpChangeParkPerInfoResult
        if r.isOk() {
            SMToast("保存成功！")
            self.navigationController?.popViewControllerAnimated(true)
        }else{
            SMToast("请查看当前网络状态！")
        }
    }
    
    //MARK:-----修改个人投资页面信息提交接口
    func httpPersonInvesAccountChangeRequire(){
        let cmd:DSHttpApplyAccountChangeCmd = DSHttpApplyAccountChangeCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpApplyAccountChangeCmd
        let block:httpBlock = {[weak self](result:RequestResult!,useInfo:AnyObject!)->()in
            self?.httpAccountChangeResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_ApplyAccountChange_user_id] = DSAccountInfo.sharedInstance().personId
        dic[kHttpParamKey_ApplyAccountChange_role_name] = DSAccountInfo.sharedInstance().role
        dic[kHttpParamKey_ApplyAccountChange_applyLogin] = DSAccountInfo.sharedInstance().phoneNum
        let tionDic:NSMutableDictionary = NSMutableDictionary()
        tionDic[kHttpParamKey_ApplyAccountChange_institution_id] = DSAccountInfo.sharedInstance().personId
        tionDic[kHttpParamKey_ApplyAccountChange_institution_name] = self.httpInfo.name
        tionDic[kHttpParamKey_ApplyAccountChange_institution_idCardFrontUrl] = self.httpInfo.individual?.cardNoFront
        tionDic[kHttpParamKey_ApplyAccountChange_institution_idCardBackUrl] = self.httpInfo.individual?.cardNoBack
        tionDic[kHttpParamKey_ApplyAccountChange_institution_individualPropertyUrl] = self.httpInfo.individual?.personalAssetsCertificate
        tionDic[kHttpParamKey_ApplyAccountChange_institution_card_no] = self.httpInfo.individual?.cardNo
        tionDic[kHttpParamKey_ApplyAccountChange_institution_investMin] = self.httpInfo.individual?.investMin
        tionDic[kHttpParamKey_ApplyAccountChange_institution_investMax] = self.httpInfo.individual?.investMax
        tionDic[kHttpParamKey_ApplyAccountChange_institution_introduction] = self.httpInfo.individual?.introduction
        tionDic[kHttpParamKey_ApplyAccountChange_institution_wechat] = self.httpInfo.individual?.wechat
        tionDic[kHttpParamKey_ApplyAccountChange_institution_avatar] = self.httpInfo.avatar
        tionDic[kHttpParamKey_ApplyAccountChange_institution_cases] = self.httpInfo.individual?.cases
        tionDic[kHttpParamKey_ApplyAccountChange_institution_linkedin] = self.httpInfo.individual?.linkedIn
        tionDic[kHttpParamKey_ApplyAccountChange_individual_videoUrl] = self.httpInfo.individual?.videoUrl
        tionDic[kHttpParamKey_ApplyAccountChange_individual_videoTitle] = self.httpInfo.individual?.videoTitle
        tionDic[kHttpParamKey_ApplyAccountChange_individual_videoImage] = self.httpInfo.individual?.videoImage
        
        self.componentStringToList("关注领域", value: self.followArea!)
        self.componentStringToList("主投币种", value: self.mainMoney!)
        self.componentStringToList("投资阶段", value: self.InvestmentStage!)
        self.componentStringToList("投资地域", value: self.investArea!)
        
        tionDic[kHttpParamKey_ApplyAccountChange_institution_cats] = self.personChangeCats
        dic[kHttpParamKey_ApplyAccountChange_institution] = tionDic
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url == ",cmd.getUrl())
        cmd.execute()
    }
    
    //MARK:---拆分字符串 合并数组
    func componentStringToList(title:String,value:String){
        let list:NSArray = value.componentsSeparatedByString(",")
        for index in 0..<list.count {
            self.personChangeCats.addObject(self.catDicAppend(title, str2: list[index] as? String))
        }
    }
    
    
    func httpAccountChangeResponse(result:RequestResult){
        let r:DSHttpApplyAccountChangeResult = result as! DSHttpApplyAccountChangeResult
        if r.isOk() {
            SMToast("正在审核，需要一个工作日")
            self.navigationController?.popViewControllerAnimated(true)
        }else{
            SMToast("请查看当前网络状态！")
        }
    }
    
    func showAttention(){
        
        if self.status == .MinePark_login_authentication {
            self.httpChangeParkPerInfoRequire()
        }else if self.status == .MineInvestors_login_authentication_child{
           self.httpInvesChildAccountChangeRequire()
        }else{
            showAlert("修改个人信息需要重新审核，\n您确定要修改吗？", message: "", titleCancelBtn: "取消", titleSecondBtn: "确定", blockOtherBtn: {
                self.chooseStatusSaveMessage()
            })
        }
    }
    
    func chooseStatusSaveMessage(){
        switch self.status {
        case .MineInvestors_login_unauthentication:
            break
        case .MineInvestors_login_authentication_father:    //已认证个人投资方
            self.httpPersonInvesAccountChangeRequire()
            break
        case .MineProject_login_authentication:     //已认证项目方
            self.httpProjectChangeRequire()
            break
        default:
            break
        }
    }

    //MARK:-------保存投资机构下子账号页面信息提交接口
    func httpInvesChildAccountChangeRequire(){
        
        let cmd:DSHttpInstitutionsPutCmd = DSHttpInstitutionsPutCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpInstitutionsPutCmd
        let block:httpBlock = {[weak self](result:RequestResult!,useInfo:AnyObject!)->()in
            self?.httpInvesChildAccountChangeResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_InstitutionsPut_institutionId] = self.httpInfo.id
        dic[kHttpParamKey_InstitutionsPut_id] = self.httpInfo.id
        dic[kHttpParamKey_InstitutionsPut_role_name] = DSAccountInfo.sharedInstance().role
        dic[kHttpParamKey_InstitutionsPut_institutioners] = self.httpInfo.institutioner?.institution?.institutioners
        
        dic[kHttpParamKey_InstitutionsPut_login] = DSAccountInfo.sharedInstance().phoneNum
        dic[kHttpParamKey_InstitutionsPut_investMin] = self.httpInfo.institutioner?.investorMin
        dic[kHttpParamKey_InstitutionsPut_investMax] = self.httpInfo.institutioner?.investorMax
        dic[kHttpParamKey_InstitutionsPut_name] = self.httpInfo.institutioner?.name
        dic[kHttpParamKey_InstitutionsPut_title] = self.httpInfo?.institutioner?.title
        dic[kHttpParamKey_InstitutionsPut_job] = self.httpInfo?.institutioner?.title
        dic[kHttpParamKey_InstitutionsPut_phone] = self.httpInfo?.institutioner?.phone
        dic[kHttpParamKey_InstitutionsPut_address] = self.httpInfo.institutioner?.institution?.address
        dic[kHttpParamKey_InstitutionsPut_company] = self.httpInfo.institutioner?.institution?.company
        dic[kHttpParamKey_InstitutionsPut_cardUrl] = self.httpInfo?.institutioner?.cardUrl
        dic[kHttpParamKey_InstitutionsPut_mail] = self.httpInfo?.institutioner?.mail
        dic[kHttpParamKey_InstitutionsPut_weichat] = self.httpInfo?.institutioner?.weichat
        dic[kHttpParamKey_InstitutionsPut_linkedin] = self.httpInfo?.institutioner?.linkin
        
        self.componentStringToList("关注领域", value: self.followArea!)
        self.componentStringToList("投资阶段", value: self.InvestmentStage!)
        self.componentStringToList("投资地域", value: self.investArea!)
        self.componentStringToList("主投币种", value: self.mainMoney!)
        
        dic[kHttpParamKey_InstitutionsPut_cats] = self.personChangeCats
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpInvesChildAccountChangeResponse(result:RequestResult){
        let r:DSHttpInstitutionsPutResult = result as! DSHttpInstitutionsPutResult
        if r.isOk() {
            SMToast("保存成功！")
            self.navigationController?.popViewControllerAnimated(true)
        }else{
            SMToast("请查看当前网络状态！")
        }
    }
    
    
    //MARK:-----图片上传接口
    func httpMyInfoUploadFileRequire(image:UIImage,type:InfoImageType){
        let cmd:DSHttpUploadFileCmd = DSHttpUploadFileCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpUploadFileCmd
        let block:httpBlock = {[weak self](result:RequestResult!,useInfo:AnyObject!)->()in
            self?.httpMyInfoUploadFileResponse(result,type:type)
        }
        cmd.fileName = "image.jpg"
        cmd.keyName = "file"
        cmd.fileData = UIImagePNGRepresentation(image)
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpMyInfoUploadFileResponse(result:RequestResult,type:InfoImageType){
        let r:DSHttpUploadFileResult = result as! DSHttpUploadFileResult
        if r.isOk() {
            switch type {
            case .AVATAR:
                self.avatarValue = r.getUuid().stringByAppendingFormat("."+r.getSuffix())
                self.httpInfo!.avatar = self.avatarValue
                break
            case .BUSINESSCARD:
                self.businessCardValue = r.getUuid().stringByAppendingFormat("."+r.getSuffix())
                //self.productInfo.cardUrl = String()
                self.productInfo.cardUrl = self.businessCardValue
                break
            case .LICENSE:
                self.licenseValue = r.getUuid().stringByAppendingFormat("."+r.getSuffix())
                self.productInfo.licenceUrl = self.licenseValue
                break
            case .BUSINESSCARD2:
                self.businessCardValue = r.getUuid().stringByAppendingFormat("."+r.getSuffix())
                self.parkInfo.card = self.businessCardValue
                break
            case .BUSINESSCARD3:
                self.businessCardValue = r.getUuid().stringByAppendingFormat("."+r.getSuffix())
                self.httpInfo.institutioner?.cardUrl = self.businessCardValue
                break
            }
        }
    }
    
}

