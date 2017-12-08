//
//  DSParkMessageViewController.swift
//  DreamStation
//
//  Created by xjb on 16/7/25.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSParkMessageViewController: HTBaseViewController {


    @IBOutlet weak var myTableView: UITableView!
    
    var delegate:DSParkMessageDelegate!
    var dataSource = NSMutableArray()
    var nameInfo:DSParkMessageCellInfo!
    var parkNameInfo:DSParkMessageCellInfo!
    var positionInfo:DSParkMessageCellInfo!
    var phoneInfo:DSParkMessageCellInfo!
    var emailInfo:DSParkMessageCellInfo!
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSParkMessageViewController", bundle: nil)
        let vc:DSParkMessageViewController=storyboard.instantiateViewControllerWithIdentifier("DSParkMessageViewController")as! DSParkMessageViewController
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = loginBg_Color
         initTitleBar()
        initTableView()
    }

    override func initTitleBar() {
        super.initTitleBar()
        self.title=loadString("DSParkMessageTitle", tableId: TITLESTRINGTABLEID)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
    func initTableView(){
        self.dataSource = NSMutableArray()
        delegate = DSParkMessageDelegate()
        registerCell(self.myTableView, cell: DSParkMessageCell.self)
        registerCell(self.myTableView, cell: DSParkMessageRemindCell.self)
        initDataSource()
        
        delegate.dataSource = self.dataSource
        self.myTableView.delegate = delegate
        self.myTableView.dataSource = delegate
        self.myTableView.scrollEnabled = false
        
    }
    func initDataSource(){
        initFirstRow()
        initAddCell()
        
        print(self.dataSource[0])
    }
    func initFirstRow(){
        let firstRow = DSParkMessageCellInfo()
        firstRow.title = "如果您是园区方，可以在此申请发布园区信息！"
        firstRow.className = "DSParkMessageRemindCell"
        self.dataSource .addObject(firstRow)
    }
    func initAddCell(){
        self.nameInfo = DSParkMessageCellInfo()
        self.nameInfo.title = "姓名"
        self.nameInfo.className = "DSParkMessageCell"
        self.dataSource .addObject(nameInfo)
        
        self.parkNameInfo = DSParkMessageCellInfo()
        self.parkNameInfo.title = "园区名"
        self.parkNameInfo.className = "DSParkMessageCell"
        self.dataSource .addObject(parkNameInfo)
        
        self.positionInfo = DSParkMessageCellInfo()
        self.positionInfo.title = "职务"
        self.positionInfo.className = "DSParkMessageCell"
        self.dataSource .addObject(positionInfo)
        
        self.phoneInfo = DSParkMessageCellInfo()
        self.phoneInfo.title = "手机号码"
        self.phoneInfo.className = "DSParkMessageCell"
        self.dataSource .addObject(phoneInfo)
        
        self.emailInfo = DSParkMessageCellInfo()
        self.emailInfo.title = "邮箱"
        self.emailInfo.className = "DSParkMessageCell"
        self.dataSource .addObject(emailInfo)
        
    }
    
    @IBAction func action(sender: AnyObject) {
         UIApplication.sharedApplication().keyWindow?.endEditing(true)
        if self.nameInfo?.textField?.text == nil||nameInfo?.textField?.text?.characters.count==0  {
            SMToastView.showMessageCenter(self.view, withMessage: "姓名为空！")
        }else if self.parkNameInfo?.textField?.text == nil||parkNameInfo?.textField?.text?.characters.count==0 {
            SMToastView.showMessageCenter(self.view, withMessage: "园区名为空！")
        }else if self.positionInfo?.textField?.text == nil||positionInfo?.textField?.text?.characters.count==0 {
            SMToastView.showMessageCenter(self.view, withMessage: "职务为空！")
        }else if self.phoneInfo?.textField?.text == nil||phoneInfo?.textField?.text?.characters.count==0 {
            SMToastView.showMessageCenter(self.view, withMessage: "手机号码为空！")
            
        }else if !validationPhone((self.phoneInfo.textField?.text)!){
             SMToastView.showMessageCenter(self.view, withMessage: "手机号码有误！")
        }else if self.emailInfo?.textField?.text == nil||emailInfo?.textField?.text?.characters.count==0 {
            SMToastView.showMessageCenter(self.view, withMessage: "邮箱为空！")
        }else if !validationEmail((self.emailInfo.textField?.text)!){
            SMToastView.showMessageCenter(self.view, withMessage: "邮箱有误！")
        }else{
           self.httpApplyParkRequire()
        }
        
    }
    func httpApplyParkRequire(){
        let cmd:HttpCommand=DSHttpApplyParkCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock={
            [weak self](result:RequestResult!,useInfo:AnyObject!)->() in
            self!.httpApplyParkRespones(result)
        }
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        let dic = NSMutableDictionary()
        dic[kHttpParamKey_ApplyPark_name] = self.nameInfo.textField?.text
        dic[kHttpParamKey_ApplyPark_parkName] = self.parkNameInfo.textField?.text
        dic[kHttpParamKey_ApplyPark_job] = self.positionInfo.textField?.text
        dic[kHttpParamKey_ApplyPark_phoneNum] = self.phoneInfo.textField?.text
        dic[kHttpParamKey_ApplyPark_mail] = self.emailInfo.textField?.text
        cmd.requestInfo = dic as [NSObject : AnyObject]
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
        
    }
    func httpApplyParkRespones(result:RequestResult){
        let result:DSHttpApplyParkResult = result as! DSHttpApplyParkResult
        if result.isOk() {
           SMToast("提交成功！")
           self.navigationController?.popViewControllerAnimated(true)
        }
    }

    func validationPhone(phone:String)->Bool{
       let phoneRegex:String="^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(14[0,0-9])|(17[0,0-9]))\\d{8}$"
       let phoneTest = NSPredicate(format:"SELF MATCHES %@",phoneRegex)
        return phoneTest .evaluateWithObject(phone)
    }
    func validationEmail(email:String)->Bool{
        let emailRegex:String="[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@",emailRegex)
        return emailTest .evaluateWithObject(email)
    }
    class DSParkMessageDelegate: DSLoginTableViewDelegate {
        override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            if indexPath.row == 0 {
                return 40
            }else{
                return 44
            }
        }
        
        
        override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 0
        }
        
    }


}
