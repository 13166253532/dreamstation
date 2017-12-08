//
//  DSParkViewController+Http.swift
//  DreamStation
//
//  Created by QPP on 16/11/16.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

extension DSParkViewController {

    //MARK:-------请求数据-------
    func httpParkListRequire(){
        
        let cmd:DSHttpParkListCmd=DSHttpParkListCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpParkListCmd
        let block:httpBlock = {[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self!.httpParkListResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_ParkList_page] = String(self.page)
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate=completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpParkListResponse(result:RequestResult){
        let r:DSHttpParkListResult = result as! DSHttpParkListResult
        if r.isOk() {
            self.getHttpDataSource(r.getAllContents())
            //self.initTableView()
            self.myTableView.reloadData()
        }else{
            SMToast("请查看当前网络状态！")
        }
        self.myTableView.mj_header.endRefreshing()
        self.myTableView.mj_footer.endRefreshing()
    }
    //MARK:-------城市筛选数据-------
    func httpSearchParkRequire(){
        let cmd:DSHttpSearchParkCmd=DSHttpSearchParkCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpSearchParkCmd
        let block:httpBlock = {[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self!.httpSearchParkResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_SearchPark_address] = self.cityName
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpSearchParkResponse(result:RequestResult){
        let r:DSHttpSearchParkResult = result as! DSHttpSearchParkResult
        if r.isOk() {
            let arr:NSMutableArray = r.getSearchParkData()
            if arr.count == 0 {
                self.tixingLabel.hidden = false
                self.tixingImage.hidden = false
                self.layout.constant = UIScreen.mainScreen().bounds.height-190
            }else{
                self.tixingLabel.hidden = true
                self.tixingImage.hidden = true
                self.layout.constant = 0
            }
            self.cleanData()
            
            self.getHttpDataSource(arr)
            self.myTableView.reloadData()
        }
        self.myTableView.mj_header.endRefreshing()
        self.myTableView.mj_footer.endRefreshing()
    }
    
    func getHttpDataSource(arr:NSMutableArray){
        
        if arr.count == 0 && self.dataSource.count == 0{
            self.tixingLabel.hidden = false
            self.tixingImage.hidden = false
        }else if arr.count != 0{
            self.page = self.page + 1
        }
        let tableArr=self.dataSource[1] as! NSMutableArray
        for index in 0..<arr.count {
            let infos = arr[index] as! DSSearchParkInfo
            let info = DSParkCellModel()
            info.className = "DSParkPageCell"
            if infos.parkLogo != nil {
                info.headImage = self.changeImgUrl(infos.parkLogo!)
            }
            info.parkName = infos.parkName
            info.parkSub = infos.introduction
            info.cityName = self.changeAddress(infos.detailAddressArray)
            if infos.videoImage != nil {
                info.videoImage = self.changeImgUrl(infos.videoImage!)
            }
            info.videoSub = infos.videoTitle
            info.block = {[weak self] in
                
                if self?.checkoutLogin() == true {
                    self?.checkoutAuthorized(infos.id!)
                }else{
                    self!.gotoLoginVC()
                }
            }
            info.goBlock = {[weak self] (sender: AnyObject)in
                if DSAccountInfo.sharedInstance().personId != nil  {
                    if DSAccountInfo.sharedInstance().authorized == "1" {
                        if self!.isIncludeChineseIn(infos.videoUrl!) != true {
                            //self!.pushWebViewController(infos.videoUrl!,title: infos.videoTitle)
                            self!.judgeRoleName(infos)
                        }else{
                            SMToast("视频地址有误！")
                        }
                    }else{
                            SMToast("由于您的身份限制，暂时无法查看")
                    }
                }else{
                    self!.gotoLoginVC()
                }
            }
            tableArr.addObject(info)
            
        }
    }
    func judgeRoleName(infos:DSSearchParkInfo){
        if DSAccountInfo.sharedInstance().role != "PARK_ADMIN"  {
            //self.pushWebViewController(infos.videoUrl!,title: infos.videoTitle)
            self.gotoYouKuVideoPlayView(infos.videoUrl!, title: infos.videoTitle)
        }else{
            if DSAccountInfo.sharedInstance().personId == infos.id {
                //self.pushWebViewController(infos.videoUrl!,title: infos.videoTitle)
                self.gotoYouKuVideoPlayView(infos.videoUrl!, title: infos.videoTitle)
            }else{
                SMToast("由于您的身份限制，暂时无法查看")
            }
        }
    }
    
    func gotoLoginVC(){
        let vc:DSLoginViewController = DSLoginViewController.createViewController(nil) as! DSLoginViewController
        vc.loginReturnType = LOGINTYPE.TABBARLOGIN
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(vc, animated: true)
    }
    
    func changeAddress(arr:NSMutableArray) -> (String) {
        var address = String()
        if arr.count != 0 {
            for index in 0..<arr.count {
                let addressInfo:DSParkListDetailAddressinfo = arr[index] as! DSParkListDetailAddressinfo
                if addressInfo.city == nil {
                    addressInfo.city = "nil"
                }
                if index == 0 {
                   address = addressInfo.city!
                }else if self.lookingNSSreing(address, cityName: addressInfo.city!) == false{
                    address = address+"/"+addressInfo.city!
                }
            }
        }
        return address
    }
    func lookingNSSreing(address:String,cityName:String) -> (Bool) {
        let addStr:NSString = address as NSString
        let cityStr:NSString = cityName as NSString
        let notFoundstr = addStr.rangeOfString(cityStr as String)
        if notFoundstr.location == NSNotFound {
            return false
        }else{
           return true
        }
    }
    
    
}

























