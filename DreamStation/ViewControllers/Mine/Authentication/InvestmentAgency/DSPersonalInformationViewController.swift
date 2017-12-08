//
//  DSPersonalInformationViewController.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/5.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSPersonalInformationViewController: HTBaseViewController {

    @IBOutlet var tableView: UITableView!
    
    var delegate:DSPersonalInformationDelegate!
    var dataSource:NSMutableArray = NSMutableArray()
    var dataDic:NSMutableDictionary = NSMutableDictionary()
    var catsData:NSMutableArray = NSMutableArray()
    
    var passBlock:passParameterBlock!
    var imageBlock:passParameterBlock!
    var picker:pickView = pickView()
    var nameValue:String?
    var cardNoValue:String?
    var positionValue:String?
    var phoneValue:String?
    var mailValue:String?
    
    var businessCard:String?
    
    var InvestmentDic:NSMutableDictionary = NSMutableDictionary()

    var removeIndex:String?


    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSPersonalInformationViewController", bundle: nil)
        let vc:DSPersonalInformationViewController=storyboard.instantiateViewControllerWithIdentifier("DSPersonalInformationViewController")as! DSPersonalInformationViewController
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
        self.title = loadString("DSPersonalInformationTitle", tableId: TITLESTRINGTABLEID)
    }
    
    func initTableView(){
    
        self.initTableViewData()
        self.delegate = DSPersonalInformationDelegate()
        self.delegate.dataSource = self.dataSource
        registerCell(self.tableView, cell: DSAgencyFirstCell.self)
        registerCell(self.tableView, cell: DSAgencySeventhCell.self)
        registerCell(self.tableView, cell: DSAgencyThirdCell.self)
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

        self.initNameData(list)
        //self.initCardNoData(list)
        self.initPositionData(list)
        self.initPhoneNumData(list)
        self.initMailData(list)
        self.initWeiChatData(list)
        self.initLinkedData(list)
        
        self.dataSource.addObject(list)
    
    }

    func initSecondSectionData(){
    
        let list:NSMutableArray = NSMutableArray()
        let xinfo:DSAgencySeventhCellModel = DSAgencySeventhCellModel()
        xinfo.className = "DSAgencySeventhCell"
        xinfo.titleValue = "名片"
        xinfo.isHidden = true
        xinfo.block = {[weak self] in
            self?.addImageAction()
            self?.imageBlock = {[weak self](value:AnyObject?)in
                xinfo.backImage = value as! UIImage
                self?.httpPersonalInformatitonUploadFileRequire(value as! UIImage)
            }
        }
        list.addObject(xinfo)
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
        xinfo.isHidden = true
        xinfo.block = {[weak self] in
            let pick:CCPPickerViewTwo = CCPPickerViewTwo.init(pickerViewWithCenterTitle: "单笔可投额度（万）", andCancel: "取消", andSure: "确定")
            pick .pickerVIewClickCancelBtnBlock({
                }, sureBtClcik: { (firstString, secondString, statusString) in
                    xinfo.firstValue = firstString
                    xinfo.secondValue = secondString
                    self!.dataDic.setValue(firstString, forKey: "investMin")
                    self!.dataDic.setValue(secondString, forKey: "investMax")
                    self!.tableView.reloadData()
            })
        }
        list.addObject(xinfo)
        self.dataSource.addObject(list)
    }
    
    func initFourthSectionData(){
    
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
        if self.nameValue == nil||self.nameValue?.characters.count==0{
            SMToast("姓名为空")
        }else if self.positionValue == nil||self.positionValue?.characters.count==0{
            SMToast("职务为空")
        }else if self.phoneValue == nil||self.phoneValue?.characters.count == 0{
            SMToast("手机号码为空")
        }else if self.mailValue == nil||self.mailValue?.characters.count == 0{
            SMToast("个人邮箱为空")
        }else{
            self.httpPersonalInformationRequire()
        }
        //self.httpPersonalInformationRequire()
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

extension DSPersonalInformationViewController{
    
    //MARK:--------------CREAT CELL---------
    //MARK:------姓名-----
    func initNameData(arr:NSMutableArray){
        self.initTheInfo1(arr, title: "姓名", hidden: false) {[weak self] (value:AnyObject?) in
            self!.dataDic.setValue(value, forKey: "name")
            self?.nameValue = value as? String
        }
    }
    
    //MARK:------身份证号码
    func initCardNoData(arr:NSMutableArray){
        self.initTheInfo1(arr, title: "身份证号码", hidden: false) {[weak self] (value:AnyObject?) in
            self!.dataDic.setValue(value, forKey: "cardNo")
            self?.cardNoValue = value as? String
        }
    }
    
    //MARK:------职务----
    func initPositionData(arr:NSMutableArray){
        self.initTheInfo1(arr, title: "职务", hidden: false) {[weak self] (value:AnyObject?) in
            self!.dataDic.setValue(value, forKey: "job")
            self?.positionValue = value as? String
        }
    }
    
    //MARK:------手机号码-----
    func initPhoneNumData(arr:NSMutableArray){
        self.initTheInfo1(arr, title: "手机号码", hidden: false) {[weak self] (value:AnyObject?) in
            self!.dataDic.setValue(value, forKey: "mobilePhone")
            self?.phoneValue = value as? String
        }
    }
    
    //MARK:------个人邮箱----
    func initMailData(arr:NSMutableArray){
        self.initTheInfo1(arr, title: "个人邮箱", hidden: false) {[weak self] (value:AnyObject?) in
            self!.dataDic.setValue(value, forKey: "individualMail")
            self?.mailValue = value as? String
        }
    }
    
    //MARK:------微信-----
    func initWeiChatData(arr:NSMutableArray){
        self.initTheInfo1(arr, title: "微信(推荐)", hidden: true) {[weak self] (value:AnyObject?) in
            self!.dataDic.setValue(value, forKey: "wechat")
        }
    }
    
    //MARK:------LinkedIn-----
    func initLinkedData(arr:NSMutableArray){
        self.initTheInfo1(arr, title: "LinkedIn(推荐)", hidden: true) {[weak self] (value:AnyObject?) in
            self!.dataDic.setValue(value, forKey: "linkedin")
        }
    }
    
    func initTheInfo1(arr:NSMutableArray,title:String,hidden:Bool,block:passParameterBlock){
        
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
    

    
    //MARK:-----关注领域-----
    func initFirstData(arr:NSMutableArray,title:String){
        let list:NSArray = self.inPlistData("DSInvestmentAgencyFirst.plist")
        self.initTheInfo2(arr, title: title, arrayData: list, type: 2)
    }
    
    //MARK:-----投资阶段-----
    func initSecondData(arr:NSMutableArray,title:String){
        let list:NSArray = self.inPlistData("DSInvestmentAgencySecond.plist")
        self.initTheInfo2(arr, title: title, arrayData: list, type: 1)
    }
    
    //MARK:-----投资地域------
    func initThirdData(arr:NSMutableArray,title:String){
        let list:NSArray = self.inPlistData("DSInvestmentAgencyThird.plist")
        self.initTheInfo2(arr, title: title, arrayData: list, type: 2)
    }
    
    //MARK:-----主投币种-----
    func initFourthData(arr:NSMutableArray,title:String){
        let list:NSArray = self.inPlistData("DSInvestmentAgencyFourth.plist")
        self.initTheInfo2(arr, title: title, arrayData: list, type: 3)
    }
    
    func inPlistData(plistString:String)->(NSArray){
        let string:String = NSBundle.mainBundle().pathForResource(plistString, ofType: nil)!
        let plistArray:NSArray = NSArray.init(contentsOfFile: string)!
        return plistArray
    }
    
    
    func initTheInfo2(list:NSMutableArray,title:String,arrayData:NSArray,type:Int32){
        let info:DSAgencyThirdCellModel = DSAgencyThirdCellModel()
        info.className = "DSAgencyThirdCell"
        info.titleValue = title
        info.placdholder = "请选择"
        info.isHidden = true
        info.block = {[weak self] in
            let retList:NSArray = (self?.takeDescription(title, catsDataList: self!.catsData))!
            self!.inCollectionView(title, arrayData: arrayData, type: type, selectedList: retList)
//            self!.inCollectionView(title, arrayData:arrayData, type: type)
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
    
    //MARK:------加载collectionViewCell-------
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
                    self!.passBlock(allString)
                }
            }else{
                self!.passBlock("")
            }
        }
    }
    
    //MARK:------认证信息接口------
    func httpPersonalInformationRequire(){
    
        let cmd:HttpCommand = DSHttpAddApplyAccountCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {
            (result:RequestResult!,useInfo:AnyObject!)->() in
            self.httpPersonalInformationResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        let dic:NSMutableDictionary = NSMutableDictionary()
        
        dic[kHttpParamKey_AddApplyAccount_user_id] = DSAccountInfo.sharedInstance().personId
        dic[kHttpParamKey_AddApplyAccount_role_name] = "INSTITUTION_CREATOR"
        dic[kHttpParamKey_AddApplyAccount_applyLogin] = DSAccountInfo.sharedInstance().phoneNum
        
//        let institutionDic:NSMutableDictionary = NSMutableDictionary()

        self.InvestmentDic[kHttpParamKey_AddApplyAccount_institution_name] = self.dataDic["name"]
        //self.InvestmentDic[kHttpParamKey_AddApplyAccount_institution_card_no] = self.dataDic["cardNo"]
        self.InvestmentDic[kHttpParamKey_AddApplyAccount_institution_job] = self.dataDic["job"]
        self.InvestmentDic[kHttpParamKey_AddApplyAccount_institution_mobilePhone] = self.dataDic["mobilePhone"]
        self.InvestmentDic[kHttpParamKey_AddApplyAccount_institution_individualMail] = self.dataDic["individualMail"]
        self.InvestmentDic[kHttpParamKey_AddApplyAccount_institution_wechat] = self.dataDic["wechat"]
        self.InvestmentDic[kHttpParamKey_AddApplyAccount_institution_Linkedin] = self.dataDic["linkedin"]
        self.InvestmentDic[kHttpParamKey_AddApplyAccount_institution_bussinessCard] = self.businessCard
        self.InvestmentDic[kHttpParamKey_AddApplyAccount_institution_cats] = self.catsArray.updateCats(self.catsData)
        self.InvestmentDic[kHttpParamKey_AddApplyAccount_institution_investMin] = self.dataDic["investMin"]
        self.InvestmentDic[kHttpParamKey_AddApplyAccount_institution_investMax] = self.dataDic["investMax"]
        dic[kHttpParamKey_AddApplyAccount_institution] = self.InvestmentDic
        
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    func httpPersonalInformationResponse(result:RequestResult){
        if result.isOk() {

            SMToast("验证信息已提交，将在一个工作日内给您反馈")
            DSAccountInfo.sharedInstance().AuthenticationStatus = "CHECKING"
            DSAccountInfo.sharedInstance().isAuthentication = true
            self.navigationController?.popToRootViewControllerAnimated(true)
        }else{
            SMToast("请查看当前网络状态！")
        }
    }
    //MARK:------uploadFile接口-----
    func httpPersonalInformatitonUploadFileRequire(image:UIImage){
        let cmd:DSHttpUploadFileCmd = DSHttpUploadFileCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpUploadFileCmd
        let block:httpBlock = {[weak self](result:RequestResult!,useInfo:AnyObject!)->() in
            self?.httpPersonalInformatitonUploadFileResponse(result)
        }
        cmd.fileName = "image.jpg"
        cmd.keyName = "file"
        cmd.fileData = UIImagePNGRepresentation(image)
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
    }
    func httpPersonalInformatitonUploadFileResponse(result:RequestResult){
        let r:DSHttpUploadFileResult = result as! DSHttpUploadFileResult
        if r.isOk() {
            self.tableView.reloadData()
            self.businessCard = r.getUuid().stringByAppendingFormat("."+r.getSuffix())
            print(self.businessCard)
        }else{
            SMToast("请查看当前网络状态！")
        }
    }
}
class DSPersonalInformationDelegate: HTBaseTableViewDelegate {
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 80
        }else if indexPath.section == 3{
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
