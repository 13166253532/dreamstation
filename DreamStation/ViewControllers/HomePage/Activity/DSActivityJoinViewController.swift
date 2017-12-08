//
//  DSActivityJoinViewController.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/26.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSActivityJoinViewController: HTBaseViewController {

    @IBOutlet var joinTableView: UITableView!
    @IBOutlet var joinBtn: UIButton!
    
    var delegate:HTBaseTableViewDelegate!
    var dataSource:NSMutableArray!
    
    var dataDic:NSMutableDictionary!
    var passBlock:passParameterBlock!
    
    var activityId : String?

    var companyValue:String?
    var positionValue:String?


//    DSAccountInfo.sharedInstance().phoneNum
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard = UIStoryboard(name: "DSActivityJoinViewController", bundle: nil)
        let vc:DSActivityJoinViewController=storyboard.instantiateViewControllerWithIdentifier("DSActivityJoinViewController") as! DSActivityJoinViewController
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = NSMutableArray()
        self.dataDic = NSMutableDictionary()
        self.initTitleBar()
        self.initTableView()
        self.set()
        getUserDate()
    }
    
    override func initTitleBar() {
        super.initTitleBar()
        self.title = loadString("DSActivityJoinTitle", tableId: TITLESTRINGTABLEID)
    }
    func initTableView(){
        self.initTableViewData()
        self.delegate = HTBaseTableViewDelegate()
        self.delegate.dataSource = self.dataSource
        registerCell(self.joinTableView, cell: DSActivityJoinCell.self)
        self.joinTableView.delegate = self.delegate
        self.joinTableView.dataSource = self.delegate
        self.joinTableView.backgroundColor = loginBg_Color
        
    }
    
    func initTableViewData(){
    
        let list:NSMutableArray = NSMutableArray()
        self.initNameData(list)
        self.initPhoneNumData(list)
        self.dataSource.addObject(list)
        
        let list2:NSMutableArray = NSMutableArray()
        self.initCompanyData(list2)
        self.initPositionData(list2)
        self.initTelephoneData(list2)
        self.dataSource.addObject(list2)
    }
    //MARK:获取信息
    func getUserDate(){
        if DSAccountInfo.sharedInstance().companyName != nil {
           self.companyValue = DSAccountInfo.sharedInstance().companyName
        }
        if DSAccountInfo.sharedInstance().job != nil {
            self.positionValue = DSAccountInfo.sharedInstance().job
        }
    }
    
    @IBAction func joinBtnOfClick(sender: UIButton) {
        
       if(self.companyValue==nil||self.companyValue?.characters.count==0){
            SMToast("公司为空")
        }else if(self.positionValue==nil||self.positionValue?.characters.count==0){
            SMToast("职位为空")
        }else{
             self.httpActivityJoinRequire()
        }
        
    }
    func set(){
        self.dataDic.setValue(DSAccountInfo.sharedInstance().name, forKey: "name")
        self.dataDic.setValue(self.getPhane(), forKey: "phone")
        self.dataDic.setValue(DSAccountInfo.sharedInstance().companyName, forKey: "company")
        self.dataDic.setValue(DSAccountInfo.sharedInstance().job, forKey: "position")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DSActivityJoinViewController{
    
    //MARK:姓名
    func initNameData(arr:NSMutableArray){
        self.initTheInfo(arr, title: "姓名",textValue: DSAccountInfo.sharedInstance().name,isHidden: true) { (value:AnyObject) in
            self.dataDic.setValue(value as! String, forKey: "name")
        }
    }
    //MARK:手机号
    func initPhoneNumData(arr:NSMutableArray){
        self.initTheInfo(arr, title: "手机",textValue: self.getPhane(),isHidden: true) { (value:AnyObject) in
            self.dataDic.setValue(value as! String, forKey: "phone")
        }
    }
    func getPhane() -> (String?) {
        if DSAccountInfo.sharedInstance().role == "INSTITUTIONER" || DSAccountInfo.sharedInstance().role == "PARK_ADMIN" {
            if (DSAccountInfo.sharedInstance().perPhoneNum == nil)  {
               return ""
            }
            return DSAccountInfo.sharedInstance().perPhoneNum!
        }else{
            return DSAccountInfo.sharedInstance().phoneNum!
        }
    }
    
    //MARK:公司
    func initCompanyData(arr:NSMutableArray){
        self.initTheInfo(arr, title: "公司",textValue: DSAccountInfo.sharedInstance().companyName,isHidden: false) { (value:AnyObject) in
            self.dataDic.setValue(value as! String, forKey: "company")
            self.companyValue = value as? String
        }
    }
    
    //MARK:职位
    func initPositionData(arr:NSMutableArray){
        self.initTheInfo(arr, title: "职位",textValue: DSAccountInfo.sharedInstance().job,isHidden: false) { (value:AnyObject) in
            self.dataDic.setValue(value as! String, forKey: "position")
            self.positionValue = value as? String
        }
    }
    
    //MARK:座机
        func initTelephoneData(arr:NSMutableArray){
            self.initTheInfo(arr, title: "座机",textValue: nil,isHidden: true) { (value:AnyObject) in
                self.dataDic.setValue(value as! String, forKey: "landLine")
            }
        }
    //MARK:判断是否有汉字
    func isIncludeChineseIn(string: String) -> Bool {
        for (_, value) in string.characters.enumerate() {
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }
    func initTheInfo(arr:NSMutableArray,title:String,textValue:String?,isHidden:Bool,block:passParameterBlock){
    
        let info:DSActivityJoinCellModel = DSActivityJoinCellModel()
        info.className = "DSActivityJoinCell"
        info.labelValue = title
        info.block = block
        info.isHidden = isHidden
        //info.textValue = String()
        info.textValue = textValue
        if DSAccountInfo.sharedInstance().authorized == "1" {
            
            if title == "手机" {
                if isPureNumandCharacters(self.getPhane()) != false {
                    info.textValue = self.getPhane()
                }
                self.dataDic.setValue(info.textValue! as String, forKey: "phone")
            }
        }
        arr.addObject(info)
    }
    func getString(str:String?) -> (String?) {
        if str != nil {
            return str
        }
        return nil
    }
    
    
   func isPureNumandCharacters(str:String?) -> (Bool) {
    let str1:String = str!.stringByTrimmingCharactersInSet(NSCharacterSet.decimalDigitCharacterSet())
        if str1.characters.count != 0 {
            return false
        }else{
            return true
        }
    }
    
    
    
    func httpActivityJoinRequire(){
    
        let cmd:HttpCommand = DSHttpActivitySignupCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {
            (result:RequestResult!,useInfo:AnyObject!)->() in
            self.httpActivityJoinResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        let dic:NSMutableDictionary = NSMutableDictionary()
        print(self.dataDic)
        dic[kHttpParamKey_ActivitySignup_id] = self.activityId
        
        dic[kHttpParamKey_ActivitySignup_account] = DSAccountInfo.sharedInstance().phoneNum
        dic[kHttpParamKey_ActivitySignup_name] = self.isEmpty(self.dataDic["name"] as? String)
        dic[kHttpParamKey_ActivitySignup_phone] = self.isEmpty(self.dataDic["phone"] as? String)
        dic[kHttpParamKey_ActivitySignup_company] = self.dataDic["company"]
        dic[kHttpParamKey_ActivitySignup_position] = self.dataDic["position"]
        dic[kHttpParamKey_ActivitySignup_landLine] = self.isEmpty(self.dataDic["landLine"] as? String)
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }

    
    
    func httpActivityJoinResponse(result:RequestResult){
        let r:DSHttpActivitySignupResult = result as! DSHttpActivitySignupResult
        if r.isOk() {
            if(r.getResult().isSuccess=="SUCCESS"){
                SMToast("提交成功")
                 self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    func isEmpty(value:String?)->(String){
        if value != nil {
            return value!
        }
        return ""
    }
    
}
