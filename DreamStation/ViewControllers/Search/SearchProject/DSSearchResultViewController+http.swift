//
//  DSSearchResultViewController+http.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/7.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

extension DSSearchResultViewController{
    
    //MARK:------项目搜索
    func httpSearchProjectRequire(name:String){
        let cmd:DSHttpSearchProductCmd = DSHttpSearchProductCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpSearchProductCmd
        let block:httpBlock = {(result:RequestResult!,useInfo:AnyObject!)->()in
            self.httpSearchProjectResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate = completeDelegate
        
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_SearchProduct_name] = name
        cmd.requestInfo = dic as [NSObject:AnyObject]
        print("url == %@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpSearchProjectResponse(result:RequestResult){
        let r:DSHttpSearchProductResult = result as! DSHttpSearchProductResult
        if r.isOk() {
            self.dataSource.removeAllObjects()
            if r.getAllSearchContent().count != 0 {
                self.getSearchData(r.getAllSearchContent())
            }else{
                self.attImage.hidden = false
                self.attLabel.hidden = false
            }
        }
    }
    
    func getSearchData(data:NSMutableArray){
        
        for index in 0..<data.count {
            self.city = nil
            self.phease = nil
            let list:NSMutableArray = NSMutableArray()
            let httpInfo = data[index] as! DSSearchProductInfo
            let hotCellInfo = DSHotCellModel()
            hotCellInfo.className = "DSHotTableViewCell"
            hotCellInfo.titleValue = httpInfo.brief
            for index in 0..<httpInfo.categories!.count {
                let cat:DSSearchProductCatsInfo = httpInfo.categories![index] as! DSSearchProductCatsInfo
                if cat.name == "所在地区" {
                    self.city = self.catTihuan(self.city, httpStr: cat.descriptions!)
                }else if cat.name == "所属行业"{
                    
                    hotCellInfo.categories.addObject(cat.descriptions!)
                }else if cat.name == "融资阶段" {
                    self.phease = self.catTihuan(self.phease, httpStr: cat.descriptions!)
                }else if cat.name == "投资币种" {
                    self.money = cat.descriptions
                }
            }
            hotCellInfo.detailValue = self.detailValueTihuan(self.city, phease: self.phease)
            hotCellInfo.block = {[weak self] in
                if DSAccountInfo.sharedInstance().personId != nil {
                    if self!.limitsStatus() == true {
                        self?.canEnterPerDetail(httpInfo.id)
                    }else{
                        SMToast("由于您的身份限制，暂时无法查看")
                    }
                }else{
                    let vc:DSLoginViewController = DSLoginViewController.createViewController(nil) as! DSLoginViewController
                    vc.loginReturnType = LOGINTYPE.TABBARLOGIN
                    vc.hidesBottomBarWhenPushed = true
                    self!.pushViewController(vc, animated: true)
                }
            }
            
            let hotVideoCellInfo = DSHotVideoCellModel()
            hotVideoCellInfo.className = "DSHotVideoTableViewCell"
            hotVideoCellInfo.videoUrl = httpInfo.videoUrl
            hotVideoCellInfo.block = {[weak self] in
                if DSAccountInfo.sharedInstance().personId != nil {
                    if self?.limitStatus() == true && self?.roleJudge(httpInfo.id!) == true{
//                        let urlString:String = (hotVideoCellInfo.videoUrl?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))!
//                        self?.pushWebViewController(urlString,title: httpInfo.brief)
                        self?.judgeVideol(httpInfo.videoUrl, title: httpInfo.brief)
                    }else{
                        SMToast("由于您的身份限制，暂时无法查看")
                    }
                }else{
                    self!.gotoLoginVC()
                }
            }
            list.addObject(hotCellInfo)
            list.addObject(hotVideoCellInfo)
            self.dataSource.addObject(list)
        }
        self.tableView.reloadData()
    }
    func judgeVideol(url:String?,title:String?){
        if url != nil {
            let urlString:String = (url!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
            //self.pushWebViewController(urlString,title: title)
            self.gotoYouKuVideoPlayView(urlString, title: title)
        }else{
            SMToast("暂无项目视频")
        }
    }
    //校验url
    func checkUrl(urlString:String) -> Bool {
        let regex = "http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?"
        let pred = NSPredicate.init(format: "SELF MATCHES %@", regex)
        return pred.evaluateWithObject(urlString)
    }

    
    
    func gotoLoginVC(){
        let vc:DSLoginViewController = DSLoginViewController.createViewController(nil) as! DSLoginViewController
        vc.loginReturnType = LOGINTYPE.TABBARLOGIN
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(vc, animated: true)
    }
    func limitsStatus()->(Bool){
        if DSAccountInfo.sharedInstance().authorized == "1"{
            return true
        }
        return false
    }
    func roleJudge(id:String)->(Bool){
        if DSAccountInfo.sharedInstance().role == "PROVIDER" || DSAccountInfo.sharedInstance().role == "ROLE_PROVIDER"{
            if DSAccountInfo.sharedInstance().productsId == id {
                return true
            }else{
                return false
            }
        }
        return true
    }
    func canEnterPerDetail(id:String?){
        switch DSAccountInfo.sharedInstance().role {
        case "PROVIDER","ROLE_PROVIDER":
            if DSAccountInfo.sharedInstance().productsId == id {
                let vc:DSHotDetailViewController = DSHotDetailViewController.createViewController(nil) as! DSHotDetailViewController
                vc.projectId = id
                vc.hidesBottomBarWhenPushed = true
                self.pushViewController(vc, animated: true)
            }else{
                SMToast("由于您的身份限制，暂时无法查看")
            }
            break
        default:
            let vc:DSHotDetailViewController = DSHotDetailViewController.createViewController(nil) as! DSHotDetailViewController
            vc.projectId = id
            vc.hidesBottomBarWhenPushed = true
            self.pushViewController(vc, animated: true)
            break
        }
    }
    
    func limitStatus()->(Bool){
        if DSAccountInfo.sharedInstance().authorized == "1"{
            return true
        }
        return false
    }

    
    func appendString(valueStr:String,resultStr:String)->(String){
        let result:String = resultStr.stringByAppendingFormat("／"+valueStr)
        return result
    }
    func catTihuan(str:String?,httpStr:String?) -> (String?) {
        var string:String?
        if str != nil {
            string = str!+"／"+httpStr!
        }else{
            string = httpStr
        }
        return string!
    }
    func detailValueTihuan(city:String?,phease:String?) -> (String?) {
        var detailValue:String?
        if city != nil && phease != nil{
            detailValue = city!+"／"+phease!
        }else if city != nil && phease == nil{
            detailValue = city!
        }else if city == nil && phease != nil{
            detailValue = phease!
        }
        return detailValue
    }
}
