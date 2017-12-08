//
//  DSSignUpViewController.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/19.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

private let NAME_STORYBOARD_ACTIVITY:String="DSSignUpViewController"
private let IDENTIFIER_ACTIVITY:String="DSSignUpViewController"
private let STRINGTABLEID:String="DSSignUpStrings"

/**项目方*/
private let ROLE_PROVIDER:String="PROVIDER"
/**个人投资者*/
private let ROLE_INDVIDVUAL:String="INDIVIDUAL"


class DSSignUpViewController: HTBaseViewController {
    
    @IBOutlet var signUpTableView: UITableView!

    @IBOutlet var signUpBtn: UIButton!
    
    var alertString:String!
    var role=ROLE_INDVIDVUAL
    
    var delegate:DSSignUpTableViewDelegate!
    
    var dataSource:NSMutableArray!
    var phoneNumInfo:DSLoginCellModel?
    var passwordInfo:DSLoginCellModel?
    var cerCodeInfo:DSLoginCellModel?
    var settingUserInfo:DSLoginUserCellModel?
    
    var cerCode:String!
      
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: NAME_STORYBOARD_ACTIVITY, bundle: nil)
        let vc:DSSignUpViewController=storyboard.instantiateViewControllerWithIdentifier(IDENTIFIER_ACTIVITY)as! DSSignUpViewController
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTitleBar()
        self.initTableView()
        self.alertString = loadString("DSInvestorString", tableId: WARNING_TABLE_ID)
    }
    
    override func initTitleBar() {
        super.initTitleBar()
        self.title = loadString("DSSignUpTitle", tableId: TITLESTRINGTABLEID)
    }
    
    
// MARK:注册按钮
    @IBAction func signUpOfClick(sender: UIButton) {
        
        UIApplication.sharedApplication().keyWindow?.endEditing(true)
        
        if phoneNumInfo!.value == nil||phoneNumInfo!.value?.characters.count != 11 {
            SMToastView.showMessage(self.view, withMessage: loadString("DSEnterFalsePhone", tableId:WARNING_TABLE_ID))
        }else if passwordInfo!.value == nil||passwordInfo!.value?.characters.count==0{
            SMToastView.showMessage(self.view, withMessage: loadString("DSEnterNewPwd", tableId: WARNING_TABLE_ID))
        }else if self.checkoutPassword()==false{
            SMToastView.showMessage(self.view, withMessage: loadString("DSPwdNumFailed", tableId: WARNING_TABLE_ID))
        }else if cerCodeInfo!.value == nil||cerCodeInfo!.value?.characters.count==0{
             SMToast(loadString("DSEnerCerCode", tableId: WARNING_TABLE_ID))
        }
        
        else{
            self.httpRegisterRequire(phoneNumInfo!.value!, password: passwordInfo!.value!)
        }
    }
    
    func checkoutPassword()->Bool{
        if passwordInfo!.value?.characters.count==6 && passwordInfo!.value?.characters.count<17{
            return true
        }else{
            return false
        }
    }
    
    
    
    func alertViewShow(){
        let alertController = UIAlertController(title: alertString,message: nil, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "以后再说", style: .Default, handler:{
            action in
           self.jumpToHomePage(DSAccountInfo.sharedInstance().role)
        })
        let okAction = UIAlertAction(title: "前往认证", style: .Default,handler: {
            action in
            
            if self.role != ROLE_INDVIDVUAL{
                let vc:DSProjectAuthenticationVC = DSProjectAuthenticationVC.createViewController(nil) as! DSProjectAuthenticationVC
                self.pushViewController(vc, animated: true)
            }else{
                let vc:DSInverStorsAuthenticationViewController=DSInverStorsAuthenticationViewController.createViewController(nil) as! DSInverStorsAuthenticationViewController
                self.pushViewController(vc, animated: true)
            }
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        AppRootViewController()!.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func jumpToHomePage(string:String){
      
        let appDelegate = (UIApplication.sharedApplication().delegate) as! AppDelegate
        appDelegate.initTabbarVC()
        appDelegate.window?.addSubview(appDelegate.tabBarVC.view)
        self.view.removeFromSuperview()
        appDelegate.window?.rootViewController=appDelegate.tabBarVC
        if string != ROLE_INDVIDVUAL {
            appDelegate.tabBarVC.selectedIndex=2
        }else{
            appDelegate.tabBarVC.selectedIndex=1
        }
    }


// MARK:tableView
    func initTableView(){
    
        self.initDataSource()
        self.delegate = DSSignUpTableViewDelegate()
        self.delegate.dataSource = self.dataSource
        
        registerCell(self.signUpTableView, cell: DSLoginTableViewCell.self)
        registerCell(self.signUpTableView, cell: DSLoginUserIDTableViewCell.self)
        
        self.signUpTableView.backgroundColor = loginBg_Color
        self.signUpTableView.delegate = self.delegate
        self.signUpTableView.dataSource = self.delegate
        
        self.view.backgroundColor = loginBg_Color
    }
    
    func initDataSource(){
        self.dataSource = NSMutableArray()
        
        self.initFirstCell()
        self.initSecondCell()
        self.initThirdCell()
        self.initFourCell()
    }

    func initFirstCell(){
        
        phoneNumInfo = DSLoginCellModel()
        phoneNumInfo!.hideTheBtn = true
        phoneNumInfo!.className = "DSLoginTableViewCell"
        phoneNumInfo!.placeholder = loadString("DSSignUpMobileNumber", tableId: STRINGTABLEID)
        phoneNumInfo?.returnBlock = {[weak self](value:AnyObject?) in
            self?.phoneNumInfo?.value = value as? String
        }
        self.dataSource.addObject(phoneNumInfo!)
        
    }
    
    func initSecondCell(){
    
        passwordInfo = DSLoginCellModel()
        passwordInfo!.hideTheBtn = true
        passwordInfo!.className = "DSLoginTableViewCell"
        passwordInfo!.placeholder = loadString("DSSignUpPassword", tableId: STRINGTABLEID)
        passwordInfo!.secureText = true
        passwordInfo!.returnBlock = {[weak self](value:AnyObject?) in
            self?.passwordInfo?.value = value as? String
        }
        self.dataSource.addObject(passwordInfo!)
    }
    
    func  initThirdCell(){
    
        cerCodeInfo = DSLoginCellModel()
        cerCodeInfo!.hideTheBtn = false
        cerCodeInfo!.className = "DSLoginTableViewCell"
        cerCodeInfo!.placeholder = loadString("DSSignUpVerficationCode", tableId: STRINGTABLEID)
        cerCodeInfo!.btnTitle = loadString("DSSignUpVerGetficationCode", tableId: STRINGTABLEID)
        cerCodeInfo!.btnHasBound = true
        cerCodeInfo!.returnBlock = {[weak self](value:AnyObject?) in
            self!.cerCodeInfo?.value = value as? String
            self?.cerCode = value as! String
        }
        cerCodeInfo!.btnBlock = {
        
            [weak self] in
            UIApplication.sharedApplication().keyWindow?.endEditing(true)
            
            if (self!.phoneNumInfo?.value != nil) {
                if (self!.validateMobile(self!.phoneNumInfo!.value!))  {
                    self!.cerCodeInfo!.startCountdown = true
//                    网络请求
                    self?.httpSMSSendRequire(self!.phoneNumInfo!.value!)
                }else{
                    SMToast(loadString("DSEnterFalsePhone", tableId: WARNING_TABLE_ID))
                }
            }else{
                SMToast(loadString("DSEnterPhone", tableId: WARNING_TABLE_ID))
            }
        }
        self.dataSource.addObject(cerCodeInfo!)
    }
    
    //    手机号码验证是否正确
    func validateMobile(mobile:String) -> Bool {
        let phoneRegex:String = "^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(14[0,0-9])|(17[0,0-9]))\\d{8}$"
        let phoneTest = NSPredicate(format:"SELF MATCHES %@",phoneRegex)
        return phoneTest.evaluateWithObject(mobile)
    }
    
    
    func initFourCell(){
        
        settingUserInfo = DSLoginUserCellModel()
        settingUserInfo!.className = "DSLoginUserIDTableViewCell"
        settingUserInfo!.btnBlock = {
            [weak self]in
            self!.alertString = loadString("DSInvestorString", tableId: WARNING_TABLE_ID)
            self!.role=ROLE_INDVIDVUAL
        }
        settingUserInfo!.btnBlock2 = {
            [weak self]in
            self!.alertString = loadString("DSProjectString", tableId: WARNING_TABLE_ID)
            self!.role=ROLE_PROVIDER
        }
    
        self.dataSource.addObject(settingUserInfo!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DSSignUpViewController{

    //MAKR:-----短信验证
    func httpSMSSendRequire(phone:String){
        
        let cmd:HttpCommand = DSHttpSMSSendCmd.httpCommandWithVersion(PHttpVersion_v1)
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_SMSSend_phone] = phone
        dic[kHttpParamKey_SMSSend_templateId] = "REGISTER"
        dic[kHttpParamKey_SMSSend_model] = "register"
        let block:httpBlock = {
            (result:RequestResult!,useInfo:AnyObject!)->Void in
            self.httpSMSSendResponse(result)
        }
        
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpSMSSendResponse(result:RequestResult){
        if result.isOk() {
            SMToast("发送成功")
        }else{
            SMToast("发送失败")
        }
    }

    //MARK:-----注册接口
    func httpRegisterRequire(phone:String,password:String){
        let cmd:HttpCommand=DSHttpRegisterCmd.httpCommandWithVersion(PHttpVersion_v1)!
        let dict:NSMutableDictionary=NSMutableDictionary()
        dict[kHttpParamKey_register_login] = phone
        dict[kHttpParamKey_register_password] = password
        dict[kHttpParamKey_register_role] = self.role
        dict[kHttpParamKey_register_captcha] = self.cerCode
        cmd.requestInfo=dict as [NSObject : AnyObject]
        
        let block:httpBlock={
            //            [weak self]
            (result:RequestResult!,useInfo:AnyObject!)->() in
            self.httpRegisterResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpRegisterResponse(result:RequestResult){
        let r:DSHttpRegisterResult = result as! DSHttpRegisterResult
        if (r.isOk()){
            DSAccountInfo.sharedInstance().access_token=r.getAccessToken()
            DSAccountInfo.sharedInstance().phoneNum=r.getPhone()
            DSAccountInfo.sharedInstance().role=r.getRole()
            DSAccountInfo.sharedInstance().personId=r.getId()
            DSAccountInfo.sharedInstance().authorized=r.getIsAuthorized()
            DSAccountInfo.sharedInstance().name = self.phoneNumInfo!.value
            //设置别名  cywu
            JPUSHService.setTags(nil, alias: DSAccountInfo.sharedInstance().personId, fetchCompletionHandle: { (code, tags, alias) in
                NSLog("code : %d", code)
            })
            r.getAvatar()
            self.alertViewShow()
        }else{
            SMToast(r.errMsg)
        }
    }
}

class DSSignUpTableViewDelegate: DSLoginTableViewDelegate{
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return 135
        }else{
            return 44
        }
    }
}
