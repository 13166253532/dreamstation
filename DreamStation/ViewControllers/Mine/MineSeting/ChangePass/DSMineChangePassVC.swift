//
//  DSMineChangePassVC.swift
//  DreamStation
//
//  Created by xjb on 16/7/21.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSMineChangePassVC: HTBaseViewController {

 
    @IBOutlet weak var myTableView: UITableView!
   
   
    @IBOutlet weak var myButton: UIButton!
    
    var dataSource:NSMutableArray!
    var tableDelegate:DSChangePassDelegate!
    var passwordInfo:DSSetingPassModel?
    var newPasswordInfo:DSSetingPassModel?

    
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSMineChangePassVC", bundle: nil)
        let vc:DSMineChangePassVC=storyboard.instantiateViewControllerWithIdentifier("DSMineChangePassVC")as! DSMineChangePassVC
        vc.createArgs=createArgs
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initTitleBar()
        self.view.backgroundColor = loginBg_Color
        
       initTableView()
    }
    override func initTitleBar() {
        super.initTitleBar()
        self.title=loadString("DSChangePassTitle", tableId: TITLESTRINGTABLEID)
    }
    
    func initTableView(){
        
        registerCell(self.myTableView, cell: DSMineChangePassCell.self)
        
        initdataSource()
        
        self.tableDelegate = DSChangePassDelegate()
        self.tableDelegate.dataSource=self.dataSource
        self.myTableView.delegate = self.tableDelegate
        self.myTableView.dataSource = self.tableDelegate
        self.myTableView.backgroundColor = loginBg_Color
        self.myTableView.scrollEnabled = false
    }
    func initdataSource() {
        self.dataSource = NSMutableArray()
        self.newPasswordInfo = DSSetingPassModel()
        self.newPasswordInfo?.className = "DSMineChangePassCell"
        self.newPasswordInfo?.placeholder = "新密码"
        self.dataSource.addObject(self.newPasswordInfo!)
        
        self.passwordInfo = DSSetingPassModel()
        self.passwordInfo?.className = "DSMineChangePassCell"
        self.passwordInfo?.placeholder = "确认密码"
        self.dataSource.addObject(self.passwordInfo!)
 
    }
    
    @IBAction func myButtonAction(sender: AnyObject) {
        
        UIApplication.sharedApplication().keyWindow?.endEditing(true)
        
        if self.newPasswordInfo?.value == nil||self.newPasswordInfo?.value?.characters.count==0 {
            SMToastView.showMessage(self.view, withMessage: "请输入新密码！")
        }else if self.passwordInfo?.value == nil||self.passwordInfo?.value?.characters.count==0 {
            SMToastView.showMessage(self.view, withMessage: "请输入确认密码！")
        }else if self.passwordDigits() == false {
            SMToastView.showMessage(self.view, withMessage: "请输入6位密码！")
        }else if self.passwordInfo?.value != self.newPasswordInfo?.value{
            SMToastView.showMessage(self.view, withMessage: "确认密码有误！")
        }else{
            self.httpSettingModifyPassword()
 
        }
    }
 //MARK:判断密码的位数
    func passwordDigits() -> Bool{
        if self.passwordInfo?.value?.characters.count == 6 && self.newPasswordInfo?.value?.characters.count == 6 {
            return true
        }
        return false
    }
    
    //MARK:------------修改密码接口
    func httpSettingModifyPassword(){
        let cmd:HttpCommand=DSHttpSettingModifyPasswordCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock={[weak self](result:RequestResult!,useInfo:AnyObject!)->() in
            self?.httpSettingModifyPasswordResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_SettingModifyPassword_password] = self.newPasswordInfo?.value
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()

    }
    func httpSettingModifyPasswordResponse(result:RequestResult){
        let r:DSHttpSettingModifyPasswordResult = result as! DSHttpSettingModifyPasswordResult
        if r.isOk() {
            SMToast("密码修改成功！")
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
class  DSChangePassDelegate: DSLoginTableViewDelegate {
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return 15
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let w = CGRectGetHeight(tableView.frame)-15
        return w/2
    }
}
