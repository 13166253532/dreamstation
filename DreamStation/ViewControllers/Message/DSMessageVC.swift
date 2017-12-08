//
//  DSMessageVC.swift
//  DreamStation
//
//  Created by xjb on 16/9/27.
//  Copyright © 2016 QPP. All rights reserved.
//

import UIKit

private let DSMESSAGESTRINGS:String = "DSTitleStrings"

class DSMessageVC: HTBaseViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var alertImgView: UIImageView!
    
    @IBOutlet weak var alertLab: UILabel!
    
    
    var delegate:DSMessageTableViewDelegate!
    var dataSource:NSMutableArray!
    
    var status:MineStatus = .MineInvestors_login_unauthentication
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSMessageVC", bundle: nil)
        let vc:DSMessageVC=storyboard.instantiateViewControllerWithIdentifier("DSMessageVC")as! DSMessageVC
        vc.createArgs=createArgs
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = loginBg_Color
        initTitleBar()
        initTableView()
        alertImgView.hidden = true
        alertLab.hidden = true
        //selectDB();
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        DSAccountInfo.sharedInstance().isOpenMessageVC = "1"
        self.dataSource = NSMutableArray()
        self.selectDB()
    }
    
    override func initTitleBar() {
        super.initTitleBar()
        self.title = loadString("MessageTitle", tableId: DSMESSAGESTRINGS)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    override func viewDidDisappear(animated: Bool) {
        DSAccountInfo.sharedInstance().isOpenMessageVC = nil
    }
    func initTableView(){
        //self.dataSource=NSMutableArray()
        
        registerCell(self.myTableView, cell: DSMessageTableViewCell.self)
        //        registerCell(self.myTableView, cell: DSMessageDetailsTableViewCell.self)
        registerCell(self.myTableView, cell: DSMessageBriefTableViewCell.self)
        
        delegate = DSMessageTableViewDelegate()
        delegate.dataSource = self.dataSource
        self.myTableView.delegate = delegate
        self.myTableView.dataSource = delegate
        self.myTableView.backgroundColor = loginBg_Color
    }
//    func initDataSource(){
//        self.dataSource.removeAllObjects()
//        
//        let array = NSMutableArray()
//        
//        let info = DSMessageCellModel()
//        info.title = "活动"
//        info.isRead = "0"
//        info.subTitle = "第五届上海城市发展论坛，诚邀您的加入！"
//        array .addObject(info)
//        array .addObject(info)
//        
//        for index in 0..<array.count {
//            let info = array[index] as! DSMessageCellModel
//            self.initSection(info)
//        }
//    }
    // 查询数据库 cywu
    func selectDB(){
        var array = NSMutableArray()
        if DSAccountInfo.sharedInstance().personId != nil {
            array = FGDBHelper.sharedInstance().queryAllMessage(DSAccountInfo.sharedInstance().personId) as NSMutableArray
            self.notLogin(array)
        }else{
            array = FGDBHelper.sharedInstance().queryAllMessage("0987654321123456789") as NSMutableArray
        }
        //NSLog("%@",array)
        if array.count == 0 {
            DSAccountInfo.sharedInstance().isRead = nil
            alertImgView.hidden = false
            alertLab.hidden = false
           // self.layout.constant = UIScreen.mainScreen().bounds.height
        }else{
            //self.layout.constant = 0
            alertImgView.hidden = true
            alertLab.hidden = true
        }
        for i in 0..<array.count {
            let arr = NSMutableArray()
            let model : HTMessageInfo = array[i] as! HTMessageInfo
            let info = DSMessageCellModel()
            info.type = model.type
            info.className = self.puanduanWeiQun(info)
            info.title = model.title
            info.subTitle = model.content
            info.reason = model.reason
            info.messageId = model.id
            info.isRead = model.isRead
            //print(model.title,model.reason)
            info.detailTitle = "查看详情"
            info.mId = model.mId
            
            info.block = {
                [weak self]in
                if DSAccountInfo.sharedInstance().personId != nil {
                   self!.gotoDetailed(model,info:info)
                }else{
                    SMToast("请先登录！")
                }
            }
            info.blockParam = {
                [weak self](indexpath:AnyObject)in
                self!.deleteDB(model,indexPath:indexpath)
                //self!.initTableView()
//                self!.myTableView.reloadData()
            }
            arr.addObject(info)
            self.dataSource .addObject(arr)
            
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
        self.initTableView()
        self.myTableView.reloadData()
    }
    func notLogin(listArray:NSMutableArray){
        let array = FGDBHelper.sharedInstance().queryAllMessage("0987654321123456789") as NSMutableArray
        if array.count != 0 {
            for index in 0..<array.count {
                listArray .addObject(array[index])
            }
        }
    }
    
    func puanduanWeiQun(info:DSMessageCellModel) ->(String){
        if info.type == JPUSHTYPE.PRODUCTS_WECHAT_GROUP.rawValue || info.type == JPUSHTYPE.INVESTORS_WECHAT_GROUP.rawValue {
            return "DSMessageBriefTableViewCell"
        }else{
            return "DSMessageTableViewCell"
        }
    }
    
//    func initSection(message:DSMessageCellModel){
//        let arr = NSMutableArray()
//        let info = DSMessageCellModel()
//        info.className = "DSMessageTableViewCell"
//        info.title = message.title
//        info.subTitle = message.subTitle
//        //        info.block = {
//        //            [weak self]in
//        //            self!.gotoDetailed(info)
//        //        }
//        
//        info.detailTitle = "查看详情"
//        arr .addObject(info)
//        self.dataSource .addObject(arr)
//    }
    
    //MARK:详情
    func gotoDetailed(model:HTMessageInfo, info:DSMessageCellModel){
        
        info.isRead = "1"
        model.isRead = info.isRead
        FGDBHelper.sharedInstance().updateMessagePush(model) { (isSuccess:Bool) in
            print(isSuccess)
            self.detailType(info)
        }
        
        self.myTableView.reloadData()
        print("详情页面")
    }

    func detailType(info:DSMessageCellModel) {
        switch info.type {
        case JPUSHTYPE.ACTIVITY.rawValue: //活动{
            self.GoToActivityDetail(info.messageId)
            print("活动")
            break
        case JPUSHTYPE.ATTENTION.rawValue://请求关注
            self.GoTpMyAttentionVC()
            print("请求关注")
            break
            
        case JPUSHTYPE.AUTHENTICATION_ACCEPTED.rawValue://认证信息审核已通过
            self.GoToMinePage()
            print("认证信息审核已通过")
            break
        case JPUSHTYPE.AUTHENTICATION_REFUSED.rawValue://认证信息审核未通过
            self.GoTpMessageDetails(info.reason)
            //更改认证状态
            print("认证信息审核未通过")
            break
            
        case JPUSHTYPE.UPDATE_PERSON_ACCEPTED.rawValue://更新个人信息审核已通过
            self.GoToMineInfoPage()
            print("更新个人信息审核已通过")
            break
        case JPUSHTYPE.UPDATE_PERSON_REFUSED.rawValue://更新个人信息审核未通过
             self.GoTpMessageDetails(info.reason)
            print("更新个人信息审核未通过")
            break
        case JPUSHTYPE.PROJECT_ACCEPTED.rawValue://发布项目信息审核已通过
            self.GoToMyProject()
            print("发布项目信息审核已通过")
            break
        case JPUSHTYPE.PROJECT_REFUSED.rawValue://发布项目信息审核未通过
             self.GoTpMessageDetails(info.reason)
            print("发布项目信息审核未通过")
            break
        case JPUSHTYPE.UPDATE_PROJECT_ACCEPTED.rawValue://更新项目信息审核已通过
            self.GoToMyProject()
            print("更新项目信息审核已通过")
            break
        case JPUSHTYPE.UPDATE_PROJECT_REFUSED.rawValue://更新项目信息审核未通过
             self.GoTpMessageDetails(info.reason)
            print("更新项目信息审核未通过")
            break
        case JPUSHTYPE.PRODUCTS_WECHAT_GROUP.rawValue://已成功建立微信群"), //项目方
            print("已成功建立微信群), //项目方")
            break
        case JPUSHTYPE.INVESTORS_WECHAT_GROUP.rawValue://"已成功建立微信群"), //投资方
            print("已成功建立微信群), //投资方")
            break
        case JPUSHTYPE.TURN_AROUND.rawValue://您有新的约谈
            self.GoToMinePage()
            print("您有新的约谈")
            break
        case JPUSHTYPE.PARK_ACCEPTED.rawValue://园区信息审核已通过
            self.GoToParkDetails(info.messageId)
            print("园区信息审核已通过")
            break
        case JPUSHTYPE.PARK_REFUSED.rawValue://园区信息审核未通过
            self.GoTpMessageDetails(info.reason)
            print("园区信息审核未通过")
            break
        case JPUSHTYPE.UPDATE_PARK_ACCEPTED.rawValue://更新园区信息审核已通过
            self.GoToParkDetails(info.messageId)
            print("更新园区信息审核已通过")
            break
        case JPUSHTYPE.UPDATE_PARK_REFUSED.rawValue://更新园区信息审核未通过
            self.GoTpMessageDetails(info.reason)
            print("更新园区信息审核未通过")
            break
        case JPUSHTYPE.OTHER.rawValue://其它
            print("其它")
            break
            
        default:
            break
        }
    }
    //MARK:活动详情界面
    func GoToActivityDetail(id:String){
        let vc:DSActivityDetailViewController = DSActivityDetailViewController.createViewController(nil) as! DSActivityDetailViewController
        vc.activityId = id
        vc.isMyActivity = false
        self.pushViewController(vc, animated: true)
    }
    //MARK:我的页面
    func GoToMinePage(){
        //self.navigationController?.popViewControllerAnimated(true)
        self.tabBarController?.selectedIndex = 4
        self.navigationController?.popToRootViewControllerAnimated(true)

    }
    //MARK:个人信息界面
    func GoToMineInfoPage(){
        let vc=DSMyInfoViewController.createViewController(nil) as! DSMyInfoViewController
        vc.status = self.shenfenPuanDuan()
        vc.hidesBottomBarWhenPushed=true
        self.pushViewController(vc, animated: true)
        
    }
    func shenfenPuanDuan()->(MineStatus){
        switch  DSAccountInfo.sharedInstance().role {
        case nil:
            break
        //项目方
        case "PROVIDER","ROLE_PROVIDER":
            if DSAccountInfo.sharedInstance().authorized == "0"{
                self.status = .MineProject_login_unauthentication
            }else{
                self.status = .MineProject_login_authentication
            }
            break
        //个人投资方
        case "INDIVIDUAL","ROLE_INDIVIDUAL":
            if DSAccountInfo.sharedInstance().authorized == "0"{
                self.status = .MineInvestors_login_unauthentication
            }else{
                self.status = .MineInvestors_login_authentication_father
            }
            break
        //投资方
        case "INSTITUTIONER","INSTITUTION_CREATOR":
            if DSAccountInfo.sharedInstance().authorized == "0"{
                self.status = .MineInvestors_login_unauthentication
            }else{
                self.status = .MineInvestors_login_authentication_child
            }
            break
        case "PARK_ADMIN":
            if DSAccountInfo.sharedInstance().authorized == "0"{
                
            }else{
                self.status = .MinePark_login_authentication
            }
        default:
            break
        }
        return self.status
    }
    //MARK:项目方我的项目页面
    func GoToMyProject(){
        let vc:DSDetailMyProjectVC = DSDetailMyProjectVC.createViewController(nil) as! DSDetailMyProjectVC
       // vc.projectId = id
        vc.isMessage = true
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(vc, animated: true)
    }
    //MARK:园区详情
    func GoToParkDetails(id:String){
        //2c928084576f13a801576f8b0a88000b
        //2c928084576f13a801576f8b5c30000c
        let vc:DSParkDetailsVC=DSParkDetailsVC.createViewController(nil) as! DSParkDetailsVC
        vc.parkId = id
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(vc, animated: true)
    }
    //MARK:我的关注
    func GoTpMyAttentionVC(){
        let vc:DSMinePleaseFocusViewController = DSMinePleaseFocusViewController.createViewController(nil) as! DSMinePleaseFocusViewController
        vc.hidesBottomBarWhenPushed=true
        self.pushViewController(vc, animated: true)

    }
    //MARK:消息详情
    func GoTpMessageDetails(sta:String?){
        let vc:DSMessageDetailsViewController=DSMessageDetailsViewController.createViewController(nil) as! DSMessageDetailsViewController
        vc.details = sta
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(vc, animated: true)
    }
    
    
    func deleteDB(model :HTMessageInfo , indexPath :AnyObject) {
        //1,从本地数据库将数据移除
        //调用FGDBHelper中的delete方法删除DB中的数据
        FGDBHelper.sharedInstance().deleteMessage(model.mId, callBack: { (isSuccess:Bool) in
            if (isSuccess) {
                let index=indexPath as! NSIndexPath
                self.dataSource.removeObjectAtIndex(index.section)
                self.myTableView.deleteSections(NSIndexSet.init(index: index.section), withRowAnimation: UITableViewRowAnimation.Left)
            }
        })
    }
    //刷新TableView
    func refreshUI (object: AnyObject?){
        
        let indexPath = object as? NSIndexPath
        let ary = self.dataSource.objectAtIndex(indexPath!.section)
        ary.removeObjectAtIndex((indexPath?.row)!)
        if self.dataSource.count == 0 {
            DSAccountInfo.sharedInstance().isRead = nil
            alertImgView.hidden = false
            alertLab.hidden = false
            // self.layout.constant = UIScreen.mainScreen().bounds.height
        }
        //2.reload
        //直接使用reload方法界面的变化非常迅速，用户体验非常不好
        //                self.tableView.reloadData()
        //这个具有动画效果
        self.myTableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
    }

    }
