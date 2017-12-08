//
//  DSPersonalInvestmentVC.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/2.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

enum InvestmentType:Int {
    case Avatar = 1
    case FrontCardID = 2
    case BackCardID = 3
    case PersonalAssets = 4
}

class DSPersonalInvestmentVC: HTBaseViewController {

    @IBOutlet var tableView: UITableView!
    
    var investmentType:InvestmentType = .Avatar
    var delegate:DSPersonalInvestmentDelegate!
    var dataSource:NSMutableArray! = NSMutableArray()
    var dataDic:NSMutableDictionary = NSMutableDictionary()
    var catsData:NSMutableArray = NSMutableArray()
    var passBlock:passParameterBlock!
    var imageBlock:passParameterBlock!
    var picker:pickView = pickView()
    var nameValue:String?
    var cardIDValue:String?
    var followValue:String?
    var stageValue:String?
    var areaValue:String?
    var moneyValue:String?
    var minValue:String?
    var maxValue:String?
    var avatarValue:String?
    var frontCardIDValue:String?
    var backCardIDValue:String?
    var personalAssetsValue:String?

    var removeIndex:String?


    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSPersonalInvestmentVC", bundle: nil)
        let vc:DSPersonalInvestmentVC=storyboard.instantiateViewControllerWithIdentifier("DSPersonalInvestmentVC")as! DSPersonalInvestmentVC
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
        self.title = loadString("DSPersonalTitle", tableId: TITLESTRINGTABLEID)
    }
    
    func initTableView(){
        
        self.initTableViewData()
        self.delegate = DSPersonalInvestmentDelegate()
        self.delegate.dataSource = self.dataSource
        registerCell(self.tableView, cell: DSAgencyFirstCell.self)
        registerCell(self.tableView, cell: DSAgencySecondCell.self)
        registerCell(self.tableView, cell: DSAgencyThirdCell.self)
        registerCell(self.tableView, cell: DSAgencyFourthCell.self)
        registerCell(self.tableView, cell: DSAgencyFifthCell.self)
        registerCell(self.tableView, cell: DSAgencySixthCell.self)
        registerCell(self.tableView, cell: DSAgencySeventhCell.self)
        self.tableView.delegate = self.delegate
        self.tableView.dataSource = self.delegate
        self.tableView.backgroundColor = loginBg_Color
        
    }
    
    func initTableViewData(){
        
        self.initFirstSectionData()
        self.initSecondSectionData()
        self.initThirdSectionData()
        self.initFourthSectionData()
        self.initfifthSectionData()
        
    }
    
    func initFirstSectionData(){
    
        let list:NSMutableArray = NSMutableArray()
        
        let firstXinfo:DSAgencyFirstCellModel = DSAgencyFirstCellModel()
        firstXinfo.className = "DSAgencyFirstCell"
        firstXinfo.titleValue = "姓名"
        firstXinfo.placeholderValue = "请输入"
        firstXinfo.isHidden = false
        firstXinfo.isCanEdit = true
        firstXinfo.block = {[weak self](value:AnyObject)->Void in
            self!.dataDic.setValue(value, forKey: "name")
            self?.nameValue = value as? String
            firstXinfo.detailValue = value as? String
        }
        list.addObject(firstXinfo)
        
        let secondXinfo:DSAgencySecondCellModel = DSAgencySecondCellModel()
        secondXinfo.className = "DSAgencySecondCell"
        secondXinfo.titleValue = "头像"
        secondXinfo.detailValue = "Agency_logo"
        secondXinfo.isHidden = true
        secondXinfo.block = {[weak self] in
            self?.addImageAction()
            self?.imageBlock = {[weak self](value:AnyObject?)in
                secondXinfo.backImage = value as! UIImage
                self?.httpPersonalInvestmentUploadFileRequire(value as! UIImage, type: .Avatar)
            }
        }
        list.addObject(secondXinfo)
        
        let thirdXinfo:DSAgencyFirstCellModel = DSAgencyFirstCellModel()
        thirdXinfo.className = "DSAgencyFirstCell"
        thirdXinfo.titleValue = "身份证号码"
        thirdXinfo.placeholderValue = "请输入"
        thirdXinfo.isHidden = false
        thirdXinfo.isCanEdit = true
        thirdXinfo.block = {[weak self](value:AnyObject)->Void in
            self!.dataDic.setValue(value, forKey: "card_no")
            self?.cardIDValue = value as? String
            thirdXinfo.detailValue = value as? String
        }
        list.addObject(thirdXinfo)
        
        self.intFrontCardIDData(list)
        self.intBackCardIDData(list)
        self.intPersonalAssetsData(list)
        
        self.dataSource.addObject(list)
    }
    
    func initSecondSectionData(){
    
        let list:NSMutableArray = NSMutableArray()
        
        let titleList:NSArray = ["微信(推荐)","LinkedIn(推荐)"]
        let titleKeyList:NSArray = ["wechat","linkedin"]
        
        for index in 0..<titleList.count {
            let xinfo:DSAgencyFirstCellModel = DSAgencyFirstCellModel()
            xinfo.className = "DSAgencyFirstCell"
            xinfo.titleValue = titleList.objectAtIndex(index) as! String
            xinfo.placeholderValue = "请输入"
            xinfo.isHidden = true
            xinfo.isCanEdit = true
            xinfo.block = {[weak self](value:AnyObject)->Void in
                self!.dataDic.setValue(value, forKey: titleKeyList.objectAtIndex(index) as! String)
                xinfo.detailValue = value as? String
            }
            list.addObject(xinfo)
        }
        self.dataSource.addObject(list)
        
    }
    
    func initThirdSectionData(){
        
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
        xinfo.block = {[weak self] in
            
            let pick:CCPPickerViewTwo = CCPPickerViewTwo.init(pickerViewWithCenterTitle: "单笔可投额度（万）", andCancel: "取消", andSure: "确定")
            
            pick .pickerVIewClickCancelBtnBlock({
                
                }, sureBtClcik: { (firstString, secondString, statusString) in
                    xinfo.firstValue = firstString
                    xinfo.secondValue = secondString
                    self!.dataDic.setValue(firstString, forKey: "investMin")
                    self!.dataDic.setValue(secondString, forKey: "investMax")
                    self!.tableView.reloadData()
                    self?.minValue = firstString
                    self?.maxValue = secondString
            })
            
        }
        
        list.addObject(xinfo)
        self.dataSource.addObject(list)
    }

    func initFourthSectionData(){
        
        let titleList:NSArray = ["简介","过往案例"]
        let placeHolderList:NSArray = ["请输入不含联系方式，150字以内文字介绍","请输入150字以内的过往案例介绍"]
        let titleKeyList:NSArray = ["introduction","cases"]
        
        for index in 0..<titleList.count {
            
            let list:NSMutableArray = NSMutableArray()
            let xinfo:DSAgencyFourthCellModel = DSAgencyFourthCellModel()
            xinfo.className = "DSAgencyFourthCell"
            xinfo.contBlock = {
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
    
    func initfifthSectionData(){
    
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
        if self.nameValue == nil||self.nameValue?.characters.count == 0{
            SMToast("姓名为空")
        }else if self.cardIDValue == nil||self.cardIDValue?.characters.count == 0{
            SMToast("身份证号码为空")
        }else if self.frontCardIDValue == nil||self.frontCardIDValue?.characters.count==0{
            SMToast("身份证正面为空")
        }else if self.backCardIDValue == nil||self.backCardIDValue?.characters.count==0{
            SMToast("身份证背面为空")
        }else if self.personalAssetsValue == nil||self.personalAssetsValue?.characters.count==0{
            SMToast("个人资产证明为空")
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
            self.httpPersonalInvestmentRequire()
        }
//        self.httpPersonalInvestmentRequire()
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

extension DSPersonalInvestmentVC{

    //MARK:-------uploadFile接口
    func httpPersonalInvestmentUploadFileRequire(image:UIImage,type:InvestmentType){
        let cmd:DSHttpUploadFileCmd = DSHttpUploadFileCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpUploadFileCmd
        let block:httpBlock = {[weak self](result:RequestResult!,useInfo:AnyObject!)->()in
            self?.httpPersonalInvestmentUploadFileResponse(result, type: type)
        }
        cmd.fileName = "investment.jpg"
        cmd.keyName = "file"
        cmd.fileData = UIImagePNGRepresentation(image)
        
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpPersonalInvestmentUploadFileResponse(result:RequestResult,type:InvestmentType){
        let r:DSHttpUploadFileResult = result as! DSHttpUploadFileResult
        if r.isOk(){
            self.tableView.reloadData()
            switch type {
            case .Avatar:
                self.avatarValue = r.getUuid().stringByAppendingFormat("."+r.getSuffix())
                break
            case .FrontCardID:
                self.frontCardIDValue = r.getUuid().stringByAppendingFormat("."+r.getSuffix())
                break
            case .BackCardID:
                self.backCardIDValue = r.getUuid().stringByAppendingFormat("."+r.getSuffix())
                break
            case .PersonalAssets:
                self.personalAssetsValue = r.getUuid().stringByAppendingFormat("."+r.getSuffix())
                break
            }
        }else{
            SMToast("请查看当前网络状态！")
        }
    }
    
    //MARK:-------认证信息接口
    func httpPersonalInvestmentRequire(){
    
        let cmd:HttpCommand = DSHttpAddApplyAccountCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {
            (result:RequestResult!,useInfo:AnyObject!)->Void in
            self.httpPersonalInvestmentResponse(result)
        }
        
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        let dic:NSMutableDictionary = NSMutableDictionary()
        
        dic[kHttpParamKey_AddApplyAccount_user_id] = DSAccountInfo.sharedInstance().personId
        dic[kHttpParamKey_AddApplyAccount_role_name] = "INDIVIDUAL"
        dic[kHttpParamKey_AddApplyAccount_applyLogin] = DSAccountInfo.sharedInstance().phoneNum
        
        let institutionDic:NSMutableDictionary = NSMutableDictionary()
        institutionDic[kHttpParamKey_AddApplyAccount_institution_name] = self.dataDic["name"]
        institutionDic[kHttpParamKey_AddApplyAccount_institution_avatar] = self.avatarValue
        institutionDic[kHttpParamKey_AddApplyAccount_institution_card_no] = self.dataDic["card_no"]
        institutionDic[kHttpParamKey_AddApplyAccount_institution_idCardFrontUrl] = self.frontCardIDValue
        institutionDic[kHttpParamKey_AddApplyAccount_institution_idCardBackUrl] = self.backCardIDValue
        institutionDic[kHttpParamKey_AddApplyAccount_institution_individualPropertyUrl] = self.personalAssetsValue
        institutionDic[kHttpParamKey_AddApplyAccount_institution_wechat] = self.dataDic["wechat"]
        institutionDic[kHttpParamKey_AddApplyAccount_institution_Linkedin] = self.dataDic["linkedin"]
        
        institutionDic[kHttpParamKey_AddApplyAccount_institution_cats] = self.catsArray.updateCats(self.catsData)
        
        institutionDic[kHttpParamKey_AddApplyAccount_institution_investMin] = self.dataDic["investMin"]
        institutionDic[kHttpParamKey_AddApplyAccount_institution_investMax] = self.dataDic["investMax"]
        institutionDic[kHttpParamKey_AddApplyAccount_institution_introduction] = self.dataDic["introduction"]
        institutionDic[kHttpParamKey_AddApplyAccount_institution_cases] = self.dataDic["cases"]
    
        dic[kHttpParamKey_AddApplyAccount_institution] = institutionDic
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpPersonalInvestmentResponse(result:RequestResult){
        if result.isOk() {
//            showAlert("", message: "验证信息已提交，将在一个工作日内给您反馈", titleCancelBtn: "取消", titleSecondBtn: "确定", blockOtherBtn: {
//                DSAccountInfo.sharedInstance().isAuthentication = true
//                DSAccountInfo.sharedInstance().AuthenticationStatus = "CHECKING"
//                self.navigationController?.popToRootViewControllerAnimated(true)
//                self.tableView.reloadData()
//            })
           SMToast("验证信息已提交，将在一个工作日内给您反馈")
            DSAccountInfo.sharedInstance().isAuthentication = true
            DSAccountInfo.sharedInstance().AuthenticationStatus = "CHECKING"
            self.navigationController?.popToRootViewControllerAnimated(true)
            self.tableView.reloadData()
        }else{
            SMToast("请查看当前网络状态！")
        }
    }
    //MARK:关注领域
    func initFirstData(arr:NSMutableArray,title:String){
        let list:NSArray = self.inPlistData("DSInvestmentAgencyFirst.plist")
        self.initTheInfo(arr, title: title, arrayData: list, type: 0)
    }
    
    //MARK:投资阶段
    func initSecondData(arr:NSMutableArray,title:String){
        let list:NSArray = self.inPlistData("DSInvestmentAgencySecond.plist")
        self.initTheInfo(arr, title: title, arrayData: list, type: 1)
    }
    
    //MARK:投资地域
    func initThirdData(arr:NSMutableArray,title:String){
        let list:NSArray = self.inPlistData("DSInvestmentAgencyThird.plist")
        self.initTheInfo(arr, title: title, arrayData: list, type: 2)
    }
    
    //MARK:主投币种
    func initFourthData(arr:NSMutableArray,title:String){
        let list:NSArray = self.inPlistData("DSInvestmentAgencyFourth.plist")
        self.initTheInfo(arr, title: title, arrayData: list, type: 3)
    }
    
    func inPlistData(plistString:String)->(NSArray){
        let string:String = NSBundle.mainBundle().pathForResource(plistString, ofType: nil)!
        let plistArray:NSArray = NSArray.init(contentsOfFile: string)!
        return plistArray
    }
    
    
    func initTheInfo(list:NSMutableArray,title:String,arrayData:NSArray,type:Int32){
        let info:DSAgencyThirdCellModel = DSAgencyThirdCellModel()
        info.className = "DSAgencyThirdCell"
        info.titleValue = title
        info.placdholder = "请选择"
        info.isHidden = false
        info.block = {[weak self] in
            let retList:NSArray = (self?.takeDescription(title, catsDataList: self!.catsData))!
            self!.inCollectionView(title, arrayData: arrayData, type: type, selectedList: retList)
//            self!.inCollectionView(title, arrayData:arrayData, type: type)
            self?.passBlock = {[weak self](value:AnyObject?) in

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
                dic.setValue(value, forKey: "description")
                dic.setValue(info.titleValue, forKey: "catName")
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
                self!.inSaveData(type, value:"")
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
    
    //MARK:--------身份证正面
    func intFrontCardIDData(arr:NSMutableArray){
        self.intTheInfo1(arr, title: "身份证正面", hidden: false, type: .FrontCardID)
    }
    //MARK:--------身份证背面
    func intBackCardIDData(arr:NSMutableArray){
        self.intTheInfo1(arr, title: "身份证背面", hidden: false, type: .BackCardID)
    }
    //MARK:--------个人资产证明
    func intPersonalAssetsData(arr:NSMutableArray){
        self.intTheInfo1(arr, title: "个人资产证明", hidden: false, type: .PersonalAssets)
    }
    
    func intTheInfo1(arr:NSMutableArray,title:String,hidden:Bool,type:InvestmentType){
        let xinfo:DSAgencySeventhCellModel = DSAgencySeventhCellModel()
        xinfo.className = "DSAgencySeventhCell"
        xinfo.titleValue = title
        xinfo.isHidden = hidden
        xinfo.block = {[weak self] in
            self?.addImageAction()
            self?.imageBlock = {[weak self](value:AnyObject?)in
                xinfo.backImage = value as! UIImage
                self?.httpPersonalInvestmentUploadFileRequire(value as! UIImage, type: type)
            }
        }
        arr.addObject(xinfo)
    }
}

class DSPersonalInvestmentDelegate: HTBaseTableViewDelegate {
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0&&indexPath.row == 1||indexPath.section == 0&&indexPath.row == 3||indexPath.section == 0&&indexPath.row == 4||indexPath.section == 0&&indexPath.row == 5{
            return 80
        }else if indexPath.section == 3||indexPath.section == 4{
            return 150
        }else if indexPath.section == 5{
            return 60
        }
        
        return 44
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) { //ios8
      
    }
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.backgroundColor = UIColor.clearColor()
    }
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor=UIColor.clearColor()
    }
}
