//
//  DSMineViewController+CreateCell.swift
//  DreamStation
//
//  Created by QPP on 16/7/28.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

private let STRING_MINE = "DSMineStrings"

extension DSMineViewController {

    //MARK:- 未认证
    func gotoMyInfo(status:MineStatus){
        
        let vc=DSMyInfoViewController.createViewController(nil) as! DSMyInfoViewController
        vc.status = status
        vc.hidesBottomBarWhenPushed=true
        self.pushViewController(vc, animated: true)
    }
    
    func initUnauthenticationHead(){
        let arr = NSMutableArray()
        self.initTheHead(arr, subTitle: loadString("MinePleaseAuthentication", tableId: STRING_MINE)) { [weak self]in
            self!.gotoMyInfo(self!.status)
        }
        
        self.dataSource.addObject(arr)
    }
    //MARK:- 已认证
    func initAuthenticationHead(hideImage:Bool,subTitle:String){
        let arr = NSMutableArray()
        let headImageValue:String = self.judgeString(HTHttpConfig.sharedInstance().getServerAddress(""), str2: DSAccountInfo.sharedInstance().avatar)
        self.initImageHead(arr, cell: "DSMineHeadOKCell", name: DSAccountInfo.sharedInstance().name, subTitle:subTitle, Headimage:headImageValue,headImage:hideImage) {
            [weak self]in
            self!.gotoMyInfo(self!.status)
        }
        self.dataSource.addObject(arr)
    }
    
    func judgeString(str1:String!,str2:String?)->(String!){
        if str2 != nil {
            return str1.stringByAppendingFormat("/resource/view/"+str2!)
        }else{
            return str1
        }
    }
    
    //MARK:- 投资方认证
    func initInverStorsAuthentication(arr:NSMutableArray){
        self.authenticationInfo(arr, title: loadString("MineInvestorsAuthentication", tableId: STRING_MINE) ) {[weak self] in
            
            if DSAccountInfo.sharedInstance().AuthenticationStatus == "CHECKING"{
                SMToast("您所提交的认证信息正在审核中，审核结果将在一个工作日内答复")
            }else{
                
                let vc:DSInverStorsAuthenticationViewController = DSInverStorsAuthenticationViewController.createViewController(nil) as! DSInverStorsAuthenticationViewController
                vc.hidesBottomBarWhenPushed = true
                self!.pushViewController(vc, animated: true)
            }
        }
    }

    //MARK:- 我的活动
    func initMyActivity(arr:NSMutableArray){
        self.initTheInfo(arr, image: "mine_myActivity", title: loadString("MineMyActivity", tableId: STRING_MINE), subTitle: nil) {
            [weak self] in
            let vc:DSActivityViewController = DSActivityViewController.createViewController(nil) as! DSActivityViewController
            vc.hidesBottomBarWhenPushed = true
            vc.isMyActivity = true
            self!.pushViewController(vc, animated: true)
        }
    }
    
    //MARK:- 推荐给朋友
    func initShareToFriend(arr:NSMutableArray){
        self.initTheInfo(arr, image: "mine_myFriend", title: loadString("MineShareFirend", tableId: STRING_MINE), subTitle: nil) {
            
            //self.shareTitleString = "我是".stringByAppendingFormat(DSAccountInfo.sharedInstance().name!+"，正在极客出发投融资，邀请你一起来")
            self.shareTitleString = "我在极客出发投融资，邀请你一起来"
//            HTShareSDKTool.sharedShareSDKTool().shareForPlatOnWechat(shareUrl, withImage: "share_weibo", withTitle: title)
            
            //if self.isClickShare == true{
                let shareAlertView:XSShareAlertView = XSShareAlertView.init(cancelBtn: {
                    print("取消")
                    self.isClickShare = true
                    }, withWechatBtn: { 
                        self.isClickShare = true
                        self.wechatAlertView()
                    }, withMomentsBtn: { 
                        self.isClickShare = true
                        self.momentAlertView()
                })
                self.view.window!.addSubview(shareAlertView)
                self.isClickShare = false
           // }
        }
    }
    
    //MARK:---微信分享
    func wechatAlertView(){
        
//        let wechatView:XSWechatShareAlertView = XSWechatShareAlertView.init(cancelBtn: { 
//            print("取消")
//            }, withSureBtn: { (value:String?) in
                HTShareSDKTool.sharedShareSDKTool().shareForWechat(self.shareTitleString, withImage: nil, withUrl: self.shareUrlString, withContent: "APP介绍")
//            }, withTitle: self.shareTitleString, withTitleImage: "homePage_share", withContent: "app介绍")
//        self.view.window!.addSubview(wechatView)
        
    }
    
    //MARK:---朋友圈分享
    func momentAlertView(){
//        let momentView:XSMomentsShareAlertView = XSMomentsShareAlertView.init(cancelBtn: { 
//            print("取消")
//            }, withSureBtn: { 
                HTShareSDKTool.sharedShareSDKTool().shareForMoments(self.shareTitleString, withImage: nil, withUrl: self.shareUrlString)
//            }, withImageString: "homePage_share", withTitle: self.shareTitleString)
//        self.view.window!.addSubview(momentView)
    }
    
    
    //MARK:- 设置
    func initSetting(arr:NSMutableArray){
        self.initTheInfo(arr, image: "mine_seting", title: loadString("MineSetting", tableId: STRING_MINE), subTitle: nil) {
            [weak self] in
            let vc:DSMineSetingViewController=DSMineSetingViewController.createViewController(nil) as! DSMineSetingViewController
            vc.hidesBottomBarWhenPushed=true
            self!.pushViewController(vc, animated: true)
        }
    }

    //MARK:- 我的约谈
    func initMyDate(arr:NSMutableArray){
        self.initTheInfo(arr, image: "mine_myQuestioning", title: loadString("MineMyDate", tableId: STRING_MINE), subTitle: nil) {
            [weak self] in
            let vc:DSMineMyInterviewViewController = DSMineMyInterviewViewController.createViewController(nil) as! DSMineMyInterviewViewController
            vc.hidesBottomBarWhenPushed=true
            self!.pushViewController(vc, animated: true)
        }
    }
    //MARK:- 请我关注
    func initInviteMe(arr:NSMutableArray){
        askMeFocusonInfo.className = "DSMineTableViewCell"
        if self.status == .MineInvestors_login_authentication_father{
            askMeFocusonInfo.title = loadString("MineInviteMeFollow", tableId: STRING_MINE)
        }else if self.status == .MineInvestors_login_authentication_child{
            askMeFocusonInfo.title =  loadString("MineInviteUsFollow", tableId: STRING_MINE)
        }
        askMeFocusonInfo.image = "mine_focusonMe"
        askMeFocusonInfo.hasRedPoint = self.newFocus()
        askMeFocusonInfo.block = {
            [weak self] in
            let vc:DSMinePleaseFocusViewController = DSMinePleaseFocusViewController.createViewController(nil) as! DSMinePleaseFocusViewController
            vc.hidesBottomBarWhenPushed=true
            DSAccountInfo.sharedInstance().PleaseFocusIsRead = nil
            self!.pushViewController(vc, animated: true)
        }
        arr.addObject(askMeFocusonInfo)
    }
    //是否有新的关注
    func newFocus() -> (Bool) {
        if DSAccountInfo.sharedInstance().PleaseFocusIsRead == "1" {
            return true
        }else{
            return false
        }
    }
    //MARK:- 我的收藏
    func initMyCollection(arr:NSMutableArray){
        self.initTheInfo(arr, image: "mine_myCollection", title: loadString("MineCollection", tableId: STRING_MINE), subTitle: nil) {
            [weak self] in
//            let vc:DSPersonalInvestmentVC = DSPersonalInvestmentVC.createViewController(nil) as! DSPersonalInvestmentVC
//            //vc.status = self!.status
//            vc.hidesBottomBarWhenPushed = true
//            self!.pushViewController(vc, animated: true)
            let vc:DSMineMyCollectionViewController = DSMineMyCollectionViewController.createViewController(nil) as! DSMineMyCollectionViewController
            vc.status = self!.status
            vc.hidesBottomBarWhenPushed = true
            self!.pushViewController(vc, animated: true)
        }
    }
    //MARK:- 项目方认证
    func initAuthenticationProgram(arr:NSMutableArray){
        self.initTheInfo(arr, image: "mine_investor", title: loadString("MineProgramAuthentication", tableId: STRING_MINE), subTitle: self.tiahuan()) {
            [weak self] in
            if DSAccountInfo.sharedInstance().AuthenticationStatus == "CHECKING"{
                SMToast("您所提交的认证信息正在审核中，审核结果将在一个工作日内答复")
            }else{
                let vc:DSProjectAuthenticationVC = DSProjectAuthenticationVC.createViewController(nil) as! DSProjectAuthenticationVC
                vc.hidesBottomBarWhenPushed = true
                self!.pushViewController(vc, animated: true)
            }
        }
    }
    
    func tiahuan()->(String){
        var status = String()
        if DSAccountInfo.sharedInstance().AuthenticationStatus == nil {
            status = "未认证"
        }else if DSAccountInfo.sharedInstance().AuthenticationStatus == "CHECKING" {
            status = "认证中"
        }else if DSAccountInfo.sharedInstance().AuthenticationStatus == "ACCEPTED" {
            status = "已认证"
        }else{
            status = "未认证"
        }
        return status
    }
    //MARK:- 我的项目
    func initMyProgram(arr:NSMutableArray){
        self.initTheInfo(arr, image: "mine_program", title: loadString("MineMyProgram", tableId: STRING_MINE), subTitle: self.getProjectStatus()) {
            [weak self] in            
            if DSAccountInfo.sharedInstance().productStatus == "CHECKING" {
                SMToast("项目正在审核中，请耐心等候！")
//            }else if DSAccountInfo.sharedInstance().productStatus == "REFUSED"{
//                SMToast("项目审核未通过！")
            }else{
                self!.goToMyProjectVc()
            }
        }
    }
    func getProjectStatus() -> (String) {
         var status = String()
        if DSAccountInfo.sharedInstance().productStatus == nil {
            status = "已发布"
        }else if DSAccountInfo.sharedInstance().productStatus == "CHECKING" {
            status = "审核中"
        }else if DSAccountInfo.sharedInstance().productStatus == "ACCEPTED" {
            status = "已发布"
        }else if DSAccountInfo.sharedInstance().productStatus == "REFUSED"{
            status = "审核未通过"
        }
        return status
    }
    func goToMyProjectVc(){
        let vc:DSDetailMyProjectVC = DSDetailMyProjectVC.createViewController(nil) as! DSDetailMyProjectVC
        vc.isMessage = false
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(vc, animated: true)
    }
    
    
    //MARK:- 约谈我的
    func initDateMy(arr:NSMutableArray,num:String?){
        dateMeInfo.className = "DSMineTableViewCell"
        dateMeInfo.title = loadString("MineDateMe", tableId: STRING_MINE)
        dateMeInfo.subTitle = loadString("MineDateMeStr", tableId: STRING_MINE)
        dateMeInfo.numOfPeople=num
        dateMeInfo.image = "mine_myQuestioning"
        dateMeInfo.block = {
         
        }
        arr.addObject(dateMeInfo)
        
    }
        
    //MARK:- 我的关注
    func initMyFollow(arr:NSMutableArray){
        self.initTheInfo(arr, image: "mine_focusonMe", title: loadString("MineMyFollow", tableId: STRING_MINE), subTitle: nil) {
            [weak self] in
            let vc:DSMyAttentionViewController = DSMyAttentionViewController.createViewController(nil) as! DSMyAttentionViewController
            vc.hidesBottomBarWhenPushed = true
            self!.pushViewController(vc, animated: true)
        }
    }
    
    
    func initTheHead(arr:NSMutableArray,subTitle:String,block:selectBlock){
        
        let info:DSMineHeadCellModel = DSMineHeadCellModel()
        info.className = "DSMineHeadTableViewCell"
        if self.status == .MineInvestors_login_unauthentication{
            info.name = loadString("MineUnAuthenticationRich", tableId: STRING_MINE)
        }else if self.status == .MineProject_login_unauthentication{
            info.name = loadString("MineUnAuthenticationProgram", tableId: STRING_MINE)
        }
        info.block = block
        info.subTitle = subTitle
        arr.addObject(info)
    }
    
    func initImageHead(arr:NSMutableArray, cell:String,name:String?,subTitle:String?,Headimage:String?,headImage:Bool,block:selectBlock){
//        self.mineHeadInfo:DSMineHeadCellModel = DSMineHeadCellModel()
        self.mineHeadInfo.className = cell
        self.mineHeadInfo.name=name
        self.mineHeadInfo.headImage = Headimage
        if self.status == .MinePark_login_authentication{
            
            self.mineHeadInfo.peopleType = loadString("MineAuthenticationPark", tableId: STRING_MINE)
        }else if self.status == .MineProject_login_authentication{
            
            self.mineHeadInfo.peopleType = loadString("MineAuthenticationProgram", tableId: STRING_MINE)
        }else if self.status == .MineInvestors_login_authentication_father||self.status == .MineInvestors_login_authentication_child{
            
             self.mineHeadInfo.peopleType = loadString("MineAuthenticationInvestors", tableId: STRING_MINE)
        }

        self.mineHeadInfo.block = block
        self.mineHeadInfo.subTitle = subTitle
        self.mineHeadInfo.hideHeadImage = headImage
        arr.addObject(self.mineHeadInfo)
    }
    func initTheInfo(arr:NSMutableArray,image:String,title:String,subTitle:String?,block:selectBlock){
        let info:DSMineCellModel = DSMineCellModel()
        info.className = "DSMineTableViewCell"
        info.title = title
        info.subTitle = subTitle
        info.image = image
        info.block = block
        arr.addObject(info)
    }
    
    func returnTheInfo(image:String,title:String,subTitle:String?,block:selectBlock)->DSMineCellModel{
        let info:DSMineCellModel = DSMineCellModel()
        info.className = "DSMineTableViewCell"
        info.title = title
        info.subTitle = subTitle
        info.image = image
        info.block = block
        return info
    }
    
    func authenticationInfo(arr:NSMutableArray,title:String,block:selectBlock){
        let info:DSAuthenticationViewCellModel = DSAuthenticationViewCellModel()
        info.className = "DSAuthenticationViewCell"
        info.title = title
        info.block = block
        arr.addObject(info)
    }
    

}
