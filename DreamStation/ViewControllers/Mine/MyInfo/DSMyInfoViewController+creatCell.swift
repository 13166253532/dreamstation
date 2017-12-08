//
//  DSMyInfoViewController+creatCell.swift
//  DreamStation
//
//  Created by QPP on 16/8/10.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

extension DSMyInfoViewController {
    
    func normalInfo(title:String,subTitle:String?,canEdit:Bool,block:passParameterBlock)->DSAgencyFirstCellModel{
        let firstXinfo:DSAgencyFirstCellModel = DSAgencyFirstCellModel()
        firstXinfo.className = "DSAgencyFirstCell"
        firstXinfo.titleValue = title
        firstXinfo.detailValue=subTitle
        firstXinfo.placeholderValue = "请输入"
        firstXinfo.isHidden = true
        firstXinfo.isCanEdit = canEdit
        firstXinfo.block = {(value:AnyObject?)in
            firstXinfo.detailValue = value as? String
            self.normalBlock = block
            self.normalBlock(value!)
        }
        return firstXinfo
    }


    func isShowInfo(title:String,isAn:Bool,hidden:Bool,block:passParameterBlock)->DSProjectEighthCellModel{
        let info:DSProjectEighthCellModel = DSProjectEighthCellModel()
        info.className = "DSProjectEighthCell"
        info.titleValue = title
        info.isAn = isAn
        info.isHidden = hidden
        info.block = block
        return info
    }
    
    //投资额度
    func investmentAmounts(min:String,max:String)->DSAgencySixthCellModel{
        let xinfo:DSAgencySixthCellModel = DSAgencySixthCellModel()
        xinfo.className = "DSAgencySixthCell"
        xinfo.firstValue = min
        xinfo.secondValue = max
        xinfo.isHidden = true
        xinfo.block = {[weak self]in
            let pick:CCPPickerViewTwo = CCPPickerViewTwo.init(pickerViewWithCenterTitle: "单笔可投额度（万）", andCancel: "取消", andSure: "确定")
            
            pick .pickerVIewClickCancelBtnBlock({
                
                }, sureBtClcik: {[weak self] (firstString, secondString, statusString) in
                    xinfo.firstValue = firstString
                    xinfo.secondValue = secondString
                    self!.httpInfo!.individual!.investMin = firstString
                    self!.httpInfo!.individual!.investMax = secondString
                    self?.maxValue = secondString
                    self!.tableView.reloadData()
            })
        }
        return xinfo
    }
    
    func institutionerAmounts(min:String,max:String)->DSAgencySixthCellModel{
        let xinfo:DSAgencySixthCellModel = DSAgencySixthCellModel()
        xinfo.className = "DSAgencySixthCell"
        xinfo.firstValue = min
        xinfo.secondValue = max
        xinfo.isHidden = true
        xinfo.block = {[weak self]in
            let pick:CCPPickerViewTwo = CCPPickerViewTwo.init(pickerViewWithCenterTitle: "单笔可投额度（万）", andCancel: "取消", andSure: "确定")
            
            pick .pickerVIewClickCancelBtnBlock({
                
                }, sureBtClcik: {[weak self] (firstString, secondString, statusString) in
                    xinfo.firstValue = firstString
                    xinfo.secondValue = secondString
                    self!.httpInfo.institutioner?.investorMin = firstString
                    self?.httpInfo.institutioner?.investorMax = secondString
                    self?.maxValue = secondString
                    self!.tableView.reloadData()
                })
        }
        return xinfo
    }
    func cardInfo(title:String,image:String?,block:passParameterBlock)->DSAgencySeventhCellModel{
        let xinfo:DSAgencySeventhCellModel = DSAgencySeventhCellModel()
        xinfo.className = "DSAgencySeventhCell"
        xinfo.titleValue = title
        xinfo.imageUrl = image
        xinfo.isHidden = true
        xinfo.isHiddenArrow=false
        xinfo.block = {
            self.addImageAction()
            self.imageBlock = {[weak self](value:AnyObject)in
                xinfo.backImage = value as! UIImage
                self!.cardImageBlock = block
                self!.cardImageBlock(xinfo.backImage)
                self!.tableView.reloadData()
            }
        }
        return xinfo
    }
    
    func headImage(url:String?)->DSAgencySecondCellModel{
        let secondXinfo:DSAgencySecondCellModel = DSAgencySecondCellModel()
        secondXinfo.className = "DSAgencySecondCell"
        secondXinfo.titleValue = "头像"
        secondXinfo.detailValue = "Agency_logo"
        secondXinfo.imageUrl=url
        secondXinfo.isHidden = true
        secondXinfo.block = {[weak self]in
            self?.addImageAction()
            self?.imageBlock = {(value:AnyObject)in
                secondXinfo.backImage = value as! UIImage
                self?.httpMyInfoUploadFileRequire(value as! UIImage,type:.AVATAR)
                self?.tableView.reloadData()
            }
        }
        return secondXinfo
    }


    func selectInfo(title:String,subTitle:String,arrayData:NSArray,cellType:Int32)->DSAgencyThirdCellModel{
        let xinfo:DSAgencyThirdCellModel = DSAgencyThirdCellModel()
        xinfo.className = "DSAgencyThirdCell"
        xinfo.titleValue = title
        xinfo.placdholder = "请选择"
        xinfo.detailValue = subTitle
        xinfo.isHidden = true
        xinfo.block = {[weak self] in
            let retList:NSArray = self!.takeDescription(title)
            self?.inCollectionView(title, arrayData: arrayData, type: cellType,selectedList:retList)
            self?.passBlock = {[weak self](value:AnyObject) in
               
                for index in 0..<self!.catList.count {
                    let info:DSGetPersonAccountCatsInfo = self!.catList[index] as! DSGetPersonAccountCatsInfo
                    if title == info.catName {
                        self?.removeIndex = String(index)
                    }else{
                        let info:DSGetPersonAccountCatsInfo = DSGetPersonAccountCatsInfo()
                        info.catName = title
                        info.descriptions = value as? String
                        self!.catList.addObject(info)
                    }
                }
                if self?.removeIndex != nil {
                    self?.catList.removeObjectAtIndex(Int((self?.removeIndex)!)!)
                    self?.removeIndex = nil
                }
                xinfo.detailValue = value as! String
                self!.httpInfo!.individual!.cats = self!.catList
                
                if value as! String == "" {
                    xinfo.detailValue = nil
                }
                self!.tableView.reloadData()
            }
        }
        return xinfo
    }

    //MARK:--- 取description数据
    func takeDescription(title:String)->NSArray{
        var list:NSArray = NSArray()
        if title == "关注领域" {
            let value:String = self.trimmingString(self.followArea)
            list = value.componentsSeparatedByString(",")
        }
        if title == "投资阶段" {
            let value:String = self.trimmingString(self.InvestmentStage)
            list = value.componentsSeparatedByString(",")
        }
        if title == "投资地域" {
            let value:String = self.trimmingString(self.investArea)
            list = value.componentsSeparatedByString(",")
        }
        if title == "主投币种" {
            let value:String = self.trimmingString(self.mainMoney)
            list = value.componentsSeparatedByString(",")
        }
        return list
    }
    
    func trimmingString(value:String?)->String{
        var resultStr:String = ""
        if value != nil{
            resultStr = value!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            return resultStr
        }
        return resultStr
    }
    
    
    //MARK:加载collectionViewCell
    func inCollectionView(title:String,arrayData:NSArray,type:Int32,selectedList:NSArray){
        
        let collect:XSCollectionView = XSCollectionView.init(collectionViewWithCenterTitle: title, andCancel: "取消", andSure: "确定", andData: arrayData as [AnyObject], andType: type, andSelectedList:selectedList as [AnyObject])
        collect.collectionViewClickCancelBtnBlock({
            
        }) {[weak self] (chooseList) in
            let choose:NSArray = chooseList as NSArray
            if choose.count != 0{
                var allString:String = choose.firstObject as! String
                for index in 0..<choose.count-1{
                    let str:String = choose.objectAtIndex(index+1) as! String
                    allString = allString.stringByAppendingFormat(","+str)
                }
                if allString != ""{
                    self?.inSaveData(type, value:allString)
                    self!.passBlock(allString)
                }
            }else{
                self?.inSaveData(type, value: "")
                self?.passBlock("")
            }
        }
    }
    
    func inSaveData(cellType:Int32,value:String){
        
        switch cellType {
        case 0:
            self.followArea = value
            break
        case 1:
            self.InvestmentStage = value
            break
        case 2:
            self.investArea = value
            break
        case 3:
            self.mainMoney = value
            break
        default:break
        }
    }


    func textInfo(title:String,content:String,block:passParameterBlock)->DSAgencyFourthCellModel{
        let xinfo:DSAgencyFourthCellModel = DSAgencyFourthCellModel()
        xinfo.className = "DSAgencyFourthCell"
        xinfo.titleValue = title
        xinfo.content = content
        xinfo.block = block
        return xinfo
    }
    
    //MARK:-----------关注领域等部分
    func selectArrInit(type:MineStatus)->NSMutableArray{
        let arr3=NSMutableArray()
        
        //获取用户信息
        if type == .MineInvestors_login_authentication_father {
            self.catList = self.httpInfo!.individual!.cats!
        }else{
            self.catList = self.httpInfo!.institutioner!.cats!
        }
        
        self.followArea = ""
        self.InvestmentStage = ""
        self.investArea = ""
        self.mainMoney = ""
        for index in 0..<self.catList.count {
            let info:DSGetPersonAccountCatsInfo = self.catList.objectAtIndex(index) as! DSGetPersonAccountCatsInfo
            if info.catName == "关注领域" {
                self.followArea = self.appendString(self.followArea, str2: info.descriptions!)
            }else if info.catName == "投资阶段"{
                self.InvestmentStage = self.appendString(self.InvestmentStage, str2: info.descriptions!)
            }else if info.catName == "投资地域"{
                self.investArea = self.appendString(self.investArea, str2: info.descriptions)
            }else if info.catName == "主投币种"{
                self.mainMoney = info.descriptions
            }
        }
        
        let list31:NSArray = self.inPlistData("DSInvestmentAgencyFirst.plist")
        let info31=selectInfo("关注领域", subTitle: self.judgeString(self.followArea) ,arrayData:list31,cellType:0)
        arr3.addObject(info31)
        
        let list32:NSArray = self.inPlistData("DSInvestmentAgencySecond.plist")
        let info32=selectInfo("投资阶段", subTitle:self.judgeString(self.InvestmentStage),arrayData: list32,cellType:1)
        arr3.addObject(info32)
        
        let list33:NSArray = self.inPlistData("DSInvestmentAgencyThird.plist")
        let info33=selectInfo("投资地域", subTitle:self.judgeString(self.investArea),arrayData: list33,cellType: 2)
        arr3.addObject(info33)
        
        let list34:NSArray = self.inPlistData("DSInvestmentAgencyFourth.plist")
        let info34=selectInfo("主投币种", subTitle:self.mainMoney!,arrayData: list34,cellType: 3)
        arr3.addObject(info34)

        return arr3
    }
    
    func appendString(str1:String!,str2:String!)->(String){
        if str1 == "" {
            return str2
        }else{
           return str1.stringByAppendingFormat(","+str2!)
        }
    }
    
    func judgeString(str:String?)->(String!){
        if str != nil {
            return str
        }
         return ""
    }
    
    func judgeString2(str1:String!,str2:String?)->(String){
        if str2 != nil {
            return str1.stringByAppendingFormat("/resource/view/"+str2!)
        }else{
            return str1
        }
    }
    
    
    func inPlistData(plistString:String)->(NSArray){
        let string:String = NSBundle.mainBundle().pathForResource(plistString, ofType: nil)!
        let plistArray:NSArray = NSArray.init(contentsOfFile: string)!
        return plistArray
    }
    
    
    //MARK:--初始化cell
    func initTheFirstStatus(){
        let arr=NSMutableArray()

        let info=normalInfo("手机账号", subTitle: DSAccountInfo.sharedInstance().phoneNum, canEdit: false) { (value:AnyObject) in
            print(value as! String)
        }
        arr.addObject(info)
        self.dataSource.addObject(arr)
    }
    
    //MARK:-----个人投资者
    func initTheSecondStatus(){
        
        let arr=NSMutableArray()

        let info = headImage(self.judgeString2(HTHttpConfig.sharedInstance().getServerAddress(""), str2: DSAccountInfo.sharedInstance().avatar))
  
        arr.addObject(info)
        
        let info1=normalInfo("姓名", subTitle:self.judgeString(self.httpInfo?.name), canEdit: true) {[weak self] (value:AnyObject) in
            print(value as! String)
            self!.httpInfo!.name = value as? String
        }
        arr.addObject(info1)
        
        let info2=normalInfo("手机账号", subTitle: self.httpInfo!.login, canEdit: false) { (value:AnyObject) in
            print(value as! String)
        }
        arr.addObject(info2)
        
        
        let arr2=NSMutableArray()
        let info23=normalInfo("微信(推荐)", subTitle: self.httpInfo!.individual!.wechat, canEdit: true) {[weak self] (value:AnyObject) in
            print(value as! String)
            self!.httpInfo!.individual!.wechat = value as? String
        }
        arr2.addObject(info23)
        
        let info24=normalInfo("LinkedIn(推荐)", subTitle: self.httpInfo!.individual!.linkedIn, canEdit: true) {[weak self] (value:AnyObject) in
            print(value as! String)
            self!.httpInfo!.individual!.linkedIn = value as? String
        }
        arr2.addObject(info24)
 
        let arr3=self.selectArrInit(.MineInvestors_login_authentication_father)
        let xinfo26=investmentAmounts(self.judgeString(self.httpInfo?.individual?.investMin), max: self.judgeString(self.httpInfo?.individual?.investMax))
        arr3.addObject(xinfo26)
    
        let arr4=NSMutableArray()
        let info41=textInfo("简介", content:self.judgeString(self.httpInfo?.individual?.introduction)) {[weak self](value:AnyObject)->() in
            self!.httpInfo!.individual!.introduction = value as? String
        }
        arr4.addObject(info41)
        
        let arr5=NSMutableArray()
        let info51=textInfo("过往案例", content:self.judgeString(self.httpInfo?.individual?.cases)){[weak self](value:AnyObject)->() in
            self!.httpInfo!.individual!.cases = value as? String
        }
        arr5.addObject(info51)
   
        self.dataSource.addObject(arr)
        self.dataSource.addObject(arr2)
        self.dataSource.addObject(arr3)
        self.dataSource.addObject(arr4)
        self.dataSource.addObject(arr5)
    }

    //MARK:-------投资机构下的子账户
    func initThirdStatus(){
     
        let arr=NSMutableArray()
        let info1=normalInfo("姓名", subTitle: self.httpInfo.institutioner?.name, canEdit: true) {[weak self] (value:AnyObject) in
            print(value as! String)
            self!.httpInfo.institutioner?.name = value as? String
        }
        arr.addObject(info1)
        
        let info2=normalInfo("账号名称", subTitle: self.httpInfo?.login, canEdit: false){ (value:AnyObject) in
            print(value as! String)
        }

        arr.addObject(info2)
        
        let info3=normalInfo("投资机构", subTitle: self.httpInfo?.institutioner?.institution?.company, canEdit: false){ (value:AnyObject) in
            print(value as! String)
            
        }

        arr.addObject(info3)
        
        let info4=normalInfo("职务", subTitle: self.httpInfo?.institutioner?.title, canEdit: true){[weak self] (value:AnyObject) in
            print(value as! String)
            self!.httpInfo?.institutioner?.title = value as? String
        }

        arr.addObject(info4)
        
        let arr2=NSMutableArray()
        let info21=normalInfo("手机号码", subTitle: self.httpInfo?.institutioner?.phone, canEdit: true){[weak self] (value:AnyObject) in
            print(value as! String)
            self!.httpInfo?.institutioner?.phone = value as? String
        }

        arr2.addObject(info21)
        
        let info22=normalInfo("邮箱", subTitle: self.httpInfo?.institutioner?.mail, canEdit: true){[weak self] (value:AnyObject) in
            print(value as! String)
            self!.httpInfo?.institutioner?.mail = value as? String
        }

        arr2.addObject(info22)
        
        let info23=normalInfo("微信(推荐)", subTitle:self.httpInfo?.institutioner?.weichat, canEdit: true){[weak self] (value:AnyObject) in
            print(value as! String)
            self!.httpInfo?.institutioner?.weichat = value as? String
        }
        arr2.addObject(info23)
        
        let info24=normalInfo("LinkedIn(推荐)", subTitle: self.httpInfo?.institutioner?.linkin, canEdit: true){[weak self] (value:AnyObject) in
            print(value as! String)
            self!.httpInfo?.institutioner?.linkin = value as? String
        }
        arr2.addObject(info24)
        
        let imageUrl:String = self.judgeString2(HTHttpConfig.sharedInstance().getServerAddress(""), str2: self.httpInfo?.institutioner?.cardUrl)
        let info25=cardInfo("名片", image: imageUrl){[weak self](value:AnyObject)in
            self!.httpMyInfoUploadFileRequire(value as! UIImage,type:.BUSINESSCARD3)
        }
        arr2.addObject(info25)
        
        let arr3=self.selectArrInit(.MineInvestors_login_authentication_child)
        
        let xinfo26=institutionerAmounts(self.judgeString(self.httpInfo?.institutioner?.investorMin), max: self.judgeString(self.httpInfo?.institutioner?.investorMax))
        arr3.addObject(xinfo26)
        
        self.dataSource.addObject(arr)
        self.dataSource.addObject(arr2)
        self.dataSource.addObject(arr3)
    }
    
    
    //MARK:-------项目方
    func initFiveStatus(){
        let arr=NSMutableArray()
        let info1=normalInfo("姓名", subTitle: self.productInfo.myName, canEdit: true){ (value:AnyObject) in
            self.productInfo.myName = value as? String
        }
        arr.addObject(info1)
        
        let info2=normalInfo("手机账号", subTitle: DSAccountInfo.sharedInstance().phoneNum, canEdit: false){ (value:AnyObject) in
        }
        arr.addObject(info2)
        
        let arr2=NSMutableArray()
        let info21=normalInfo("公司名", subTitle:self.productInfo.companyName, canEdit: true){[weak self] (value:AnyObject) in
            self!.productInfo.companyName = value as? String
        }
        arr2.addObject(info21)
        
        let info22=normalInfo("办公地址", subTitle: self.productInfo.address, canEdit: true){[weak self] (value:AnyObject) in
            self!.productInfo.address = value as? String
        }
        arr2.addObject(info22)
        
        let info23=normalInfo("官网", subTitle: self.productInfo.homePage, canEdit: true){[weak self] (value:AnyObject) in
            self!.productInfo.homePage = value as? String
            
        }
        arr2.addObject(info23)
        
        let info24=normalInfo("微信公众号", subTitle: self.productInfo.wxPublicAccount, canEdit: true){[weak self] (value:AnyObject) in
            self!.productInfo.wxPublicAccount = value as? String
        }
        arr2.addObject(info24)
        
        let info25=normalInfo("职务", subTitle: self.productInfo.position, canEdit: true){[weak self] (value:AnyObject) in
            self!.productInfo.position = value as? String
        }
        arr2.addObject(info25)
        
        let info26=normalInfo("个人邮箱", subTitle: self.productInfo.email, canEdit: true){[weak self] (value:AnyObject) in
            self!.productInfo.email = value as? String
        }
        arr2.addObject(info26)
        
        let info27=normalInfo("微信(推荐)", subTitle: self.productInfo.wxAccount, canEdit: true){[weak self] (value:AnyObject) in
            self!.productInfo.wxAccount = value as? String
        }
        arr2.addObject(info27)
        
        let info28=normalInfo("LinkedIn(推荐)", subTitle: self.productInfo.linkedIn, canEdit: true){[weak self] (value:AnyObject) in
            self!.productInfo.linkedIn = value as? String
        }
        arr2.addObject(info28)

        let info29=cardInfo("名片", image:self.judgeString2(HTHttpConfig.sharedInstance().getServerAddress(""), str2: self.productInfo.cardUrl)) { [weak self](value:AnyObject)in
            self!.httpMyInfoUploadFileRequire(value as! UIImage,type:.BUSINESSCARD)
        }
        arr2.addObject(info29)
        
        let info210=cardInfo("营业执照或三证合一", image:self.judgeString2(HTHttpConfig.sharedInstance().getServerAddress(""), str2: self.productInfo.licenceUrl)){[weak self](value:AnyObject)in
            self!.httpMyInfoUploadFileRequire(value as! UIImage,type:.LICENSE)
        }
        arr2.addObject(info210)
        
        let arr3=NSMutableArray()
        if self.productInfo.hasShow == "是" {
            self.didShow = true
        }else{
            self.didShow = false
        }
//        let info31=normalInfo("是否上过梦想下一站节目", subTitle: self.productInfo.needShow, canEdit: true){[weak self] (value:AnyObject) in
//            print(value as! String)
//            self!.productInfo.needShow = value as? String
//        }
        let info31=isShowInfo("是否上过极客出发", isAn: self.didShow!, hidden: true) {(value:AnyObject) in
            self.didShow = value as? Bool
            if self.didShow != true{
                self.productInfo.hasShow = "否"
            }else{
                self.productInfo.hasShow = "是"
            }
        }
        arr2.addObject(info31)
        
        self.dataSource.addObject(arr)
        self.dataSource.addObject(arr2)
        self.dataSource.addObject(arr3)
    }
    
    //MARK:-------园区方个人信息
    func parkPerInfo(){
        let arr=NSMutableArray()
        let info1=normalInfo("姓名", subTitle: self.httpInfo?.park?.name, canEdit: true) {[weak self] (value:AnyObject) in
            print(value as! String)
            self?.parkInfo.name = value as? String
        }
        arr.addObject(info1)
        let info2=normalInfo("账号名称", subTitle: DSAccountInfo.sharedInstance().phoneNum, canEdit: false) {[weak self] (value:AnyObject) in
            print(value as! String)
            self?.parkInfo.name = value as? String
        }
        arr.addObject(info2)
        let info3=normalInfo("园区名", subTitle: self.httpInfo?.park?.parkName, canEdit: false) {[weak self] (value:AnyObject) in
            print(value as! String)
            self?.parkInfo.parkName = value as? String
        }
        arr.addObject(info3)
        let info4=normalInfo("公司名", subTitle: self.httpInfo?.park?.parkName, canEdit: false) {[weak self] (value:AnyObject) in
            print(value as! String)
            self!.httpInfo?.park?.parkName = value as? String
        }
        arr.addObject(info4)
        let info5=normalInfo("职务", subTitle: self.httpInfo?.park?.job, canEdit: true) {[weak self] (value:AnyObject) in
            print(value as! String)
           self?.parkInfo.job = value as? String
        }
        arr.addObject(info5)
        
        let arr2=NSMutableArray()
        
        let info6=normalInfo("手机号码", subTitle: self.httpInfo?.park?.phone, canEdit: true) {[weak self] (value:AnyObject) in
            print(value as! String)
           self?.parkInfo.phone = value as? String
        }
        arr2.addObject(info6)
        let info7=normalInfo("邮箱", subTitle: self.httpInfo?.park?.email, canEdit: true) {[weak self] (value:AnyObject) in
            print(value as! String)
            self?.parkInfo.email = value as? String
        }
        arr2.addObject(info7)
        let info8=normalInfo("微信（推荐）", subTitle: self.httpInfo?.park?.wechat, canEdit: true) {[weak self] (value:AnyObject) in
            print(value as! String)
            self?.parkInfo.wechat = value as? String
        }
        arr2.addObject(info8)
        let info9=normalInfo("LikedIn（推荐）", subTitle: self.httpInfo?.park?.linkdin, canEdit: true) {[weak self] (value:AnyObject) in
            print(value as! String)
           self?.parkInfo.linkdin = value as? String
        }
        arr2.addObject(info9)
        let info29=cardInfo("名片", image:self.judgeString2(HTHttpConfig.sharedInstance().getServerAddress(""), str2: self.httpInfo?.park?.card)) { [weak self](value:AnyObject)in
            self!.httpMyInfoUploadFileRequire(value as! UIImage,type:.BUSINESSCARD2)
        }

        arr2.addObject(info29)
        
        
        self.dataSource.addObject(arr)
        self.dataSource.addObject(arr2)
        
    }
    
    
    
    //MARK:添加图片
    func addImageAction(){
        
        let actions:UIAlertController=UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let action1:UIAlertAction=UIAlertAction(title: "相册", style: UIAlertActionStyle.Default) { (action) in
            self.picker.showLocalPhotoWithController(self, block: { (value:AnyObject?) in
                self.imageBlock(value!)
            })
        }
        
        let action2:UIAlertAction=UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default) { (action) in
            self.picker.showTakePhotoWithController(self, block: { (value:AnyObject?) in
                self.imageBlock(value!)
            })
        }
        
        let action:UIAlertAction=UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (action) in}
        actions.addAction(action1)
        actions.addAction(action2)
        actions.addAction(action)
        AppRootViewController()!.presentViewController(actions, animated: true, completion: nil)
        
    }

}
