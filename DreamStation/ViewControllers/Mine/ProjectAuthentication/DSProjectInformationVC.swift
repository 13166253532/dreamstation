//
//  DSProjectInformationVC.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/16.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit
private let STRING_MINE = "DSMineStrings"
class DSProjectInformationVC: HTBaseViewController {
    
    @IBOutlet var tableView: UITableView!
    var companyDic:NSDictionary!
    var delegate:DSProjectInformationDelegate!
    var dataSource:NSMutableArray = NSMutableArray()
    var dataDic:NSMutableDictionary = NSMutableDictionary()
    var catsData:NSMutableArray = NSMutableArray()

    var passBlock:passParameterBlock!
    var isGetService:String!
    var isWantToShow:String!
    var isIncubator:String!
    //是否是从我的页面跳转
//    var isMyProject = false
//    var info:DSProductsDetailsInfo!
    
    
    var industryValue:String?   //所属行业
    var stageValue:String?      //融资阶段
    var moneyValue:String?      //币种
    var areaValue:String?       //所在地区
    var wordValue:String?       //一句话标题
    var videoValue:String?      //视频
    var moneyAmount:String?     //融资金额
    var ratioValue:String?      //控后股比
    var brightValue:String?     //投资亮点
    var extractionCode:String?  //提取码
    var removeIndex:String?
    
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSProjectInformationVC", bundle: nil)
        let vc:DSProjectInformationVC=storyboard.instantiateViewControllerWithIdentifier("DSProjectInformationVC")as! DSProjectInformationVC
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTitleBar()
//        if self.isMyProject == false {
        self.initTableView()
//        }else{
//          self.getHttpProjectdetailsRequire()
//        }
        
    }

    override func initTitleBar() {
        super.initTitleBar()
//        if self.isMyProject == false {
        self.title = loadString("MineProjectInformation", tableId: STRING_MINE)
//        }else{
//           self.title = loadString("MineMyProgram", tableId: STRING_MINE)
//        }
    }
    
//    //MARK:---------------加载项目详细------------------
//    func getHttpProjectdetailsRequire(){
//        let cmd:HttpCommand = DSHttpProductsDetailsCmd.httpCommandWithVersion(PHttpVersion_v1)
//        let block:httpBlock = {(result:RequestResult!,useInfo:AnyObject!)->() in
//            self.httpProjectdetailsResponse(result)
//        }
//        let dic:NSMutableDictionary = NSMutableDictionary()
//        dic[kHttpParamKey_productsDetails_id] = DSAccountInfo.sharedInstance().productsId
//        cmd.requestInfo = dic as [NSObject:AnyObject]
//        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block:block,withUserInfo: nil)
//        cmd.completeDelegate=completeDelegate
//        
//        print("url==%@",cmd.getUrl())
//        cmd.execute()
//    }
//    func httpProjectdetailsResponse(result:RequestResult){
//        
//        let r:DSHttpProductsDetailsResult = result as! DSHttpProductsDetailsResult
//        if result.isOk() {
//            self.getHttptData(r.getAllContent())
//            
//        }
//    }
//    func getHttptData(data:NSMutableArray){
//        self.info = data[0] as? DSProductsDetailsInfo
//        self.industryValue = self.info?.industry
//        self.stageValue = self.info?.amountPhase
//        self.moneyValue = self.info?.currency
//        self.areaValue = self.info?.Inthearea
//        self.wordValue = self.info?.brief
//        self.videoValue = self.info?.videoUrl
//        self.initTableView()
//        self.tableView .reloadData()
//    }
    
    
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
        xinfo.detailValue = "请输入"
        xinfo.numKeyboardType = true
        xinfo.suffixValue = "万元"
        xinfo.block = {[weak self](value:AnyObject)->Void in
            xinfo.text = value as? String
            self?.moneyAmount = xinfo.text
            self!.dataDic.setValue(value, forKey: "amount")
        }
        list.addObject(xinfo)

        self.initFourthData(list,title: "币种")
        
        let xinfo1:DSProjectNinthCellModel = DSProjectNinthCellModel()
        xinfo1.className = "DSProjectNinthCell"
        xinfo1.titleValue = "投后股比"
        xinfo1.numKeyboardType = true
        xinfo1.detailValue = "请输入"
        xinfo1.suffixValue = "%"
        xinfo1.block = {[weak self](value:AnyObject?)->Void in
            xinfo1.text = value as? String
            if xinfo1.text != nil || xinfo1.text?.characters.count != 0 {
                if self?.isNegativeNumber(xinfo1.text!) == false{
                    xinfo1.text = nil
                    self?.tableView.reloadData()
                }else{
                    self?.ratioValue = xinfo1.text
                    self?.dataDic.setValue(value, forKey: "ratio")
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
//        xinfo.detailValue = 
        xinfo.placeholderValue = "输入内容不含项目名，体现项目亮点"
        xinfo.isHidden = false
        xinfo.isCanEdit = true
        xinfo.block = {[weak self](value:AnyObject)->Void in
            xinfo.detailValue = value as? String
            self?.wordValue = value as? String
            self?.dataDic.setValue(value, forKey: "brief")
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
                    self.showXWAlertView(loadString("MineProjectAttention1", tableId: STRING_MINE))
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
//        xinfo.detailValue = 
        if SCREEN_WHIDTH() <= 320 {
            xinfo.placeholderValue = "输入项目视频与BP的\n下载链接"
        }else{
           xinfo.placeholderValue = "输入项目视频与BP的下载链接"
        }
        xinfo.isHidden = false
        xinfo.block = {[weak self](value:AnyObject?)->Void in
            xinfo.detailValue = value as? String
            self?.videoValue = value as? String
            self?.dataDic.setValue(value, forKey: "videoUrl")
        }
        list.addObject(xinfo)
        let xinfo2:DSProjectEleventhCellModel = DSProjectEleventhCellModel()
        xinfo2.className = "DSProjectEleventhCell"
        xinfo2.titleValue = "提取码"
        //        xinfo.detailValue =
        xinfo2.placeholderValue = "输入提取码"
        xinfo2.isHidden = false
        xinfo2.block = {[weak self](value:AnyObject?)->Void in
            xinfo2.detailValue = value as? String
            self?.extractionCode = value as? String
            self?.dataDic.setValue(value, forKey: "extractionCode")
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
        xinfo.isAn = false
        self.isGetService = "false"
        xinfo.isHidden = true
        xinfo.block = {(value:AnyObject?)->Void in
            if value as! Bool == true {
                self.isGetService = "true"
                //self.setValue("true", forKey: "needMoreService")
            }else{
                self.isGetService = "false"
                //self.setValue("false", forKey: "needMoreService")
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
        xinfo.titleValue = "希望上《梦想下一站》电视节目"
        xinfo.isAn = false
        self.isWantToShow = "false"
        xinfo.isHidden = true
        xinfo.block = {(value:AnyObject?)->Void in
            if value as! Bool == true {
                self.isWantToShow = "true"
                //self.dataDic.setValue("true", forKey: "needShow")
            }else{
                self.isWantToShow = "false"
                //self.dataDic.setValue("false", forKey: "needShow")
            }
        }
        list.addObject(xinfo)
        
        let xinfo2:DSProjectEighthCellModel = DSProjectEighthCellModel()
        xinfo2.className = "DSProjectEighthCell"
        xinfo2.titleValue = "希望入住孵化器"
        xinfo2.isAn = false
        self.isIncubator = "false"
        xinfo2.isHidden = true
        xinfo2.block = {(value:AnyObject?)->Void in
            if value as! Bool == true {
                self.isIncubator = "true"
                //self.dataDic.setValue("true", forKey: "needIncubator")
            }else{
                self.isIncubator = "false"
                 //self.dataDic.setValue("false", forKey: "needIncubator")
            }
        }
        list.addObject(xinfo2)
        self.dataSource.addObject(list)
    }
    
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
        
        if self.industryValue == nil||self.industryValue?.characters.count == 0{
            SMToast("所属行业为空")
        }else if self.stageValue == nil||self.stageValue?.characters.count == 0{
            SMToast("融资阶段为空")
        }else if self.videoValue == nil||self.videoValue?.characters.count==0{
            SMToast("融资金额为空")
        }else if self.moneyValue == nil||self.moneyValue?.characters.count == 0{
            SMToast("币种为空")
        }else if self.videoValue == nil||self.videoValue?.characters.count==0{
            SMToast("投后股比为空")
        }else if self.areaValue == nil||self.areaValue?.characters.count == 0{
            SMToast("所在地区为空")
        }else if self.wordValue == nil||self.wordValue?.characters.count==0{
            SMToast("标题为空")
        }else if self.videoValue == nil||self.videoValue?.characters.count==0{
            SMToast("视频为空")
        }else if self.extractionCode == nil||self.extractionCode?.characters.count==0{
            SMToast("提取码为空")}
        else{
            let list:NSArray = self.industryValue!.componentsSeparatedByString(",")
            if list.count>3{
                SMToast("所属行业至多选三项")
            }else{
                 self.httpProjectInformationRequire()
            }
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

extension DSProjectInformationVC{
    
    //MARK:-----认证项目
    func httpProjectInformationRequire(){
        let cmd:DSHttpAddApplyProjectCmd = DSHttpAddApplyProjectCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpAddApplyProjectCmd
        let block:httpBlock = {[weak self](result:RequestResult!,useInfo:AnyObject!)->() in
            self!.httpProjectInformationResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_AddApplyProject_user_id] = DSAccountInfo.sharedInstance().personId
//        dic[kHttpParamKey_AddApplyProject_role_name] = DSAccountInfo.sharedInstance().role
        dic[kHttpParamKey_AddApplyProject_role_name] = "PROVIDER"
        dic[kHttpParamKey_AddApplyProject_applyLogin] = DSAccountInfo.sharedInstance().phoneNum
        
        let projectDic:NSMutableDictionary = NSMutableDictionary()
        
        let detailDic:NSMutableDictionary = NSMutableDictionary()
        detailDic[kHttpParamKey_AddApplyProject_project_detail_amount] = self.dataDic["amount"]
        detailDic[kHttpParamKey_AddApplyProject_project_detail_ratio] = self.dataDic["ratio"]
        detailDic[kHttpParamKey_AddApplyProject_project_detail_brief] = self.dataDic["brief"]
        //detailDic[kHttpParamKey_AddApplyProject_project_detail_videoUrl] = self.dataDic["videoUrl"]
        detailDic[kHttpParamKey_AddApplyProject_project_detail_downloadLink] = self.dataDic["videoUrl"]
        detailDic[kHttpParamKey_AddApplyProject_project_detail_needMoreService] = self.isGetService
        detailDic[kHttpParamKey_AddApplyProject_project_detail_needShow] = self.isWantToShow
        detailDic[kHttpParamKey_AddApplyProject_project_detail_needIncubator] = self.isIncubator
        detailDic[kHttpParamKey_AddApplyProject_project_detail_extractionCode] = self.extractionCode
        projectDic[kHttpParamKey_AddApplyProject_project_detail] = detailDic
        projectDic[kHttpParamKey_AddApplyProject_project_cats] = self.catsArray.updateCats(self.catsData)
        projectDic[kHttpParamKey_AddApplyProject_project_company] = self.companyDic
        
        dic[kHttpParamKey_AddApplyProject_project] = projectDic
        
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
        
    }
    
    func httpProjectInformationResponse(result:RequestResult){
        let r:DSHttpAddApplyProjectResult = result as! DSHttpAddApplyProjectResult
        if result.isOk(){
            let arr = r.getData()
            let aa:DSAddApplyProjectInfo = arr.lastObject as! DSAddApplyProjectInfo
            print(aa.id)
//            print(aa.user_id)
//            print(aa.status)
            DSAccountInfo.sharedInstance().AuthenticationStatus = "CHECKING"
            SMToast("项目信息已提交，将在一个工作日内给您反馈")
            self.navigationController?.popToRootViewControllerAnimated(true)
        }else{
            print("false")
            SMToast("请查看当前网络状态！")
        }
    }

    //MARK:所属行业
    func initFirstData(arr:NSMutableArray,title:String){
        let list:NSArray = self.inPlistData("DSInvestmentAgencyFirst.plist")
        self.initTheInfo(arr, title: title, arrayData: list, type: 0, detailValue: nil,placeholder: "请选择")
    }

    //MARK:融资阶段
    func initSecondData(arr:NSMutableArray,title:String){
        let list:NSArray = self.inPlistData("DSInvestmentAgencySecond.plist")
        self.initTheInfo(arr, title: title, arrayData: list, type: 1, detailValue: nil,placeholder: "请选择")
    }
    
    //MARK:所在地区
    func initThirdData(arr:NSMutableArray,title:String){
        let list:NSArray = self.inPlistData("DSInvestmentAgencyThird.plist")
        self.initTheInfo(arr, title: title, arrayData: list, type: 2, detailValue: nil,placeholder: "请选择")
    }
    
    //MARK:币种
    func initFourthData(arr:NSMutableArray,title:String){
        let list:NSArray = self.inPlistData("DSInvestmentAgencyFourth.plist")
        self.initTheInfo(arr, title: "投资币种", arrayData: list, type: 3, detailValue: nil,placeholder: "请选择")
}
    
    func inPlistData(plistString:String)->(NSArray){
        let string:String = NSBundle.mainBundle().pathForResource(plistString, ofType: nil)!
        let plistArray:NSArray = NSArray.init(contentsOfFile: string)!
        return plistArray
    }
    
    
    func initTheInfo(list:NSMutableArray,title:String,arrayData:NSArray,type:Int32,detailValue:String?,placeholder :String){
        let info:DSAgencyThirdCellModel = DSAgencyThirdCellModel()
        info.className = "DSAgencyThirdCell"
        info.titleValue = title
        info.placdholder = placeholder
        info.detailValue = detailValue
        info.isHidden = false
        info.block = {[weak self] in
            let retList:NSArray = (self?.takeDescription(title, catsDataList: self!.catsData))!
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
                
                //判断未选中任何选项时，仍旧显示placdholder
                if value as! String == ""{
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
            let dic:NSMutableDictionary = catsDataList[index] as! NSMutableDictionary
            if title == dic["catName"] as! String {
                let str = dic["description"] as! String
                desList = str.componentsSeparatedByString(",")
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
                    allString = allString.stringByAppendingFormat(","+str)
                }
                if allString != ""{
                    self?.inSaveData(type, value:allString)
                    self!.passBlock(allString)
                }
            }else{
                self!.inSaveData(type, value: "")
                self!.passBlock("")
            }
        }
    }
    
    func inSaveData(type:Int32,value:String){
        
        switch type {
        case 0:
            self.industryValue = value
            break
        case 1:
            self.stageValue = value
            break
        case 2:
            self.areaValue = value
            break
        case 3:
            self.moneyValue = value
            break
        default:break
        }
    }
}


class DSProjectInformationDelegate: HTBaseTableViewDelegate {
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 65
        }else if indexPath.section == 3&&indexPath.row == 2{
            return 65
        }else if indexPath.section == 6{
            return 60
        }else if indexPath.section == 4 && indexPath.row == 1{
            return 30
        }
        return 44
    }
 
     func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 4 {
            return "    其他服务要求"
        }
        return nil
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if (section==0){
            return 1
        }else if (section == 4){
            return 30
        }
        return 10
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel!.font = UIFont.systemFontOfSize(12)
        header.textLabel!.textColor = grayColor
    }
}
