//
//  DSProjectAuthenticationVC.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/15.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit
private let STRING_MINE = "DSMineStrings"

enum UploadType:Int {
    case License = 1   //执照
    case Card = 2      //名片
}

class DSProjectAuthenticationVC: HTBaseViewController {

    @IBOutlet var tableView: UITableView!
    
    var uploadType:UploadType = .License
    
    var delegate:DSProjectAuthenticationDelegate!
    var dataSource:NSMutableArray = NSMutableArray()
    var dataDic:NSMutableDictionary = NSMutableDictionary()
    var isShow:Bool!
    
    var picker:pickView = pickView()
    var companyValue:String?
    var nameValue:String?
    var positionValue:String?
    var personMailValue:String?
    var licenceUrl:String?
    var businessCard:String?
    
    var imageBlock:passParameterBlock!
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSProjectAuthenticationVC", bundle: nil)
        let vc:DSProjectAuthenticationVC=storyboard.instantiateViewControllerWithIdentifier("DSProjectAuthenticationVC")as! DSProjectAuthenticationVC
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
        self.title=loadString("MineProjectAuthentication", tableId: STRING_MINE)
    }
    
    func initTableView(){
    
        self.initTableViewData()
        self.delegate = DSProjectAuthenticationDelegate()
        self.delegate.dataSource = self.dataSource
        registerCell(self.tableView, cell: DSAgencyFirstCell.self)
        registerCell(self.tableView, cell: DSAgencySecondCell.self)
        registerCell(self.tableView, cell: DSAgencySeventhCell.self)
        registerCell(self.tableView, cell: DSProjectEighthCell.self)
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
    }
    
    func initFirstSectionData(){
        let list:NSMutableArray = NSMutableArray()

        self.initCompanyData(list)
        
        let secondXinfo:DSAgencySecondCellModel = DSAgencySecondCellModel()
        secondXinfo.className = "DSAgencySecondCell"
        secondXinfo.titleValue = "营业执照或三证合一"
        secondXinfo.detailValue = "Agency_addImage"
        secondXinfo.isHidden = false
        secondXinfo.block = {[weak self] in
            self?.addImageAction()
            self?.imageBlock = {(value:AnyObject?)in
                secondXinfo.backImage = value as? UIImage
                self?.httpProjectAuthenticationUploadFileRequire(value as! UIImage,type:.License)
            }
        }
        list.addObject(secondXinfo)
        
        self.initAddressData(list)
        self.initHomepageData(list)
        self.initWCPublicData(list)
        
        self.dataSource.addObject(list)
        
    }
    
    func initSecondSectionData(){
    
        let list:NSMutableArray = NSMutableArray()

        self.initNameData(list)
        
        let secondXinfo:DSAgencySeventhCellModel = DSAgencySeventhCellModel()
        secondXinfo.className = "DSAgencySeventhCell"
        secondXinfo.titleValue = "名片"
        secondXinfo.isHidden = false
        secondXinfo.block = {[weak self] in
            self?.addImageAction()
            self?.imageBlock = {(value:AnyObject?)in
                secondXinfo.backImage = value as? UIImage
                self?.httpProjectAuthenticationUploadFileRequire(value as! UIImage,type:.Card)
            }
        }
        list.addObject(secondXinfo)

        self.initPositionData(list)
        self.initPersonMailData(list)
        self.initWeichatData(list)
        self.initLinkedData(list)
        
        self.dataSource.addObject(list)
    }
    
    func initThirdSectionData(){
    
        let list:NSMutableArray = NSMutableArray()
        let xinfo:DSProjectEighthCellModel = DSProjectEighthCellModel()
        xinfo.className = "DSProjectEighthCell"
        xinfo.titleValue = "是否上过梦想下一站节目"
        self.isShow = false
        xinfo.isAn = false
        xinfo.isHidden = false
        xinfo.block = {(value:AnyObject?)->Void in
            if value as! Bool == true {
                self.isShow = true
            }else{
                self.isShow = false
            }
        }
        list.addObject(xinfo)
        self.dataSource.addObject(list)
    }
    
    func initFourthSectionData(){
        
        let list:NSMutableArray = NSMutableArray()
        let xinfo:DSAgencyFifthCellModel = DSAgencyFifthCellModel()
        xinfo.className = "DSAgencyFifthCell"
        xinfo.titleValue = "下一步"
        xinfo.block = {[weak self] in
            self?.attentionView()
        }
        list.addObject(xinfo)
        self.dataSource.addObject(list)
    }
    
    func attentionView(){
        if self.companyValue == nil||self.companyValue?.characters.count == 0{
            SMToast("公司名为空")
        }else if self.nameValue == nil||self.nameValue?.characters.count == 0{
            SMToast("姓名为空")
        }else if self.positionValue == nil||self.positionValue?.characters.count == 0{
            SMToast("职位为空")
        }else if self.personMailValue == nil||self.personMailValue?.characters.count == 0{
            SMToast("个人邮箱为空")
        }else{
            self.httpProjectAcuthticationRequire()
        }
        //self.httpProjectAcuthticationRequire()
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

extension DSProjectAuthenticationVC{

    //MARK:认证信息接口
    func httpProjectAcuthticationRequire(){

        let companyDic:NSMutableDictionary = NSMutableDictionary()
        companyDic[kHttpParamKey_AddApplyProject_project_company_companyName] = self.dataDic["companyName"]
        companyDic[kHttpParamKey_AddApplyProject_project_company_licenceUrl] = self.licenceUrl
        companyDic[kHttpParamKey_AddApplyProject_project_company_address] = self.dataDic["address"]
        companyDic[kHttpParamKey_AddApplyProject_project_company_myName] = self.dataDic["myName"]
        companyDic[kHttpParamKey_AddApplyProject_project_company_homePage] = self.dataDic["homePage"]
        companyDic[kHttpParamKey_AddApplyProject_project_company_weichatPublic] = self.dataDic["weichatPublic"]
        companyDic[kHttpParamKey_AddApplyProject_project_company_businessCard] = self.businessCard
        companyDic[kHttpParamKey_AddApplyProject_project_company_job] = self.dataDic["job"]
        companyDic[kHttpParamKey_AddApplyProject_project_company_individualMail] = self.dataDic["individualMail"]
        companyDic[kHttpParamKey_AddApplyProject_project_company_weichat] = self.dataDic["weichat"]
        companyDic[kHttpParamKey_AddApplyProject_project_company_linkedin] = self.dataDic["linkedin"]
        companyDic[kHttpParamKey_AddApplyProject_project_company_isOnShow] = self.isShow
        
        let vc:DSProjectInformationVC = DSProjectInformationVC.createViewController(nil) as! DSProjectInformationVC
        vc.hidesBottomBarWhenPushed = true
        vc.companyDic = companyDic
        self.pushViewController(vc, animated: true)
    }
        
    //MARK:------uploadFile接口
    func httpProjectAuthenticationUploadFileRequire(image:UIImage,type:UploadType){
        
        let cmd:DSHttpUploadFileCmd = DSHttpUploadFileCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpUploadFileCmd
        let block:httpBlock = {[weak self](result:RequestResult!,useInfo:AnyObject!)->() in
            self?.httpProjectAuthenticationUploadFileResponse(result,type:type)
        }
        cmd.fileName = "image.jpg"
        cmd.keyName = "file"
        cmd.fileData = UIImagePNGRepresentation(image)
        
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpProjectAuthenticationUploadFileResponse(result:RequestResult,type:UploadType){
        let r:DSHttpUploadFileResult = result as! DSHttpUploadFileResult
        if r.isOk() {
            self.tableView.reloadData()
            print(r.getAvatarUrl())
            print(r.getSuffix())
            print(r.getUuid())
            
            switch type {
            case .License:
                self.licenceUrl = r.getUuid().stringByAppendingFormat("."+r.getSuffix())
                print(self.licenceUrl)
                break
            case .Card:
                self.businessCard = r.getUuid().stringByAppendingFormat("."+r.getSuffix())
                print(self.businessCard)
                break
            }
        }
    }
    
    //MARK:CREAT CELL
    
    //MARK:公司
    func initCompanyData(arr:NSMutableArray){
        self.initTheInfo(arr, title: "公司名",hidden:false) {[weak self] (value:AnyObject?) in
            self!.dataDic.setValue(value, forKey: "companyName")
            self?.companyValue = value as? String
        }
    }
    
    //MARK:地址
    func initAddressData(arr:NSMutableArray){
        self.initTheInfo(arr, title: "办公地址",hidden:true) { (value:AnyObject?) in
            self.dataDic.setValue(value, forKey: "address")
        }
    }
    
    //MARK:官网
    func initHomepageData(arr:NSMutableArray){
        self.initTheInfo(arr, title: "官网",hidden:true) {[weak self] (value:AnyObject?) in
            self!.dataDic.setValue(value, forKey: "homePage")
        }
    }
    
    //MARK:微信公众号
    func initWCPublicData(arr:NSMutableArray){
        self.initTheInfo(arr, title: "微信公众号",hidden:true) {[weak self] (value:AnyObject?) in
            self!.dataDic.setValue(value, forKey: "weichatPublic")
        }
    }
    
    //MARK:姓名
    func initNameData(arr:NSMutableArray){
        self.initTheInfo(arr, title: "姓名",hidden:false) {[weak self] (value:AnyObject?) in
            self!.dataDic.setValue(value, forKey: "myName")
            self?.nameValue = value as? String
        }
    }
    
    //MARK:职位
    func initPositionData(arr:NSMutableArray){
        self.initTheInfo(arr, title: "职位",hidden:false) {[weak self] (value:AnyObject?) in
            self!.dataDic.setValue(value, forKey: "job")
            self?.positionValue = value as? String
        }
    }
    
    //MARK:个人邮箱
    func initPersonMailData(arr:NSMutableArray){
        self.initTheInfo(arr, title: "个人邮箱",hidden:false) {[weak self] (value:AnyObject?) in
            self!.dataDic.setValue(value, forKey: "individualMail")
            self?.personMailValue = value as? String
        }
    }
    
    //MAKR:微信推荐
    func initWeichatData(arr:NSMutableArray){
        self.initTheInfo(arr, title: "微信(推荐)",hidden:true) {[weak self] (value:AnyObject?) in
            self!.dataDic.setValue(value, forKey: "weichat")
        }
    }
    
    //MARK:LinkedIn
    func initLinkedData(arr:NSMutableArray){

        self.initTheInfo(arr, title: "LinkedIn(推荐)",hidden:true) {[weak self] (value:AnyObject?) in
            self!.dataDic.setValue(value, forKey: "linkedin")
        }
    }
    
    
    func initTheInfo(arr:NSMutableArray,title:String,hidden:Bool,block:passParameterBlock){
    
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
}

class DSProjectAuthenticationDelegate: HTBaseTableViewDelegate {
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 80
        }else if indexPath.section == 3&&indexPath.row == 0{
            return 60
        }else{
            return 44
        }
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
