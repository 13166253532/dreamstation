//
//  DSResetPasswordViewController.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/19.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

private let NAME_STORYBOARD_ACTIVITY:String="DSResetPasswordViewController"
private let IDENTIFIER_ACTIVITY:String="DSResetPasswordViewController"
private let STRINGTABLEID:String="DSRestPasswordStrings"
private let PHONENUM:String="telprompt://400123123"

class DSResetPasswordViewController: HTBaseViewController {

    @IBOutlet var ResetTableView: UITableView!
    @IBOutlet var ResetBtn: UIButton!
    @IBOutlet weak var promptLabel: UILabel!
    
    var delegate:DSLoginTableViewDelegate!
    var dataSource:NSMutableArray!
    var phoneNumInfo:DSLoginCellModel?
    var newPwdInfo:DSLoginCellModel?
    var conPwdInfo:DSLoginCellModel?
    var cerCodeInfo:DSLoginCellModel?
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: NAME_STORYBOARD_ACTIVITY, bundle: nil)
        let vc:DSResetPasswordViewController=storyboard.instantiateViewControllerWithIdentifier(IDENTIFIER_ACTIVITY)as! DSResetPasswordViewController
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addPromptLabel()
        self.initTitleBar()
        self.initTableView()
    }
    
    override func initTitleBar() {
        super.initTitleBar()
        self.title = loadString("DSResetPasswordTitle", tableId: TITLESTRINGTABLEID)
    }
    
    func initTableView(){
        self.initTableViewData()
        self.delegate = DSLoginTableViewDelegate()
        self.delegate.dataSource = self.dataSource
        registerCell(self.ResetTableView, cell: DSLoginTableViewCell.self)
        self.ResetTableView.delegate = self.delegate
        self.ResetTableView.dataSource = self.delegate
        self.ResetTableView.backgroundColor = loginBg_Color
        self.view.backgroundColor=loginBg_Color
    }
    
    func initTableViewData(){
        self.dataSource = NSMutableArray()
        self.initFirstCell()
        self.initSecondCell()
        self.initThirdCell()
        self.initFourthCell()
    }
    
    func addPromptLabel(){
        //指定字符 指定颜色并加上下划线
        let sub = "如果您是投资机构成员，请联系客服重置密码"
        let myMutableString = NSMutableAttributedString(string: sub)

        let range2 = NSMakeRange(12, 4)
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: footBlueColor, range: range2)
        myMutableString.addAttribute(NSUnderlineStyleAttributeName , value: NSUnderlineStyle.StyleNone.rawValue, range: NSMakeRange(0, 12))
        myMutableString.addAttribute(NSUnderlineStyleAttributeName , value: NSUnderlineStyle.StyleSingle.rawValue, range: range2)
        self.promptLabel.attributedText = myMutableString
    }
    func initFirstCell(){
        phoneNumInfo = DSLoginCellModel()
        phoneNumInfo!.hideTheBtn = true
        phoneNumInfo!.className = "DSLoginTableViewCell"
        phoneNumInfo!.placeholder = loadString("DSRestPwdMobileNumber", tableId: STRINGTABLEID)
        phoneNumInfo?.returnBlock = {[weak self](value:AnyObject)in
            self!.phoneNumInfo?.value = value as? String
        }
        self.dataSource.addObject(phoneNumInfo!)
    }
    func initSecondCell(){
        cerCodeInfo = DSLoginCellModel()
        cerCodeInfo!.hideTheBtn = false
        cerCodeInfo!.className = "DSLoginTableViewCell"
        cerCodeInfo!.placeholder = loadString("DSResetPwdVerficationCode", tableId: STRINGTABLEID)
        cerCodeInfo!.btnTitle = loadString("DSResetGetPwdVerficationCode", tableId: STRINGTABLEID)
        cerCodeInfo!.btnHasBound = true
        cerCodeInfo?.returnBlock = {[weak self](value:AnyObject)in
            self!.cerCodeInfo?.value = value as? String
        }
        cerCodeInfo!.btnBlock = {
            [weak self] in
            UIApplication.sharedApplication().keyWindow?.endEditing(true)  //关闭键盘
            if self!.phoneNumInfo?.value != nil {
                if self!.validateMobile((self!.phoneNumInfo?.value)!) {
                    self!.cerCodeInfo!.startCountdown = true
                    self!.httpSendPasswordRequire(self!.phoneNumInfo!.value!)
                }else{
                    SMToast(loadString("DSEnterFalsePhone", tableId:WARNING_TABLE_ID))
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
        return phoneTest .evaluateWithObject(mobile)
    }
    
    func initThirdCell(){
        newPwdInfo = DSLoginCellModel()
        newPwdInfo!.hideTheBtn = true
        newPwdInfo!.secureText = true
        newPwdInfo!.className = "DSLoginTableViewCell"
        newPwdInfo!.placeholder = loadString("DSResetNewPassword", tableId: STRINGTABLEID)
        newPwdInfo?.returnBlock = {[weak self](value:AnyObject)in
            self!.newPwdInfo?.value = value as? String
        }
        self.dataSource.addObject(newPwdInfo!)
    }
    
    func initFourthCell(){
        conPwdInfo = DSLoginCellModel()
        conPwdInfo!.hideTheBtn = true
        conPwdInfo!.secureText = true
        conPwdInfo!.className = "DSLoginTableViewCell"
        conPwdInfo!.placeholder = loadString("DSResetConfirmPassword", tableId: STRINGTABLEID)
        conPwdInfo?.returnBlock = {[weak self](value:AnyObject)in
            self!.conPwdInfo?.value = value as? String
        }
        self.dataSource.addObject(conPwdInfo!)
    }
    
    //完成按钮响应方法
    @IBAction func ResetBtnOfClick(sender: UIButton) {
        
        UIApplication.sharedApplication().keyWindow?.endEditing(true)
        if (phoneNumInfo?.value == nil||phoneNumInfo?.value?.characters.count == 0){
            SMToastView.showMessage(self.view, withMessage: loadString("DSEnterPhone", tableId: WARNING_TABLE_ID))
        }else if(cerCodeInfo?.value == nil||cerCodeInfo?.value?.characters.count == 0){
            SMToastView.showMessage(self.view, withMessage: loadString("DSEnerCerCode", tableId: WARNING_TABLE_ID))
        }else if(newPwdInfo?.value == nil||newPwdInfo?.value?.characters.count == 0){
            SMToastView.showMessage(self.view, withMessage: loadString("DSEnterNewPwd", tableId: WARNING_TABLE_ID))
        }else if(conPwdInfo?.value == nil||conPwdInfo?.value?.characters.count == 0){
            SMToastView.showMessage(self.view, withMessage: loadString("DSEnterConPwd", tableId: WARNING_TABLE_ID))
        }else if(newPwdInfo?.value != conPwdInfo?.value){
            SMToastView.showMessage(self.view, withMessage: loadString("DSPwdDifferent", tableId: WARNING_TABLE_ID))
        }else{
            self.httpResetPasswordRequire()
        }
        
    }
    
    
    
    @IBAction func clickCallService(sender: AnyObject) {
        let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction.init(title: "取消", style: .Cancel, handler: nil)
        let serviceAction = UIAlertAction.init(title: loadString("DSResetService", tableId: STRINGTABLEID), style: .Default) { (action:UIAlertAction) in
                UIApplication.sharedApplication().openURL(NSURL.init(string: PHONENUM)!)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(serviceAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        if (cancelAction.valueForKey("titleTextColor") != nil){
            cancelAction.setValue(UIColor.redColor(), forKey: "titleTextColor")
        }
        
    }
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- 发送验证码
    func httpSendPasswordRequire(phone:String){

        let cmd:HttpCommand=DSHttpSMSSendCmd.httpCommandWithVersion(PHttpVersion_v1)!
        let dict:NSMutableDictionary=NSMutableDictionary()
        dict[kHttpParamKey_SMSSend_phone] = phone
        dict[kHttpParamKey_SMSSend_templateId] = "PASSWORD"
        dict[kHttpParamKey_SMSSend_model] = "reset_password"
        cmd.requestInfo=dict as [NSObject : AnyObject]
        
        let block:httpBlock={
            //            [weak self]
            (result:RequestResult!,useInfo:AnyObject!)->() in
            self.httpSendPasswordResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        
        
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
        
    }
    
    func httpSendPasswordResponse(result:RequestResult){
        let r:DSHttpSMSSendResult=result as! DSHttpSMSSendResult
        if (r.isOk()){
            SMToast("发送成功")
        }else{
            SMToast(r.errMsg)
        }
    }
    
    
    
    //MARK:- 重置密码
    func httpResetPasswordRequire(){
        let cmd:HttpCommand=DSHttpChangePassCmd.httpCommandWithVersion(PHttpVersion_v1)!
        let dict:NSMutableDictionary=NSMutableDictionary()
        dict[kHttpParamKey_ChangePass_phone] = phoneNumInfo?.value
        dict[kHttpParamKey_ChangePass_password] = newPwdInfo?.value
        dict[kHttpParamKey_ChangePass_captcha] = cerCodeInfo?.value
        cmd.requestInfo=dict as [NSObject : AnyObject]
        
        let block:httpBlock={
            //            [weak self]
            (result:RequestResult!,useInfo:AnyObject!)->() in
            self.httpResetPasswordResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        
        
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
        
    }
    
    func httpResetPasswordResponse(result:RequestResult){
        let r:DSHttpChangePassResult=result as! DSHttpChangePassResult
        if (r.isOk()){
            
            self.navigationController?.popViewControllerAnimated(true)
            SMToast("修改成功")
        }else{
            SMToast(r.errMsg)
        }
    }


    
    
    
    
    
    
}







