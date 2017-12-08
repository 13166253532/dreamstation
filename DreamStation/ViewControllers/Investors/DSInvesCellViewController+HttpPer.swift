//
//  DSInvesCellViewController+HttpPer.swift
//  DreamStation
//
//  Created by xjb on 2017/1/19.
//  Copyright © 2017年 QPP. All rights reserved.
//

import UIKit
private let DSINVESTORS = "DSInvestors"

extension DSInvesCellViewController {
    //MARK:个人投资者列表数据加载
    func httpPerInvestmentListRequire(){
        let cmd:HttpCommand=DSHttpPerInvestmentListCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock={[weak self](result:RequestResult!,useInfo:AnyObject!)->() in
            if result != nil {
               self?.httpPerInvestmentListResponse(result)
            }
        }
//        self.perHttpBlock={[weak self](result:RequestResult!,useInfo:AnyObject!)->() in
//            //if result != nil {
//                self?.httpPerInvestmentListResponse(result)
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
                    dic1[kHttpParamKey_PerInvestmentList_Name] = "主投币种"
                    dic1[kHttpParamKey_PerInvestmentList_description] = currencyArray[index]
                    list .addObject(dic1)
                }
            }
            let industryArray = self.dict["关注领域"] as! NSMutableArray
            if industryArray.count != 0 {
                for index in 0..<industryArray.count {
                    let dic1:NSMutableDictionary = NSMutableDictionary()
                    dic1[kHttpParamKey_PerInvestmentList_Name] = "关注领域"
                    dic1[kHttpParamKey_PerInvestmentList_description] = industryArray[index]
                    list .addObject(dic1)
                }
            }
            let phaseArray = self.dict["融资阶段"] as! NSMutableArray
            if phaseArray.count != 0 {
                for index in 0..<phaseArray.count {
                    let dic1:NSMutableDictionary = NSMutableDictionary()
                    dic1[kHttpParamKey_PerInvestmentList_Name] = "投资阶段"
                    dic1[kHttpParamKey_PerInvestmentList_description] = phaseArray[index]
                    list .addObject(dic1)
                }
            }
            let cityArray = self.dict["投资地域"] as! NSMutableArray
            if cityArray.count != 0 {
                for index in 0..<cityArray.count {
                    let dic1:NSMutableDictionary = NSMutableDictionary()
                    dic1[kHttpParamKey_PerInvestmentList_Name] = "投资地域"
                    dic1[kHttpParamKey_PerInvestmentList_description] = cityArray[index]
                    list .addObject(dic1)
                }
            }
            let jsonData = try! NSJSONSerialization.dataWithJSONObject(list, options: NSJSONWritingOptions.PrettyPrinted)
            let jsonString:String = String(data: jsonData,encoding: NSUTF8StringEncoding)!
            if self.dict["最小金额"] != nil {
                dic[kHttpParamKey_PerInvestmentList_investMin] = self.dict["最小金额"] as! String
                dic[kHttpParamKey_PerInvestmentList_investMax] = self.dict["最大金额"] as! String
            }
            dic[kHttpParamKey_PerInvestmentList_query] = jsonString
            
        }
        dic[kHttpParamKey_PerInvestmentList_sortType] = "DESC"
        dic[kHttpParamKey_PerInvestmentList_sortItem] = self.tihuanTimeHeat()
        dic[kHttpParamKey_PerInvestmentList_page] = String(self.page)
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    func httpPerInvestmentListResponse(result:RequestResult){
        let r:DSHttpPerInvestmentListResule = result as! DSHttpPerInvestmentListResule
        if result.isOk() {
            let arr:NSMutableArray = r.getAllContent()
            self.getHttpPerInvestmentListData(arr)
            self.myTableView .reloadData()
        }else{
            SMToast("请查看当前网络状态！")
        }
        self.myTableView.mj_footer.endRefreshing()
        self.myTableView.mj_header.endRefreshing()
    }
    //    func sequencePerTime(arr:NSMutableArray){
    //        let list = arr.sortedArrayUsingComparator { (info1, info2) -> NSComparisonResult in
    //            let info3 = info1 as! DSPerInvestmentListInfo
    //            let info4 = info2 as! DSPerInvestmentListInfo
    //            let createTime3 : Int? = Int(info3.createTime!)
    //            let createTime4 : Int? = Int(info4.createTime!)
    //            if createTime3 < createTime4{
    //                return NSComparisonResult.OrderedDescending
    //            }else if createTime3 > createTime4{
    //                return NSComparisonResult.OrderedAscending
    //            }else{
    //                return NSComparisonResult.OrderedSame
    //            }
    //        }
    //        let array=list as NSArray
    //        self.getHttpPerInvestmentListData(array)
    //    }
    //    func sequencePerHeat(arr:NSMutableArray){
    //
    //        let list = arr.sortedArrayUsingComparator { (info1, info2) -> NSComparisonResult in
    //            let info3 = info1 as! DSPerInvestmentListInfo
    //            let info4 = info2 as! DSPerInvestmentListInfo
    //            let followNum3 : Int? = Int(info3.followNum!)
    //            let followNum4 : Int? = Int(info4.followNum!)
    //            if followNum3 < followNum4{
    //                return NSComparisonResult.OrderedDescending
    //            }else if followNum3 > followNum4{
    //                return NSComparisonResult.OrderedAscending
    //            }else{
    //                return NSComparisonResult.OrderedSame
    //            }
    //        }
    //        let array=list as NSArray
    //        self.getHttpPerInvestmentListData(array)
    //    }
    func getHttpPerInvestmentListData(data:NSArray){
        if data.count == 0 {
            if self.dataSource.count == 0{
                self.myTableView.alpha = 0
            }
        }else{
            self.page = self.page + 1
            self.myTableView.alpha = 1
        }
        for index in 0..<data.count{
            let ar:DSPerInvestmentListInfo = data[index] as! DSPerInvestmentListInfo
            let info = DSInvestorsCellModel()
            info.className = "DSInvestorsTableViewCell"
            info.InvesId = ar.id
            info.InvesName = ar.name
            info.InvesHeat = ar.popular
            if ar.avatar != nil && ar.avatar?.characters.count < 75 {
                if self.isIncludeChineseIn(ar.avatar!) != true  {
                    info.InvesHeadImageUrl = HTHttpConfig.sharedInstance().getServerAddress("").stringByAppendingFormat("/resource/view/"+ar.avatar!)
                }
            }
            if ar.videoImage != nil {
                info.videoImg = HTHttpConfig.sharedInstance().getServerAddress("").stringByAppendingFormat("/resource/view/"+ar.videoImage!)
            }
            info.videoText = ar.videoTitle
            info.videoUrl = ar.videoUrl
            for i in 0..<ar.cats.count {
                let cats:DSAccountsInstituListCatsInfo = ar.cats[i] as! DSAccountsInstituListCatsInfo
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
            info.isVideo = self.isPerVideo(ar)
            info.block = {[weak self] in
                if DSAccountInfo.sharedInstance().personId != nil{
                    if self!.limitsStatus() == true {
                        self!.canEnterPerDetail(ar.id,num:ar.followNum)
                    }else{
                        SMToast(loadString("DSInvesNoComplete", tableId: DSINVESTORS))
                    }
                }else{
                    self!.gotoLoginVC()
                }
            }
            info.videoBlock = {[weak self] in
                if DSAccountInfo.sharedInstance().personId != nil {
                    if self!.limitsStatus() == true {
                        if ar.videoUrl == nil {
                            SMToast("视频地址为空！")
                        }else if ((self?.isIncludeChineseIn(ar.videoUrl!)) != false){
                            SMToast("视频地址有误！")
                        }else{
                            //self!.pushWebViewController(ar.videoUrl!,title: ar.videoTitle)
                            self?.gotoYouKuVideoPlayView(ar.videoUrl!, title: ar.videoTitle)
                        }
                    }else{
                        SMToast("由于您的身份限制，暂时无法查看")
                    }
                }else{
                    self?.gotoLoginVC()
                }
            }
            self.dataSource .addObject(info)
        }
    }

    
}
