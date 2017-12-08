//
//  DSInvestmentAgencyVC.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/2.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

enum chooseType:Int32 {
    case FOLLOW = 0
    case STAGE = 1
    case AREA = 2
    case MONEY = 3
}

enum ImageType:Int {
    case Logo = 1       //logo
    case License = 2    //执照
}

class DSInvestmentAgencyVC: HTBaseViewController {

    @IBOutlet var tableView: UITableView!
    
    var choosetype:chooseType = .FOLLOW
    var imageType:ImageType = .Logo
    var licenceUrl:String?
    var logoUrl:String?
    
    var delegate:DSInvestmentAgencyDelegate!
    var dataSource:NSMutableArray = NSMutableArray()
    var dataDic:NSMutableDictionary = NSMutableDictionary()
    var catsData:NSMutableArray = NSMutableArray()
    var passBlock:passParameterBlock!
    var returnBlock:passParameterBlock!
    var imageBlock:passParameterBlock!
    var picker:pickView = pickView()
    
    var companyValue:String?
    var licenseValue:String?
    var phoneValue:String?
    var mailValue:String?
    var addressValue:String?
    var followValue:String?
    var stageValue:String?
    var areaValue:String?
    var moneyValue:String?
    var maxValue:String?
    var minValue:String?

    var removeIndex:String?


    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSInvestmentAgencyVC", bundle: nil)
        let vc:DSInvestmentAgencyVC=storyboard.instantiateViewControllerWithIdentifier("DSInvestmentAgencyVC")as! DSInvestmentAgencyVC
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initTitleBar()
        self.initTableView()
    }

    override func initTitleBar() {
        super.initTitleBar()
        self.title = loadString("DSAgencyTitle", tableId: TITLESTRINGTABLEID)
    }
    
    func initTableView(){
    
        self.initTableViewData()
        self.delegate = DSInvestmentAgencyDelegate()
        self.delegate.dataSource = self.dataSource
        registerCell(self.tableView, cell: DSAgencyFirstCell.self)
        registerCell(self.tableView, cell: DSAgencySecondCell.self)
        registerCell(self.tableView, cell: DSAgencyThirdCell.self)
        registerCell(self.tableView, cell: DSAgencyFourthCell.self)
        registerCell(self.tableView, cell: DSAgencyFifthCell.self)
        registerCell(self.tableView, cell: DSAgencySixthCell.self)
        self.tableView.delegate = self.delegate
        self.tableView.dataSource = self.delegate
        self.tableView.backgroundColor = loginBg_Color
    
    }
    
    func initTableViewData(){
    
        self.initFirstSectionData()
        self.initSecondSectionData()
        self.initThirdSectionData()
        self.initFourthSectionData()
    }
    
    func initFirstSectionData(){
    
        let list:NSMutableArray = NSMutableArray()

        self.initCompanyData(list)
        self.initLogoData(list)
        self.initLicenseData(list)
        self.initPhoneData(list)
        self.initMailData(list)
        self.initAddressData(list)
        self.initHomepageData(list)
        
        self.dataSource.addObject(list)
    }
    
    func initSecondSectionData(){
    
        let list:NSMutableArray = NSMutableArray()

        self.initFirstData(list, title: "关注领域")
        self.initSecondData(list, title: "投资阶段")
        self.initThirdData(list, title: "投资地域")
        self.initFourthData(list, title: "主投币种")
        
        let xinfo:DSAgencySixthCellModel = DSAgencySixthCellModel()
        xinfo.className = "DSAgencySixthCell"
        xinfo.firstValue = "请选择"
        xinfo.secondValue = "请选择"
        xinfo.isHidden = false
        xinfo.block = { [weak self] in
            
            let pick:CCPPickerViewTwo = CCPPickerViewTwo.init(pickerViewWithCenterTitle: "单笔可投额度（万）", andCancel: "取消", andSure: "确定")
            
            pick .pickerVIewClickCancelBtnBlock({ 
                
                }, sureBtClcik: {[weak self](firstString, secondString, statusString) in
                    xinfo.firstValue = firstString
                    xinfo.secondValue = secondString
                    self!.dataDic.setObject(firstString, forKey: "companyInvestMin")
                    self!.dataDic.setObject(secondString, forKey: "companyInvestMax")
                    self!.tableView.reloadData()
                    self?.minValue = firstString
                    self?.maxValue = secondString
            })
            
        }
        
        list.addObject(xinfo)
        
        self.dataSource.addObject(list)
        
    }
    
    func initThirdSectionData(){
    
       
        let titleList:NSArray = ["简介","过往案例"]
        let placeHolderList:NSArray = ["请输入不含联系方式，150字以内文字介绍","请输入150字以内的过往案例介绍"]
        let titleKeyList:NSArray = ["introduction","cases"]
        for index in 0..<titleList.count {
            
            let list:NSMutableArray = NSMutableArray()
            let xinfo:DSAgencyFourthCellModel = DSAgencyFourthCellModel()
            xinfo.className = "DSAgencyFourthCell"
            xinfo.contBlock = {[weak self] in
                SMAlertView.showAlert("您所填写内容已超过限制字数！")
            }
            xinfo.titleValue = titleList.objectAtIndex(index) as! String
            xinfo.placeHolder = placeHolderList.objectAtIndex(index) as! String
            xinfo.block = {[weak self](value:AnyObject?)->Void in
                self!.dataDic.setValue(value, forKey: titleKeyList.objectAtIndex(index) as! String)
            }
            list.addObject(xinfo)
            self.dataSource.addObject(list)
        }
    }
    
    func initFourthSectionData(){
    
        let list:NSMutableArray = NSMutableArray()
        let xinfo:DSAgencyFifthCellModel = DSAgencyFifthCellModel()
        xinfo.className = "DSAgencyFifthCell"
        xinfo.titleValue = "下一步"
        xinfo.block = { [weak self] in

            self?.attentionView()
        }
        list.addObject(xinfo)
        self.dataSource.addObject(list)
        
    }
    
    func attentionView(){
        
        if self.companyValue == nil||self.companyValue?.characters.count == 0{
            SMToast("公司名为空")
        }else if self.licenceUrl == nil||self.licenceUrl?.characters.count == 0{
            SMToast("营业执照为空")
        }else if self.phoneValue == nil||self.phoneValue?.characters.count == 0{
            SMToast("总机为空")
        }else if self.mailValue == nil||self.mailValue?.characters.count == 0{
            SMToast("邮箱为空")
        }else if self.addressValue == nil||self.addressValue?.characters.count == 0{
            SMToast("办公地址为空")
        }else if self.followValue == nil||self.followValue?.characters.count==0{
            SMToast("关注领域为空")
        }else if self.stageValue == nil||self.stageValue?.characters.count==0{
            SMToast("投资阶段为空")
        }else if self.areaValue == nil||self.areaValue?.characters.count == 0{
            SMToast("投资地域为空")
        }else if self.moneyValue == nil||self.moneyValue?.characters.count == 0{
            SMToast("主投币种为空")
        }else if self.minValue == nil||self.minValue?.characters.count == 0{
            SMToast("单笔可投额度为空")
        }else if self.maxValue == nil||self.maxValue?.characters.count == 0{
            SMToast("单笔可投额度为空")
        }else{
            self.httpInvestmenAgencyRequire()
        }
//        self.httpInvestmenAgencyRequire()
    }
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DSInvestmentAgencyVC{

    //MARK:uploadFile接口
    func httpInvestmentAgencyUploadFileRequire(image:UIImage,type:ImageType){
        let cmd:DSHttpUploadFileCmd = DSHttpUploadFileCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpUploadFileCmd
        let block:httpBlock = {[weak self](result:RequestResult!,useInfo:AnyObject!)->()in
            self?.httpInvestmentAgencyUploadFileResponse(result, type: type)
        }
        cmd.fileName = "image.jpg"
        cmd.keyName = "file"
        cmd.fileData = UIImagePNGRepresentation(image)
        
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpInvestmentAgencyUploadFileResponse(result:RequestResult,type:ImageType){
        let r:DSHttpUploadFileResult = result as! DSHttpUploadFileResult
        if r.isOk() {
            self.tableView.reloadData()
            switch type {
            case .License:
                    self.licenceUrl = r.getUuid().stringByAppendingFormat("."+r.getSuffix())
                break
            case .Logo:
                    self.logoUrl = r.getUuid().stringByAppendingFormat("."+r.getSuffix())
                break
            }
        }else{
            SMToast("请查看当前网络状态！")
        }
    }
    
    
    //MARK:数据接口
    func httpInvestmenAgencyRequire(){
        
        let institutionDic:NSMutableDictionary = NSMutableDictionary()
        
        institutionDic[kHttpParamKey_AddApplyAccount_institution_company] = self.dataDic["company"]
        institutionDic[kHttpParamKey_AddApplyAccount_institution_logo] = self.logoUrl
        institutionDic[kHttpParamKey_AddApplyAccount_institution_licence] = self.licenceUrl
        institutionDic[kHttpParamKey_AddApplyAccount_institution_phone] = self.dataDic["phone"]
        institutionDic[kHttpParamKey_AddApplyAccount_institution_mail] = self.dataDic["mail"]
        institutionDic[kHttpParamKey_AddApplyAccount_institution_address] = self.dataDic["address"]
        institutionDic[kHttpParamKey_AddApplyAccount_institution_homePage] = self.dataDic["homePage"]
        
        institutionDic[kHttpParamKey_AddApplyAccount_institution_companyCats] = self.componentStringToData(self.catsData)
        institutionDic[kHttpParamKey_AddApplyAccount_institution_companyInvestMin] = self.dataDic["companyInvestMin"]
        institutionDic[kHttpParamKey_AddApplyAccount_institution_companyInvestMax] = self.dataDic["companyInvestMax"]
        institutionDic[kHttpParamKey_AddApplyAccount_institution_introduction] = self.dataDic["introduction"]
        institutionDic[kHttpParamKey_AddApplyAccount_institution_cases] = self.dataDic["cases"]

        let vc:DSPersonalInformationViewController = DSPersonalInformationViewController.createViewController(nil) as! DSPersonalInformationViewController
        vc.InvestmentDic = institutionDic
        self.pushViewController(vc, animated: true)
        
    }

    //MARK:---拆分字符串 合并数组
    func componentStringToData(list:NSMutableArray)->NSMutableArray{
        let returnList:NSMutableArray = NSMutableArray()
        for index in 0..<list.count {
            let dic = list[index] as! NSMutableDictionary
            let resultList:NSArray = dic["description"]!.componentsSeparatedByString(",")
            for index in 0..<resultList.count {
               returnList.addObject(self.catDicAppend(dic["catName"] as! String, str2: resultList[index] as? String))
            }
        }
        return returnList
    }
    
    func catDicAppend(str1:String!,str2:String?)->(NSMutableDictionary){
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_AddApplyAccount_institution_cats_catName] = str1
        dic[kHttpParamKey_AddApplyAccount_institution_cats_description] = str2
        return dic
    }
    
    //MARK:CREAT CELL
    
    //MARK:LOGO
    func initLogoData(arr:NSMutableArray){
        self.initTheInfo1(arr, title: "LOGO", detail: "Agency_logo",hidden:true,type:.Logo)
    }
    
    //MARK:营业执照
    func initLicenseData(arr:NSMutableArray){
        self.initTheInfo1(arr, title: "营业执照或三证合一", detail: "Agency_addImage", hidden: false,type:.License)
    }
    
    func initTheInfo1(arr:NSMutableArray,title:String,detail:String,hidden:Bool,type:ImageType){
        let xinfo:DSAgencySecondCellModel = DSAgencySecondCellModel()
        xinfo.className = "DSAgencySecondCell"
        xinfo.titleValue = title
        xinfo.detailValue = detail
        xinfo.isHidden = hidden
        xinfo.block = {[weak self] in
            self?.addImageAction()
            self?.imageBlock = {(value:AnyObject?)in
                xinfo.backImage = value as! UIImage
                self?.httpInvestmentAgencyUploadFileRequire(value as! UIImage, type: type)
            }
        }
        arr.addObject(xinfo)
    }
    
    //MARK:公司
    func initCompanyData(arr:NSMutableArray){
        self.initTheInfo2(arr, title: "公司名", hidden: false) {[weak self] (value:AnyObject?) in
            self!.dataDic.setValue(value, forKey: "company")
            self?.companyValue = value as? String
        }
    }
    
    //MARK:总机
    func initPhoneData(arr:NSMutableArray){
        self.initTheInfo2(arr, title: "总机", hidden: false) {[weak self] (value:AnyObject?) in
            self!.dataDic.setValue(value, forKey: "phone")
            self?.phoneValue = value as? String
        }
    }
    
    //MARK:邮箱
    func initMailData(arr:NSMutableArray){
        self.initTheInfo2(arr, title: "邮箱", hidden: false) {[weak self] (value:AnyObject?) in
            self!.dataDic.setValue(value, forKey: "mail")
            self?.mailValue = value as? String
        }
    }
    
    //MARK:办公地址
    func initAddressData(arr:NSMutableArray){
        self.initTheInfo2(arr, title: "办公地址", hidden: false) {[weak self] (value:AnyObject?) in
            self!.dataDic.setValue(value, forKey: "address")
            self?.addressValue = value as? String
        }
    }
    
    //MARK:官网
    func initHomepageData(arr:NSMutableArray){
        self.initTheInfo2(arr, title: "官网", hidden: true) {[weak self] (value:AnyObject?) in
            self!.dataDic.setValue(value, forKey: "homePage")
        }
    }
    
    func initTheInfo2(arr:NSMutableArray,title:String,hidden:Bool,block:passParameterBlock){
        
        let xinfo:DSAgencyFirstCellModel = DSAgencyFirstCellModel()
        xinfo.className = "DSAgencyFirstCell"
        xinfo.titleValue = title
        xinfo.placeholderValue = "请输入"
        xinfo.isHidden = hidden
        xinfo.isCanEdit = true
        xinfo.block = {(value:AnyObject?) in
            xinfo.detailValue = value as? String
            block(xinfo.detailValue!)
        }
        arr.addObject(xinfo)
    }
    //MARK:关注领域
    func initFirstData(arr:NSMutableArray,title:String){
        let list:NSArray = self.inPlistData("DSInvestmentAgencyFirst.plist")
        self.initTheInfo3(arr, title: title, arrayData: list, type: 0)
    }
    //MARK:投资阶段
    func initSecondData(arr:NSMutableArray,title:String){
        let list:NSArray = self.inPlistData("DSInvestmentAgencySecond.plist")
        self.initTheInfo3(arr, title: title, arrayData: list, type:1)
    }
    
    //MARK:投资地域
    func initThirdData(arr:NSMutableArray,title:String){
        let list:NSArray = self.inPlistData("DSInvestmentAgencyThird.plist")
        self.initTheInfo3(arr, title: title, arrayData: list, type: 2)
    }
    
    //MARK:主投币种
    func initFourthData(arr:NSMutableArray,title:String){
        let list:NSArray = self.inPlistData("DSInvestmentAgencyFourth.plist")
        self.initTheInfo3(arr, title: title, arrayData: list, type: 3)
    }
    
    func inPlistData(plistString:String)->(NSArray){
        let string:String = NSBundle.mainBundle().pathForResource(plistString, ofType: nil)!
        let plistArray:NSArray = NSArray.init(contentsOfFile: string)!
        return plistArray
    }
    
    
    func initTheInfo3(list:NSMutableArray,title:String,arrayData:NSArray,type:Int32){
        let info:DSAgencyThirdCellModel = DSAgencyThirdCellModel()
        info.className = "DSAgencyThirdCell"
        info.isHidden = false
        info.titleValue = title
        info.placdholder = "请选择"
        info.block = {[weak self] in
            let retList:NSArray = (self?.takeDescription(title, catsDataList: self!.catsData))!
//            self!.inCollectionView(title, arrayData:arrayData, type: type)
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
                    self!.inSaveData(type, value:allString)
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
            self.followValue = value
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

class DSInvestmentAgencyDelegate: HTBaseTableViewDelegate {
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0&&indexPath.row == 1||indexPath.section == 0&&indexPath.row == 2 {
            return 80
        }else if indexPath.section == 2||indexPath.section == 3{
            return 150
        }else if indexPath.section == 4{
            return 60
        }
        return 44
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.backgroundColor = UIColor.clearColor()
    }
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor=UIColor.clearColor()
    }
}

