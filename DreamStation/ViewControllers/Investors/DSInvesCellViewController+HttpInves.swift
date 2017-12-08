//
//  DSInvesCellViewController+HttpInves.swift
//  DreamStation
//
//  Created by xjb on 2017/1/19.
//  Copyright © 2017年 QPP. All rights reserved.
//

import UIKit
private let DSINVESTORS = "DSInvestors"
extension DSInvesCellViewController {

    //MARK:投资机构数据加载
    func httpAccountsInstituListRequire(){
        let cmd:HttpCommand=DSHttpAccountsInstituListCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock={
            [weak self](result:RequestResult!,useInfo:AnyObject!)->() in
            if result != nil {
                self?.httpAccountsInstituListResponse(result)
            }
        }
//        self.invesHttpBlock={
//            [weak self](result:RequestResult!,useInfo:AnyObject!)->() in
//            //if result != nil {
//                self?.httpAccountsInstituListResponse(result)
//            //}
//        }
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        let dic:NSMutableDictionary = NSMutableDictionary()
        if self.arr.count != 0 {
            self.dict = self.arr.lastObject as! NSMutableDictionary
            
            let list:NSMutableArray = NSMutableArray()
            let currencyArray = self.dict["投资币种"] as! NSMutableArray
            if currencyArray.count != 0{
                for index in 0..<currencyArray.count{
                    let dic1:NSMutableDictionary = NSMutableDictionary()
                    dic1[kHttpParamKey_AccountsInstituList_Name] = "主投币种"
                    dic1[kHttpParamKey_AccountsInstituList_description] = currencyArray[index]
                    list .addObject(dic1)
                }
            }
            let industryArray = self.dict["关注领域"] as! NSMutableArray
            if industryArray.count != 0 {
                for index in 0..<industryArray.count {
                    let dic1:NSMutableDictionary = NSMutableDictionary()
                    dic1[kHttpParamKey_AccountsInstituList_Name] = "关注领域"
                    dic1[kHttpParamKey_AccountsInstituList_description] = industryArray[index]
                    list .addObject(dic1)
                }
            }
            let phaseArray = self.dict["融资阶段"] as! NSMutableArray
            if phaseArray.count != 0 {
                for index in 0..<phaseArray.count {
                    let dic1:NSMutableDictionary = NSMutableDictionary()
                    dic1[kHttpParamKey_AccountsInstituList_Name] = "投资阶段"
                    dic1[kHttpParamKey_AccountsInstituList_description] = phaseArray[index]
                    list .addObject(dic1)
                }
            }
            let cityArray = self.dict["投资地域"] as! NSMutableArray
            if cityArray.count != 0 {
                for index in 0..<cityArray.count {
                    let dic1:NSMutableDictionary = NSMutableDictionary()
                    dic1[kHttpParamKey_AccountsInstituList_Name] = "投资地域"
                    dic1[kHttpParamKey_AccountsInstituList_description] = cityArray[index]
                    list .addObject(dic1)
                }
            }
            let jsonData = try! NSJSONSerialization.dataWithJSONObject(list, options: NSJSONWritingOptions.PrettyPrinted)
            let jsonString:String = String(data: jsonData,encoding: NSUTF8StringEncoding)!
            if self.dict["最小金额"] != nil {
                dic[kHttpParamKey_AccountsInstituList_investMin] = self.dict["最小金额"] as! String
                dic[kHttpParamKey_AccountsInstituList_investMax] = self.dict["最大金额"] as! String
            }
            
            dic[kHttpParamKey_AccountsInstituList_query] = jsonString
            
        }
        dic[kHttpParamKey_AccountsInstituList_sortType] = "DESC"
        dic[kHttpParamKey_AccountsInstituList_sortItem] = self.tihuanTimeHeat()
        dic[kHttpParamKey_AccountsInstituList_page] = String(self.page)
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    func httpAccountsInstituListResponse(result:RequestResult){
        let r:DSHttpAccountsInatituListResule = result as! DSHttpAccountsInatituListResule
        if result.isOk() {
            let arr:NSMutableArray = r.getAllContent()
            self.getHttpInstituData(arr)
            self.myTableView.reloadData()
        }else{
            SMToast("请查看当前网络状态！")
        }
        self.myTableView.mj_footer.endRefreshing()
        self.myTableView.mj_header.endRefreshing()
    }
    
    func getHttpInstituData(data:NSArray){
        //self.dataSource.removeAllObjects()
        if data.count == 0 {
            if self.dataSource.count == 0 {
                self.myTableView.alpha = 0
            }
        }else{
            self.page = self.page + 1
            self.myTableView.alpha = 1
        }
        
        for index in 0..<data.count {
            let ar:DSAccountsInstituListInfo = data[index] as! DSAccountsInstituListInfo
            //print("公司的ID＝"+ar.id!)
            let info = DSInvestorsCellModel()
            info.className = "DSInvestorsTableViewCell"
            info.InvesId = ar.id
            info.InvesName = ar.company
            //print(ar.followNum,ar.createTime)
            //print("公司的名字＝"+info.InvesName)
            if ar.logo != nil {
                info.InvesHeadImageUrl = HTHttpConfig.sharedInstance().getServerAddress("").stringByAppendingFormat("/resource/view/"+ar.logo!)
            }
            info.videoText = ar.video_title
            if ar.video_pic != nil {
                info.videoImg = HTHttpConfig.sharedInstance().getServerAddress("").stringByAppendingFormat("/resource/view/"+ar.video_pic!)
            }
            info.InvesHeadImageUrl = self.judegeTheStr(HTHttpConfig.sharedInstance().getServerAddress(""), str2: ar.logo)
            info.videoText = ar.video_title
            info.videoImg = self.judegeTheStr(HTHttpConfig.sharedInstance().getServerAddress(""), str2: ar.video_pic)
            info.videoUrl = ar.video_url
            let list = ar.cats
            for i in 0..<list!.count{
                let cats:DSAccountsInstituListCatsInfo = ar.cats?[i] as! DSAccountsInstituListCatsInfo
                if cats.catName == "所属行业" || cats.catName == "关注领域" {
                    if info.Invesindustry != nil{
                        info.Invesindustry = info.Invesindustry!+"／"+cats.descriptions!
                    }else{
                        info.Invesindustry = cats.descriptions
                    }
                }else if cats.catName == "融资阶段" || cats.catName == "投资阶段"{
                    if info.InvesPhase != nil{
                        info.InvesPhase = info.InvesPhase!+"／"+cats.descriptions!
                    }else{
                        info.InvesPhase = cats.descriptions
                    }
                }else if cats.catName == "所在地区" || cats.catName == "投资地域"{
                    info.InvesLocation = cats.descriptions
                }else if cats.catName == "投资币种" || cats.catName == "主投币种"{
                    info.InvesCurrency = cats.descriptions
                }else if cats.catName == "投资偏好"{
                    info.preferences = cats.descriptions
                }
            }
            info.isVideo = self.isVideo(ar)
            info.block = {[weak self] in
                if DSAccountInfo.sharedInstance().personId != nil {
                    if self!.limitsStatus() == true {
                        self!.canEnterInvDetail(ar.id, num: ar.followNum)
                    }else{
                        SMToast(loadString("DSInvesNoComplete", tableId: DSINVESTORS))
                    }
                }else{
                    self!.gotoLoginVC()
                }
            }
            info.videoBlock = {
                if DSAccountInfo.sharedInstance().personId != nil {
                    if self.limitsStatus() == true {
                        if ar.video_url == nil {
                            SMToast("视频地址为空！")
                        }else if ((self.isIncludeChineseIn(ar.video_url!)) != false){
                            SMToast("视频地址有误！")
                        }else{
                            //self.pushWebViewController(ar.video_url!,title: ar.video_title)
                            self.gotoYouKuVideoPlayView(ar.video_url!, title: ar.video_title)
                        }
                    }else{
                        SMToast("由于您的身份限制，暂时无法查看")
                    }
                }else{
                    self.gotoLoginVC()
                }
            }
            self.dataSource .addObject(info)
        }
    }

    
}
