//
//  DSDetailMyProjectVC.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit
private let STRING_MINE = "DSMineStrings"
class DSDetailMyProjectVC: HTBaseViewController {

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var layout: NSLayoutConstraint!
    
    var delegate:DSProjectInformationDelegate!
    var dataSource:NSMutableArray = NSMutableArray()
    var catsData:NSMutableArray = NSMutableArray()
    var info:DSProductsDetailsInfo!
    var dataDic:NSMutableDictionary = NSMutableDictionary()
    var catList:NSMutableArray = NSMutableArray()
    var passBlock:passParameterBlock!
    var catValueBlock:passParameterBlock?
    
    var isGetService:Bool!
    var isWantToShow:Bool!
    var isIncubator:Bool!
    var isMessage:Bool!
    var projectId:String!
    
    var removeIndex:String?
    var extractionCode:String?
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSDetailMyProjectVC", bundle: nil)
        let vc:DSDetailMyProjectVC=storyboard.instantiateViewControllerWithIdentifier("DSDetailMyProjectVC")as! DSDetailMyProjectVC
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTitleBar()
        self.title = loadString("MineMyProgram", tableId: STRING_MINE)
        self.layout.constant = UIScreen.mainScreen().bounds.height
        self.getHttpProjectdetailsRequire()
        //self.initTableView()
    }
    
    func initTableView(){
        self.initTableViewData()
        self.delegate = DSProjectInformationDelegate()
        self.delegate.dataSource = self.dataSource
        registerCell(self.tableView, cell: DSProjectNinthCell.self)
        registerCell(self.tableView, cell: DSAgencyThirdCell.self)
        registerCell(self.tableView, cell: DSAgencyFirstCell.self)
        registerCell(self.tableView, cell: DSProjectTenthCell.self)
        registerCell(self.tableView, cell: DSProjectEleventhCell.self)
        registerCell(self.tableView, cell: DSProjectEighthCell.self)
        registerCell(self.tableView, cell: DSProjectFootCell.self)
        registerCell(self.tableView, cell: DSAgencyFifthCell.self)
        self.tableView.delegate = self.delegate
        self.tableView.dataSource = self.delegate
        self.tableView.backgroundColor = loginBg_Color
    }
    
    func initTableViewData(){
        
        self.initFirstSectionData()
        self.initSecondSectionData()
        self.initThirdSectionData()
        self.initFourthSectionData()
        self.initFifthSectionData()
        self.initSixthSectionData()
        self.initSeventhSectionData()
    }
    
    //MARK:tableView第一组数据
    func initFirstSectionData(){
        
        let list:NSMutableArray = NSMutableArray()
        
        self.initFirstData(list,title: "所属行业")
        self.initSecondData(list,title: "融资阶段")
        
        let xinfo:DSProjectNinthCellModel = DSProjectNinthCellModel()
        xinfo.className = "DSProjectNinthCell"
        xinfo.titleValue = "融资金额"
        xinfo.text = self.judgeInfo(self.info.amount)
        xinfo.detailValue = "请输入"
        xinfo.numKeyboardType = true
        xinfo.suffixValue = "万元"
        xinfo.block = {[weak self](value:AnyObject)->Void in
            xinfo.text = value as? String
            self?.info.amount = value as? String
        }
        list.addObject(xinfo)
        
        self.initFourthData(list,title: "币种")
        
        let xinfo1:DSProjectNinthCellModel = DSProjectNinthCellModel()
        xinfo1.className = "DSProjectNinthCell"
        xinfo1.titleValue = "投后股比"
        xinfo1.text = self.judgeInfo(self.info.ratio)
        xinfo1.numKeyboardType = true
        xinfo1.detailValue = "请输入"
        xinfo1.suffixValue = "%"
        xinfo1.block = {[weak self](value:AnyObject?)->Void in
            xinfo1.text = value as? String
            if xinfo1.text != nil || xinfo1.text?.characters.count != 0{
                if self?.isNegativeNumber(xinfo1.text!) == false {
                    xinfo1.text = self?.judgeInfo(self!.info.ratio)
                    self?.tableView.reloadData()
                }else{
                    self?.info.ratio = value as? String
                }
            }
            
        }
        list.addObject(xinfo1)
        self.initThirdData(list,title: "所在地区")
        self.dataSource.addObject(list)
    }
  
    //MARK:判断是否为负数
    func isNegativeNumber(str:String) -> (Bool) {
        let string = Double(str)
        if string > 0 {
            return true
        }else{
            //SMToast("输入内容有误！")
        }
        return false
    }
    //MARK:第二组
    func initSecondSectionData(){
        let list:NSMutableArray = NSMutableArray()
        let xinfo:DSAgencyFirstCellModel = DSAgencyFirstCellModel()
        xinfo.className = "DSAgencyFirstCell"
        xinfo.titleValue = "一句话标题"
        xinfo.detailValue = self.judgeInfo(self.info.brief)
        xinfo.placeholderValue = "输入内容不含项目名，体现项目亮点"
        xinfo.isHidden = false
        xinfo.isCanEdit = true
        xinfo.block = {[weak self](value:AnyObject)->Void in
            xinfo.detailValue = value as? String
            self?.info.brief = value as? String
        }
        list.addObject(xinfo)
        self.dataSource.addObject(list)
    }

    //MARK:第三组
    func initThirdSectionData(){
        let list:NSMutableArray = NSMutableArray()
        let titleList:NSArray = ["投资亮点、行业及市场、商业模式、产品或服务优势、商业计划书","请发送如上内容到1234@126.com，由极客出发工作人员帮您上传"]
        
        for index in 0..<titleList.count {
            let xinfo:DSProjectTenthCellModel = DSProjectTenthCellModel()
            xinfo.className = "DSProjectTenthCell"
            if index==0 {
                xinfo.hiddenBtn = false
                xinfo.titleValue = titleList.objectAtIndex(index) as? String
                xinfo.block = {
                    [weak self ]in
                    self!.showXWAlertView(loadString("MineProjectAttention1", tableId: STRING_MINE))
                }
            }else{
                xinfo.hiddenBtn = true
                let attStr:NSMutableAttributedString = NSMutableAttributedString.init(string: (titleList.objectAtIndex(index) as? String)!)
                attStr.addAttribute(NSForegroundColorAttributeName, value: greenNavigationColor, range: (attStr.string as NSString).rangeOfString("1234@126.com"))
                xinfo.titleValue1 = attStr
            }
            list.addObject(xinfo)
        }
        self.dataSource.addObject(list)
    }
    
    //MARK:第四组
    func initFourthSectionData(){
        let list:NSMutableArray = NSMutableArray()
        
        let xinfo:DSProjectEleventhCellModel = DSProjectEleventhCellModel()
        xinfo.className = "DSProjectEleventhCell"
        xinfo.titleValue = "视频与BP下载链接"
        xinfo.detailValue = self.judgeInfo(self.info.downloadLink)
        if SCREEN_WHIDTH() <= 320 {
            xinfo.placeholderValue = "输入项目视频与BP的\n下载链接"
        }else{
            xinfo.placeholderValue = "输入项目视频与BP的下载链接"
        }
        xinfo.isHidden = false
        xinfo.block = {[weak self](value:AnyObject?)->Void in
            xinfo.detailValue = value as? String
            self?.info.downloadLink = value as? String
        }
        list.addObject(xinfo)
        
        let xinfo2:DSProjectEleventhCellModel = DSProjectEleventhCellModel()
        xinfo2.className = "DSProjectEleventhCell"
        xinfo2.titleValue = "提取码"
        xinfo2.detailValue = self.judgeInfo(self.info.extractionCode)
        xinfo2.placeholderValue = "输入提取码"
        xinfo2.isHidden = false
        xinfo2.block = {[weak self](value:AnyObject?)->Void in
            xinfo2.detailValue = value as? String
            self?.info.extractionCode = value as? String
        }
        list.addObject(xinfo2)
        
        let xinfo3:DSProjectFootCellModel = DSProjectFootCellModel()
        xinfo3.className = "DSProjectFootCell"
        xinfo3.titleValue = "《英翼视频范例》"
        xinfo3.block = {
            SMToast(xinfo3.titleValue)
        }
        list.addObject(xinfo3)
        
        self.dataSource.addObject(list)
    }
    
    //MARK:第五组
    func initFifthSectionData(){
        let list:NSMutableArray = NSMutableArray()
        
        let xinfo:DSProjectEighthCellModel = DSProjectEighthCellModel()
        xinfo.className = "DSProjectEighthCell"
        xinfo.titleValue = "希望获取深度服务"
        xinfo.isAn = self.tiHuanIsAn(self.info!.needMoreService)
//        self.isGetService = true
        xinfo.isHidden = true
        xinfo.block = {[weak self](value:AnyObject?)->Void in
            if value as! Bool == true {
//                self!.isGetService = true
                xinfo.isAn = true
                self?.info.needMoreService = "1"
            }else{
//                self!.isGetService = false
                xinfo.isAn = false
                self?.info.needMoreService = "0"
            }
        }
        list.addObject(xinfo)
        
        let xinfo2:DSProjectFootCellModel = DSProjectFootCellModel()
        xinfo2.className = "DSProjectFootCell"
        xinfo2.titleValue = "《深度服务说明及收费标准》"
        xinfo2.block = {
            SMToast(xinfo2.titleValue)
        }
        list.addObject(xinfo2)
        
        self.dataSource.addObject(list)
        
    }
    
    //MARK:第六组
    func initSixthSectionData(){
        let list:NSMutableArray = NSMutableArray()
        
        let xinfo:DSProjectEighthCellModel = DSProjectEighthCellModel()
        xinfo.className = "DSProjectEighthCell"
        xinfo.titleValue = "希望上《极客出发》电视节目"
        xinfo.isAn = self.tiHuanIsAn(self.info!.needShow)
//        self.isWantToShow = true
        xinfo.isHidden = true
        xinfo.block = {[weak self](value:AnyObject?)->Void in
            if value as! Bool == true {
//                self!.isWantToShow = true
                xinfo.isAn = true
                self?.info.needShow = "1"
            }else{
//                self!.isWantToShow = false
                xinfo.isAn = false
                self?.info.needShow = "0"
            }
        }
        list.addObject(xinfo)
        
        let xinfo2:DSProjectEighthCellModel = DSProjectEighthCellModel()
        xinfo2.className = "DSProjectEighthCell"
        xinfo2.titleValue = "希望入住孵化器"
        xinfo2.isAn = self.tiHuanIsAn(self.info?.needIncubator)
//        self.isWantToShow = true
        xinfo2.isHidden = true
        xinfo2.block = {[weak self](value:AnyObject?)->Void in
            if value as! Bool == true {
//                self!.isWantToShow = true
                xinfo2.isAn = true
                self?.info.needIncubator = "1"
            }else{
//                self!.isWantToShow = false
                xinfo2.isAn = false
                self?.info.needIncubator = "0"
            }
        }
        list.addObject(xinfo2)
        self.dataSource.addObject(list)
    }

    //MARK:第七组
    func initSeventhSectionData(){
        
        let list:NSMutableArray = NSMutableArray()
        let xinfo:DSAgencyFifthCellModel = DSAgencyFifthCellModel()
        xinfo.className = "DSAgencyFifthCell"
        xinfo.titleValue = "提交"
        xinfo.block = {[weak self] in
            self?.attentionView()
        }
        list.addObject(xinfo)
        self.dataSource.addObject(list)
    }
    
    func attentionView(){
        self.tijaio()
        if self.info?.industry! == nil||self.info?.industry!.characters.count == 0{
            SMToast("所属行业为空")
        }else if self.info?.amountPhase! == nil||self.info?.amountPhase!.characters.count == 0{
            SMToast("融资阶段为空")
        }else if self.info?.currency! == nil||self.info?.currency!.characters.count == 0{
            SMToast("币种为空")
        }else if self.info?.Inthearea! == nil||self.info?.Inthearea!.characters.count == 0{
            SMToast("所在地区为空")
        }else if self.info?.brief! == nil||self.info?.brief!.characters.count==0{
            SMToast("标题为空")
        }else if self.info?.downloadLink! == nil||self.info?.downloadLink!.characters.count==0{
            SMToast("视频下载链接为空")
        }else if self.info?.extractionCode! == nil||self.info?.extractionCode?.characters.count==0{
            SMToast("提取码为空")
        }else if self.info?.amount! == nil||self.info?.amount!.characters.count==0{
            SMToast("融资金额为空")
        }else if self.info?.ratio! == nil||self.info?.ratio!.characters.count==0{
            SMToast("投后股比为空")
        }else {
            let list:NSArray = (self.info?.industry!.componentsSeparatedByString(","))!
            if list.count>3{
                SMToast("所属行业至多选三项")
            }else{
                self.showAttention()
            }
        }
        
    }
    func tijaio(){
        if self.info.industry == nil{
            self.info.industry = String()
        }
        if self.info.amountPhase == nil{
            self.info.amountPhase = String()
        }
        if self.info.currency == nil{
            self.info.currency = String()
        }
        if self.info.Inthearea == nil{
            self.info.Inthearea = String()
        }
        if self.info.industry == nil{
            self.info.industry = String()
        }
        if self.info.brief == nil{
            self.info.brief = String()
        }
        if self.info.downloadLink == nil{
            self.info.downloadLink = String()
        }
        if self.info.extractionCode == nil{
            self.info.extractionCode = String()
        }
    }
    
    //MARK:-------CREAT CELL------
    //MARK:所属行业
    func initFirstData(arr:NSMutableArray,title:String){
        let list:NSArray = self.inPlistData("DSInvestmentAgencyFirst.plist")
        self.initTheInfo(arr, title: title, arrayData: list, type: 0, detailValue: self.judgeValue(self.info?.industry)){[weak self](value:AnyObject)->()in
            self?.info.industry = value as? String
        }
    }
    
    //MARK:融资阶段
    func initSecondData(arr:NSMutableArray,title:String){
        let list:NSArray = self.inPlistData("DSInvestmentAgencySecond.plist")
        self.initTheInfo(arr, title: title, arrayData: list, type: 1, detailValue: self.judgeValue(self.info?.amountPhase)){[weak self](value:AnyObject)->()in
            self?.info.amountPhase = value as? String
        }
    }
    
    //MARK:所在地区
    func initThirdData(arr:NSMutableArray,title:String){
        let list:NSArray = self.inPlistData("DSInvestmentAgencyThird.plist")
        self.initTheInfo(arr, title: title, arrayData: list, type: 2, detailValue: self.judgeValue(self.info?.Inthearea)){[weak self](value:AnyObject)->()in
            self?.info.Inthearea = value as? String
        }

    }
    
    //MARK:币种
    func initFourthData(arr:NSMutableArray,title:String){
        let list:NSArray = self.inPlistData("DSInvestmentAgencyFourth.plist")
        self.initTheInfo(arr, title: title, arrayData: list, type: 3, detailValue: self.judgeValue(self.info?.currency)){[weak self](value:AnyObject)->()in
            self?.info.currency = value as? String
        }
    }
    
    func initTheInfo(list:NSMutableArray,title:String,arrayData:NSArray,type:Int32,detailValue:String,catBlock:passParameterBlock){
        let info:DSAgencyThirdCellModel = DSAgencyThirdCellModel()
        info.className = "DSAgencyThirdCell"
        info.titleValue = title
        info.placdholder = "请选择"
        info.detailValue = self.judgeValue(detailValue)
        info.isHidden = false
        info.block = {[weak self] in
//            let retList:NSArray = self!.takeDescription(title, catsDataList: self!.catsData)
            let retList:NSArray = self!.takeDescription(title, catsDataList: self!.catsData)
            self!.inCollectionView(title, arrayData: arrayData, type: type, selectedList: retList)

            self?.passBlock = {(value:AnyObject?) in
                
                for index in 0..<self!.catsData.count{
                    if title == self!.catsData[index]["catName"] as! String {
                        self?.removeIndex = String(index)
                    }
                }
                if self?.removeIndex != nil {
                    self?.catsData.removeObjectAtIndex(Int((self?.removeIndex)!)!)
                    self?.removeIndex = nil
                }
                info.detailValue = value as! String
                let dic:NSMutableDictionary = NSMutableDictionary()
                dic.setValue(title, forKey: "catName")
                dic.setValue(value, forKey: "description")
                self!.catsData.addObject(dic)
                catBlock(value!)
                
                if value as! String == "" {
                    info.detailValue = nil
                }
                
                self!.tableView.reloadData()
            }
        }
        
        list.addObject(info)
    }
    //MARK:--- 取description数据
    func takeDescription(title:String,catsDataList:NSMutableArray)->NSArray{
        var desList:NSArray = NSArray()
        for index in 0..<catsDataList.count {
            let dic:NSDictionary = catsDataList[index] as! NSDictionary
            if title == dic["catName"] as! String {
                let str = dic["description"] as! String
                desList = str.componentsSeparatedByString(" ")
                return desList
            }
        }
        return desList
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
                    allString = allString.stringByAppendingFormat(" "+str)
                }
                if allString != ""{
                    self!.inSaveData(type, value:allString)
                    self!.passBlock(allString)
                }
            }else{
                self!.inSaveData(type, value: "")
                self!.passBlock("")
            }
        }
    }
    
    func inSaveData(type:Int32,value:String?){
        
        switch type {
        case 0:
            if self.info.industry == nil {
                self.info.industry = String()
            }
            self.info?.industry! = value!
            break
        case 1:
            if self.info.amountPhase == nil {
                self.info.amountPhase = String()
            }
            self.info?.amountPhase! = value!
            break
        case 2:
            if self.info.Inthearea == nil {
                self.info.Inthearea = String()
            }
            self.info?.Inthearea! = value!
            break
        case 3:
            if self.info.currency == nil {
                self.info.currency = String()
            }
            self.info?.currency! = value!
            break
        default:break
        }
    }
    func judgeInfo(httpStr:String?) -> (String) {
        if httpStr != nil {
            return httpStr!
        }
        return ""
    }
    
    func tiHuanIsAn(isAn:String?)->(Bool){
        print(isAn)
        if isAn == "1" {
            return true
        }else{
            return false
        }
    }
    
    func inPlistData(plistString:String)->(NSArray){
        let string:String = NSBundle.mainBundle().pathForResource(plistString, ofType: nil)!
        let plistArray:NSArray = NSArray.init(contentsOfFile: string)!
        return plistArray
    }
    
    func judgeValue(str:String?)->(String){
        if str != nil {
            return str!
        }else{
            return "请选择"
        }
    }
    
    //MARK:"注意"提示
    func showXWAlertView(string:String){
        XWAlterview.showmessage("注意", subtitle: string)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension DSDetailMyProjectVC{
    
    //MARK:-------------修改我的项目
    func putHttpChangeMyProjectRequire(){
        let cmd:DSHttpApplyProjectChangeCmd = DSHttpApplyProjectChangeCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpApplyProjectChangeCmd
        let block:httpBlock = {[weak self](result:RequestResult!,useInfo:AnyObject!)->()in
            self!.putHttpChangeMyProjectResponse(result)
        }
        
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_ApplyProjectChange_user_id] = DSAccountInfo.sharedInstance().personId
        dic[kHttpParamKey_ApplyProjectChange_role_name] = DSAccountInfo.sharedInstance().role
        dic[kHttpParamKey_ApplyProjectChange_projectId] = self.info.id
        dic[kHttpParamKey_ApplyProjectChange_applyLogin] = DSAccountInfo.sharedInstance().phoneNum
        
        let projectDic:NSMutableDictionary = NSMutableDictionary()
        let companyDic:NSMutableDictionary = NSMutableDictionary()
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_myName] = self.info.myName
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_companyName] = self.info.companyName
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_address] = self.info.address
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_homePage] = self.info.homePage
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_weichatPublic] = self.info.wxPublicAccount
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_job] = self.info.position
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_individualMail] = self.info.email
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_weichat] = self.info.wxAccount
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_linkedin] = self.info.linkedIn
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_businessCard] = self.info.cardUrl
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_licenceUrl] = self.info.licenceUrl
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_isOnShow] = self.info.hasShow != "是" ? false:true
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_hasShow] = self.info.hasShow != "是" ? false:true
        projectDic[kHttpParamKey_ApplyProjectChange_project_company] = companyDic
        
        let detailDic:NSMutableDictionary = NSMutableDictionary()
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_amount] = self.info.amount
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_ratio] = self.info.ratio
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_brief] = self.info.brief
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_downloadLink] = self.info.downloadLink
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_videoUrl] = self.info.videoUrl
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_extractionCode] = self.info.extractionCode

        detailDic[kHttpParamKey_ApplyProjectChange_project_company_highLight] = self.info.highLight
        detailDic[kHttpParamKey_ApplyProjectChange_project_company_businessMode] = self.info.businessMode
        detailDic[kHttpParamKey_ApplyProjectChange_project_company_market] = self.info.market
        detailDic[kHttpParamKey_ApplyProjectChange_project_company_advantages] = self.info.advantages
        detailDic[kHttpParamKey_ApplyProjectChange_project_company_businessPlan] = self.info.businessPlan
        
        
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_needMoreService] = self.info.needMoreService != "1" ? false:true
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_needShow] = self.info.needShow != "1" ? false:true
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_needIncubator] = self.info.needIncubator != "1" ? false:true
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_depthRecommend] = self.info.depthRecommend != "1" ? false:true
        projectDic[kHttpParamKey_ApplyProjectChange_project_detail] = detailDic
        
        self.componentString("所属行业", value: self.info.industry!)
        self.componentString("融资阶段", value: self.info.amountPhase!)
        self.componentString("所在地区", value: self.info.Inthearea!)
        
        self.catList.addObject(self.catDicAppend("投资币种", str2: self.info.currency))
        self.catList.addObject(self.catDicAppend("上过节目", str2: self.info.hasShow))
        if self.info.isBusinessPlan != nil {
            self.catList.addObject(self.catDicAppend("有商业计划书", str2: self.info.isBusinessPlan))
        }
        projectDic[kHttpParamKey_ApplyProjectChange_project_type] = "PROJECT"
        
        projectDic[kHttpParamKey_ApplyProjectChange_project_cats] = self.catList
        dic[kHttpParamKey_ApplyProjectChange_project] = projectDic
        
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url == ",cmd.getUrl())
        cmd.execute()
    }
    func putHttpChangeMyProjectResponse(result:RequestResult){
        let r:DSHttpApplyProjectChangeResult = result as! DSHttpApplyProjectChangeResult
        if r.isOk() {
            //self.showAttention()
            DSAccountInfo.sharedInstance().productStatus = "CHECKING"
            SMToast("正在审核，需要一个工作日")
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    //MARK:---拆分字符串 合并数组
    func componentString(title:String,value:String){
        let list:NSArray = value.componentsSeparatedByString(" ")
        for index in 0..<list.count {
           self.catList.addObject(self.catDicAppend(title, str2: list[index] as? String))
        }
    }
    
    
    func showAttention(){
        showAlert("修改项目信息需要重新审核，\n您确定要修改吗？", message: "", titleCancelBtn: "取消", titleSecondBtn: "确定", blockOtherBtn: {
            self.putHttpChangeMyProjectRequire()
        })
    }
    
    func catDicAppend(str1:String!,str2:String?)->(NSMutableDictionary){
       
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_ApplyProjectChange_project_cats_catName] = str1
        dic[kHttpParamKey_ApplyProjectChange_project_cats_description] = self.judgeString(str2)
        return dic
    }
    
    func judgeString(str:String?)->(String!){
        if str != nil {
            return str
        }
        return ""
    }
    
    //MARK:---------------加载项目详细------------------
    func getHttpProjectdetailsRequire(){
        let cmd:HttpCommand = DSHttpProductsDetailsCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {(result:RequestResult!,useInfo:AnyObject!)->() in
            self.httpProjectdetailsResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        
        dic[kHttpParamKey_productsDetails_id] = DSAccountInfo.sharedInstance().productsId
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block:block,withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    
    func tihuanId() -> (String) {
        if self.isMessage == false {
            return DSAccountInfo.sharedInstance().productsId!
        }else{
            return self.projectId
        }
    }
    
    func httpProjectdetailsResponse(result:RequestResult){
        let r:DSHttpProductsDetailsResult = result as! DSHttpProductsDetailsResult
        if result.isOk() {
            self.getHttptData(r.getAllContent())
            self.layout.constant = 0
        }
    }
    func getHttptData(data:NSMutableArray){
        self.info = data[0] as? DSProductsDetailsInfo
        self.parseTheData()
        self.initTableView()
        self.tableView .reloadData()
    }
    
    //---保存数据到catsData中
    func parseTheData(){
        if self.info.industry != nil {
            self.addCatsData("所属行业", httpData: self.info!.industry!)
        }
        if self.info.amountPhase != nil {
            self.addCatsData("融资阶段", httpData: self.info!.amountPhase!)
        }
        if self.info.Inthearea != nil {
           self.addCatsData("所在地区", httpData: self.info!.Inthearea!)
        }
        if self.info.currency != nil {
            self.addCatsData("币种", httpData: self.info!.currency!)
        }
    }
    func addCatsData(catName:String,httpData:String?){
        let dict:NSDictionary = ["catName":catName,"description":httpData!]
        self.catsData .addObject(dict)
    }
    
    
}
