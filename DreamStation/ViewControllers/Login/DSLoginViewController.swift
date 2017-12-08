//
//  DSLoginViewController.swift
//  DreamStation
//
//  Created by QPP on 16/6/15.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

private let STRINGTABLEID:String="DSLoginStrings"
enum LOGINTYPE :Int{
    case TABBARLOGIN
    case OTHERLOGIN
}

class DSLoginViewController: HTBaseViewController{

    
    @IBOutlet var loginTableView: UITableView!
    @IBOutlet var loginBtn: UIButton!
    
    var delegate:DSLoginTableViewDelegate!
    var dataSource:NSMutableArray!
    var isPresent:Bool = true
    var phoneNumInfo:DSLoginCellModel!
    var passwordInfo:DSLoginCellModel!
    
    var phoneText:String?
    var passwordText:String?
    
    var loginReturnType : LOGINTYPE?
    
    var rightBtn = UIButton()
    
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSLoginViewController", bundle: nil)
        let vc:DSLoginViewController=storyboard.instantiateViewControllerWithIdentifier("DSLoginViewController") as! DSLoginViewController
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTitleBar()
        addRightBtn()
        self.initView()
        self.initTableView()
        
    }
    func addRightBtn(){
        self.title=loadString("DSLoginTitle", tableId: TITLESTRINGTABLEID)
        self.rightBtn = UIButton.init(type: .Custom)
        self.rightBtn.frame = CGRectMake(0, 5, 60, 35)
        self.rightBtn.setTitle(loadString("Login_SignUp", tableId: STRINGTABLEID), forState: .Normal)
        self.rightBtn.titleLabel?.font=UIFont.systemFontOfSize(16)
        self.rightBtn.contentHorizontalAlignment = .Right
        self.rightBtn.addTarget(self, action: #selector(DSLoginViewController.clickSignUp), forControlEvents: .TouchUpInside)
        let messageItem:UIBarButtonItem = UIBarButtonItem.init(customView: self.rightBtn)
        self.navigationItem.rightBarButtonItem = messageItem
        let leftN:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "Arrow"), style: .Plain, target: self, action: #selector(DSLoginViewController.arrowResponses))
        self.navigationItem.leftBarButtonItem = leftN
        self.navigationItem.hidesBackButton=true
    }
    //MARK:----------返回首页----------
     func arrowResponses(){
//        self.dismissViewControllerAnimated(true, completion: nil)
//        self.navigationController?.popViewControllerAnimated(true)
        if loginReturnType == LOGINTYPE.TABBARLOGIN {
            self.navigationController?.popViewControllerAnimated(true)
        }else if loginReturnType == LOGINTYPE.OTHERLOGIN{
            let appDelegate = (UIApplication.sharedApplication().delegate) as! AppDelegate
                    appDelegate.initTabbarVC()
            appDelegate.window?.addSubview(appDelegate.tabBarVC.view)
            self.view.removeFromSuperview()
            appDelegate.window?.rootViewController=appDelegate.tabBarVC
        }
    }
    func clickSignUp(){
        let vc:DSSignUpViewController = DSSignUpViewController.createViewController(nil) as! DSSignUpViewController
        self.pushViewController(vc, animated: true)
    }
    func initView(){
        self.loginBtn.setTitle(loadString("Login_LogIn", tableId: STRINGTABLEID), forState: .Normal)
        self.view.backgroundColor = loginBg_Color
    }
    func initTableView(){
        self .initTableViewData()
        self.delegate = DSLoginTableViewDelegate()
        self.delegate.dataSource = self.dataSource
        registerCell(self.loginTableView, cell: DSLoginTableViewCell.self)
        self.loginTableView.delegate = self.delegate
        self.loginTableView.dataSource = self.delegate
        self.loginTableView.backgroundColor = loginBg_Color
    }
    
    func initTableViewData(){
        self.dataSource = NSMutableArray()
        self.phoneNumInfo = DSLoginCellModel()
        self.phoneNumInfo!.hideTheBtn = true
        //self.phoneNumInfo.value = "yoyou"
        self.phoneNumInfo!.className = "DSLoginTableViewCell"
        self.phoneNumInfo!.placeholder = loadString("Login_MobileNumber", tableId: STRINGTABLEID)
        self.phoneNumInfo.returnBlock = {[weak self](value:AnyObject?)in
            self?.phoneNumInfo.value = value as? String
        }
        self.dataSource.addObject(self.phoneNumInfo!)
        
        self.passwordInfo = DSLoginCellModel()
        self.passwordInfo!.hideTheBtn = false
        self.passwordInfo!.secureText = true
        self.passwordInfo.btnFontSize=15
        //self.passwordInfo.value = "123"
        self.passwordInfo!.className = "DSLoginTableViewCell"
        self.passwordInfo!.placeholder = loadString("Login_Password", tableId: STRINGTABLEID)
        self.passwordInfo.returnBlock = {[weak self](value:AnyObject?)in
            self?.passwordInfo.value = value as? String
        }
        self.passwordInfo!.btnTitle = loadString("Login_ForgotPassword", tableId: STRINGTABLEID)
        self.passwordInfo!.btnBlock = {
            [weak self] in
            let vc:DSResetPasswordViewController = DSResetPasswordViewController.createViewController(nil) as! DSResetPasswordViewController
            self!.pushViewController(vc, animated: true)
        }
        self.dataSource.addObject(passwordInfo!)
    }
    
    @IBAction func loginBtnOfClick(sender: UIButton) {
        
        UIApplication.sharedApplication().keyWindow?.endEditing(true)
        
        if phoneNumInfo!.value == nil||phoneNumInfo!.value?.characters.count == 0 {
            SMToastView.showMessage(self.view, withMessage: "请输入您的账号")
        }else if passwordInfo!.value == nil||passwordInfo!.value?.characters.count==0{
            SMToastView.showMessage(self.view, withMessage: "请输入您的密码")
        }else{
            self.httpLoginRequire(phoneNumInfo!.value!, password: passwordInfo!.value!)
        }
    }
      
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DSLoginViewController{
    
    
    func httpLoginRequire(phone:String,password:String){
        let cmd:HttpCommand=DSHttpLoginCmd.httpCommandWithVersion(PHttpVersion_v1)!
        let dict:NSMutableDictionary=NSMutableDictionary()
        dict[kHttpParamKey_login_login] = phone
        dict[kHttpParamKey_login_password] = password
        cmd.requestInfo=dict as [NSObject : AnyObject]
        
        let block:httpBlock={
//            [weak self]
            (result:RequestResult!,useInfo:AnyObject!)->() in
            self.httpLoginResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        
      
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
        
    }
    
    func httpLoginResponse(result:RequestResult){
        let r:DSHttpLoginResult=result as! DSHttpLoginResult
        if (result.isOk()){
            self.saveAccountMessage(r)
            self.jumpToHomePage()
            if DSAccountInfo.sharedInstance().authorized == "0" {
                self.panduan()
            }else{
                switch DSAccountInfo.sharedInstance().role {
                case "PROVIDER","ROLE_PROVIDER":
                    self.httpLoginGetProductsInfoRequire()
                    break
                default:
                    break
                }
            }
        }else{
            SMToast(r.errMsg)
        }
    }
    
    
    
    func panduan(){
        switch DSAccountInfo.sharedInstance().role {
        case "PROVIDER","ROLE_PROVIDER":
            self.getHttpProjectStatusRequire()
            break
        case "INDIVIDUAL","ROLE_INDIVIDUAL","INSTITUTION_CREATOR","INSTITUTIONER":
            self.getHttpAccountStatusRequire()
            break
        default:
            break
        }
    }
    func jumpToHomePage(){
        let appDelegate = (UIApplication.sharedApplication().delegate) as! AppDelegate
        appDelegate.initTabbarVC()
        appDelegate.window?.addSubview(appDelegate.tabBarVC.view)
        self.view.removeFromSuperview()
        appDelegate.window?.rootViewController=appDelegate.tabBarVC
    }
    func saveAccountMessage(r:DSHttpLoginResult){
        DSAccountInfo.sharedInstance().access_token=r.getAccess_token()
        DSAccountInfo.sharedInstance().phoneNum=r.getLoginPhone()
        DSAccountInfo.sharedInstance().perPhoneNum=r.getPhone()
        DSAccountInfo.sharedInstance().role=r.getRole()
        DSAccountInfo.sharedInstance().personId=r.getId()
        DSAccountInfo.sharedInstance().authorized=r.getisAuthorized()
        DSAccountInfo.sharedInstance().institutionId = r.getInstitutionId()
        DSAccountInfo.sharedInstance().companyName = r.getInstitutionCompany()
        DSAccountInfo.sharedInstance().job=r.getInstitutionJob()
        if DSAccountInfo.sharedInstance().role == "PARK_ADMIN" {
            DSAccountInfo.sharedInstance().name=r.getisParkName()
            DSAccountInfo.sharedInstance().parkName=r.getisParkNames()
            DSAccountInfo.sharedInstance().job = r.getisParkJob()
            DSAccountInfo.sharedInstance().perPhoneNum=r.getisParkperPhone()
            DSAccountInfo.sharedInstance().companyName = r.getisParkNames()
        }else{
           DSAccountInfo.sharedInstance().name=r.getisName()
        }
        DSAccountInfo.sharedInstance().avatar=r.getisAvatar()
        self.queryUnreadMessagr()
        JPUSHService.registerForRemoteNotificationTypes(UIUserNotificationType.Badge.rawValue | UIUserNotificationType.Sound.rawValue | UIUserNotificationType.Alert.rawValue , categories: nil)
        //设置别名  cywu
        JPUSHService.setTags(nil, alias: DSAccountInfo.sharedInstance().personId, fetchCompletionHandle: { (code, tags, alias) in
            NSLog("code : %d", code)
        })
    }
   //MARK:-----查询是否有未读消息
    func queryUnreadMessagr() {
        let array:NSMutableArray = FGDBHelper.sharedInstance().queryAllMessage(DSAccountInfo.sharedInstance().personId) as NSMutableArray
        if array.count == 0 {
             DSAccountInfo.sharedInstance().isRead = nil
        }
        for index in 0..<array.count {
            let model : HTMessageInfo = array[index] as! HTMessageInfo
            if model.isRead == "0" {
                DSAccountInfo.sharedInstance().isRead = "0"
                break
            }else{
                DSAccountInfo.sharedInstance().isRead = "1"
            }
        }
    }
    //MARK:-----获取项目方项目信息
    func httpLoginGetProductsInfoRequire(){
        let cmd:DSHttpPerProductsCmd = DSHttpPerProductsCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpPerProductsCmd
        let block:httpBlock = {(result:RequestResult!,useInfo:AnyObject!)->()in
            self.httpLoginGetProductsInfoResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_PerProducts_id] = DSAccountInfo.sharedInstance().personId
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpLoginGetProductsInfoResponse(result:RequestResult){
        let r:DSHttpPerProductsResult = result as! DSHttpPerProductsResult
        if r.isOk() {
            self.getAllPerInfoData(r.getAllContent())
        }
    }
    
    func getAllPerInfoData(array:NSMutableArray){
        if array.count != 0 {
            let info = array[array.count-1] as! DSProductsInfo
            DSAccountInfo.sharedInstance().productsId = info.id
            DSAccountInfo.sharedInstance().categories = info.jsonCat
            DSAccountInfo.sharedInstance().companyName = info.companyName
            DSAccountInfo.sharedInstance().address = info.address
            DSAccountInfo.sharedInstance().videoUrl = info.videoUrl
            DSAccountInfo.sharedInstance().productsName = info.brief
            DSAccountInfo.sharedInstance().name = info.myName
            DSAccountInfo.sharedInstance().productsmyName = info.myName
            DSAccountInfo.sharedInstance().productStatus = info.productStatus
            DSAccountInfo.sharedInstance().job = info.position
        }
    }

    
    //MARK:-----未认证投资者的认证状态
    func getHttpAccountStatusRequire(){
        
        let cmd:DSHttpAccountStatusCmd = DSHttpAccountStatusCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpAccountStatusCmd
        let block:httpBlock = {(result:RequestResult!,useInfo:AnyObject!)->()in
            self.getHttpAccountStatusResult(result)
        }
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate = completeDelegate
        
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_AccountStatus_user_id] = DSAccountInfo.sharedInstance().personId
       
        cmd.requestInfo = dic as [NSObject:AnyObject]
        
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }

    func getHttpAccountStatusResult(result:RequestResult){
        let r:DSHttpAccountStatusResult = result as! DSHttpAccountStatusResult
        if r.isOk(){
            self.judgeStatus(r.getUserStatus())
        }
    }
    
    func judgeStatus(status:String?){
        if status == nil{
            DSAccountInfo.sharedInstance().AuthenticationStatus = "unAuthentication"
        }else if status == "CHECKING" {
            DSAccountInfo.sharedInstance().AuthenticationStatus = "CHECKING"
        }else if status == "ACCEPTED"{
            DSAccountInfo.sharedInstance().AuthenticationStatus = "ACCEPTED"
        }else if status == "REFUSED"{
            DSAccountInfo.sharedInstance().AuthenticationStatus = "REFUSED"
        }
    }
    //MARK:-----未认证项目方的认证状态
    func getHttpProjectStatusRequire(){
        
        let cmd:DSHttpProjectStatusCmd = DSHttpProjectStatusCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpProjectStatusCmd
        let block:httpBlock = {(result:RequestResult!,useInfo:AnyObject!)->()in
            self.getHttpProjectStatusResult(result)
        }
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate = completeDelegate
        
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_ProjectStatus_user_id] = DSAccountInfo.sharedInstance().personId
       
        cmd.requestInfo = dic as [NSObject:AnyObject]
        
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    
    func getHttpProjectStatusResult(result:RequestResult){
        let r:DSHttpProjectStatusResult = result as! DSHttpProjectStatusResult
        if r.isOk(){
           self.judgeStatus(r.getProjectStatus())
        }
    }

}
