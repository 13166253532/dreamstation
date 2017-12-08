//
//  DSMineMyProjectViewController+http.swift
//  DreamStation
//
//  Created by xjb on 2016/12/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

extension DSMineMyProjectViewController{
    //MARK:--------获取认证项目列表----------
    func httpPerProgramsRequire(){
        let cmd:HttpCommand=DSHttpPerProductsCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self?.httpPerProgramsResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_PerProducts_id] = DSAccountInfo.sharedInstance().personId
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpPerProgramsResponse(result:RequestResult){
        let r:DSHttpPerProductsResult = result as! DSHttpPerProductsResult
        httpNoPerProgramsRequire()
        if r.isOk() {
            self.addDataSource(r.getAllContent())
        }
        
    }
    
    func addDataSource(arry:NSMutableArray){
        self.dataSource = NSMutableArray()
        for index in 0..<arry.count {
            let infos = arry[index] as! DSProductsInfo
            let info = DSMineMyProjectCellModel()
            info.className = "DSMineMyProjectCell"
            info.title = infos.companyName
            info.subTitle = infos.brief
            info.block = {[weak self] in
                self!.getProductId(infos)
            }
            self.dataSource .addObject(info)
        }
        self.myTabelView.reloadData()
        self.addtableView()
    }
    func getProductId(info:DSProductsInfo){
        DSAccountInfo.sharedInstance().productsId = info.id
        //DSAccountInfo.sharedInstance().categories = info.jsonCat
        DSAccountInfo.sharedInstance().companyName = info.companyName
        DSAccountInfo.sharedInstance().address = info.address
        DSAccountInfo.sharedInstance().videoUrl = info.videoUrl
        DSAccountInfo.sharedInstance().productsName = info.brief
        DSAccountInfo.sharedInstance().categories = info.jsonCat
        DSAccountInfo.sharedInstance().productsmyName = info.myName
        DSAccountInfo.sharedInstance().name = info.myName
        DSAccountInfo.sharedInstance().productStatus = info.productStatus
        DSAccountInfo.sharedInstance().position =  info.position
        DSAccountInfo.sharedInstance().job = info.position
        self.block()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK:--------获取未认证项目列表----------
    func httpNoPerProgramsRequire(){
        let cmd:HttpCommand=DSHttpGetProjectChangeCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self?.httpNoPerProgramsResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_GetProjectChange_status] = "CHECKING"
        dic[kHttpParamKey_GetProjectChange_login] = DSAccountInfo.sharedInstance().phoneNum
        dic[kHttpParamKey_GetProjectChange_type] = "PROJECT"
        
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
    }
    func httpNoPerProgramsResponse(result:RequestResult){
        let r:DSHttpGetProjectChangeResule = result as! DSHttpGetProjectChangeResule
        if r.isOk() {
            self.addNoDataSource(r.getProjectData())
        }
    }
    func addNoDataSource(arry:NSMutableArray){
        //self.dataSource = NSMutableArray()
//        if arry.count == 0 {
//            self.tishiImage.hidden = false
//            self.tishiLabel.hidden = false
//        }
        for index in 0..<arry.count {
            let infos = arry[index] as! DSGetProjectChangeInfo
            let info = DSMineMyProjectCellModel()
            info.className = "DSMineMyProjectCell"
            info.title = infos.message.company.companyName
            info.subTitle = infos.message.detail.brief
            info.block = {[weak self] in
               SMToast("当前项目正在审核中，无法切换")
            }
            self.dataSource .addObject(info)
        }
        self.myTabelView.reloadData()
        //self.addtableView()
    }
    
}
