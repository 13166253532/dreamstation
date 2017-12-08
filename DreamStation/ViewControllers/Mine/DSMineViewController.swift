//
//  DSMineViewController.swift
//  DreamStation
//
//  Created by QPP on 16/7/19.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit


enum MineStatus:Int {
    /**投资方已登录 未认证*/
    case MineInvestors_login_unauthentication = 1
    /**投资方已登录 已认证(个人投资者)*/
    case MineInvestors_login_authentication_father = 2
     /**投资方已登录 已认证(子账号)*/
    case MineInvestors_login_authentication_child = 3
     /**项目方已登录 未认证*/
    case MineProject_login_unauthentication = 4
     /**项目方已登录 已认证*/
    case MineProject_login_authentication = 5
     /**园区方已登录 已认证*/
    case MinePark_login_authentication = 6

}

private let STRING_MINE = "DSMineStrings"

class DSMineViewController: HTBaseViewController {
  
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    
    var askMeFocusonInfo:DSMineCellModel=DSMineCellModel()//请我关注
    var dateMeInfo:DSMineCellModel=DSMineCellModel()//约谈我的
    var tzInfo:DSMineCellModel=DSMineCellModel()
    var status:MineStatus = .MineProject_login_authentication
    
    var itemArray = NSMutableArray()
    
    var followNum:String?
    var perInfoBlock:passParameterBlock?
    
    var mineHeadInfo:DSMineHeadCellModel = DSMineHeadCellModel()
    var dataSource:NSMutableArray=NSMutableArray()
    var tableDelegate:DSMineTableViewDelegate = DSMineTableViewDelegate()
    
    var isClickShare:Bool = true
    var shareTitleString:String?
    var shareUrlString:String = "http://www.wingmediadream.com/wingmedia_web/share/download.html"
    
    var messageBtn:UIButton!
    var messageImage = UIImageView()
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSMineViewController", bundle: nil)
        let vc:DSMineViewController=storyboard.instantiateViewControllerWithIdentifier("DSMineViewController")as! DSMineViewController
        vc.createArgs=createArgs
        return vc
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
            self.initNavigationController()
            self.initTableView()
            self.edgesForExtendedLayout=UIRectEdge.All
            self.automaticallyAdjustsScrollViewInsets=true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.lt_reset()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.scrollViewDidScroll(self.myTableView)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.initTableView()
        self.messageBtnImage()
        if DSAccountInfo.sharedInstance().personId != nil {
           self.reloadStatus()
        }
        self.myTableView.reloadData()
        
    }
    
    func reloadStatus(){
        let loginVC = DSLoginViewController()
        loginVC.panduan()
    }
    
    func initNavigationController(){
        self.navigationController?.navigationBar.lt_setBackgroundColor(UIColor.clearColor())
        
        self.messageBtn = UIButton.init(type: .Custom)
        self.messageBtn.frame = CGRectMake(0, 0, 40, 35)
        self.messageImage.frame = CGRectMake(17, 6, 23, 23)
        //self.messageImage.center = self.messageBtn.center
        self.messageBtn .addSubview(self.messageImage)
        //self.messageBtn.backgroundColor = UIColor.blackColor()
        
        self.messageBtn.addTarget(self, action: #selector(goToMessage), forControlEvents: .TouchUpInside)
        let messageItem:UIBarButtonItem = UIBarButtonItem.init(customView: self.messageBtn)
        
        self.navigationItem.rightBarButtonItem = messageItem
        self.navigationController!.navigationBar.tintColor=UIColor.whiteColor()

    }
    
    //改变消息按钮背景图片
    func messageBtnImage(){
        self.messageBtn.enabled = true
        
        if DSAccountInfo.sharedInstance().isRead == nil||DSAccountInfo.sharedInstance().isRead == "1" {
            self.messageImage.image = UIImage.init(named: "homePage_message")
            //self.messageBtn.setBackgroundImage(UIImage.init(named: "homePage_message"), forState: .Normal)
        }else{
            self.messageImage.image = UIImage.init(named: "homePage_messageNoRead")
            //self.messageBtn.setBackgroundImage(UIImage.init(named: "homePage_messageNoRead"), forState: .Normal)
        }
    }
   
    func addGoMyProject(){
        let vc:DSMineMyProjectViewController=DSMineMyProjectViewController.createViewController(nil) as! DSMineMyProjectViewController
        vc.block = {[weak self] in
            self!.initTableView()
        }
        vc.hidesBottomBarWhenPushed=true
        self.pushViewController(vc, animated: true)
        
    }

    //MARK:-----------TableView加载----------
    func initTableView() {
        self.addUserId()
       // self.initDataWithMineStatus(status)
        registerCell(self.myTableView, cell: DSMineHeadTableViewCell.self)
        registerCell(self.myTableView, cell: DSMineHeadOKCell.self)
        registerCell(self.myTableView, cell: DSMineTableViewCell.self)
        registerCell(self.myTableView, cell: DSAuthenticationViewCell.self)
        self.tableDelegate.dataSource=self.dataSource
        self.myTableView.delegate = self.tableDelegate
        self.myTableView.dataSource = self.tableDelegate
        self.myTableView.backgroundColor=grayBgColor
        
    }

    //MARK:消息页面
    func goToMessage(){
        self.messageBtn.enabled = false
        let vc:DSMessageVC=DSMessageVC.createViewController(nil) as! DSMessageVC
        vc.hidesBottomBarWhenPushed=true
        self.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY : CGFloat = scrollView.contentOffset.y
        if offsetY > 50{
            let alpha = min(1, 1 - ((50 + 64 - offsetY) / 64));
            self.navigationController!.navigationBar.lt_setBackgroundColor(greenNavigationColor.colorWithAlphaComponent(alpha))
        }else {
            self.navigationController!.navigationBar.lt_setBackgroundColor(greenNavigationColor.colorWithAlphaComponent(0))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func initTitleBar() {
        super.initTitleBar()
        //self.title=loadString("DSMineTitle", tableId: TITLESTRINGTABLEID)
        self.initNavigationController()
    }

    func addUserId(){

        switch  DSAccountInfo.sharedInstance().role {
        case nil:
            break
            //项目方
        case "PROVIDER","ROLE_PROVIDER":
            if DSAccountInfo.sharedInstance().authorized == "0"{
                self.reloadTableView(.MineProject_login_unauthentication)
            }else{
                let switchProject = UIButton.init(type: .Custom)
                switchProject.frame = CGRectMake(0, 0, 100, 20)
                switchProject.contentHorizontalAlignment = .Left
                switchProject.contentEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 0)
                switchProject.titleLabel?.font = UIFont.systemFontOfSize(14)
                switchProject.backgroundColor = UIColor.clearColor()
                switchProject.setTitle("切换项目", forState: .Normal)
                //switchProject.setTitleColor(UIColorFromRGB(0x666666), forState: .Normal)
                switchProject.addTarget(self, action: #selector(DSMineViewController.addGoMyProject), forControlEvents: .TouchDown)
                let switchItem:UIBarButtonItem = UIBarButtonItem.init(customView: switchProject)
                self.navigationItem.leftBarButtonItem = switchItem
                self.reloadTableView(.MineProject_login_authentication)
            }
            break
            //个人投资方
        case "INDIVIDUAL","ROLE_INDIVIDUAL":
            if DSAccountInfo.sharedInstance().authorized == "0"{
                self.reloadTableView(.MineInvestors_login_unauthentication)
            }else{
                self.reloadTableView(.MineInvestors_login_authentication_father)
            }
            break
            //投资方
        case "INSTITUTIONER","INSTITUTION_CREATOR":
            if DSAccountInfo.sharedInstance().authorized == "0"{
                self.reloadTableView(.MineInvestors_login_unauthentication)
            }else{
                self.reloadTableView(.MineInvestors_login_authentication_child)
            }
            break
        case "PARK_ADMIN":
            if DSAccountInfo.sharedInstance().authorized == "0"{
                self.reloadTableView(.MinePark_login_authentication)
            }else{
                self.reloadTableView(.MinePark_login_authentication)
            }
        default:
            break
        }
    }
    
    func reloadTableView(status:MineStatus){
        self.status=status
        self.initDataWithMineStatus(self.status)
        self.myTableView.reloadData()
    }
    
    func initDataWithMineStatus(status:MineStatus){
        self.dataSource.removeAllObjects()
        switch status {
        case MineStatus.MineInvestors_login_unauthentication:
            self.initStatusOne()
            break
        case MineStatus.MineInvestors_login_authentication_father:
            self.initStatusTwo()
            break
        case MineStatus.MineInvestors_login_authentication_child:
            self.initStatusThird()
            break
        case MineStatus.MineProject_login_unauthentication:
            self.initStatusFourth()
            break
        case MineStatus.MineProject_login_authentication:
            self.initStatusFifth()
            break
        case MineStatus.MinePark_login_authentication:
            self.initStatusSixth()
            break
        }
    }
    
    /**投资方已登录 未认证*/
    func initStatusOne(){
        self.initUnauthenticationHead()
        let arr2 = NSMutableArray()
        self.initInverStorsAuthentication(arr2)
        self.initMyActivity(arr2)
        self.dataSource.addObject(arr2)
        self.initThirdSection()
    }
    /**投资方已登录 已认证(个人投资者)*/
    func initStatusTwo(){
        httpGetPersonAccountRequire()
        self.initAuthenticationHead(false,subTitle:"个人投资者")
        let arr2 = NSMutableArray()
        self.initMyDate(arr2)
        self.initInviteMe(arr2)
        self.initMyCollection(arr2)
        self.initMyActivity(arr2)
        self.dataSource.addObject(arr2)
        self.initThirdSection()
    }
    /**投资方已登录 已认证(子账号)*/
    func initStatusThird(){
        httpGetPersonAccountRequire()
        self.initAuthenticationHead(true,subTitle: "机构投资方员工子账户")
        let arr2 = NSMutableArray()
        self.initMyDate(arr2)
        self.initInviteMe(arr2)
        self.initMyCollection(arr2)
        self.initMyActivity(arr2)
        self.dataSource.addObject(arr2)
        self.initThirdSection()
        
    }
    /**项目方已登录 未认证*/
     func initStatusFourth(){
        self.initUnauthenticationHead()
        let arr2 = NSMutableArray()
        self.initAuthenticationProgram(arr2)
        self.initMyActivity(arr2)
        self.dataSource.addObject(arr2)
        self.initThirdSection()
    }
    
    
     /**项目方已登录 已认证*/
    func initStatusFifth(){
        self.getHttpProjectdetailsRequire()
        self.initAuthenticationHead(true,subTitle:self.getProjectSubTitle())
        let arr2 = NSMutableArray()
        self.initMyProgram(arr2)
        self.initDateMy(arr2,num:self.followNum)
        self.initMyFollow(arr2)
        self.initMyCollection(arr2)
        self.initMyActivity(arr2)
        self.dataSource.addObject(arr2)
        self.initThirdSection()
    }
    func getProjectSubTitle() -> (String) {
        var str = String()
        if DSAccountInfo.sharedInstance().companyName != nil && DSAccountInfo.sharedInstance().position != nil {
            str = (DSAccountInfo.sharedInstance().companyName?.stringByAppendingString("  "+DSAccountInfo.sharedInstance().position!))!
            return str
        }else if DSAccountInfo.sharedInstance().companyName != nil && DSAccountInfo.sharedInstance().position == nil{
            return DSAccountInfo.sharedInstance().companyName!
        }
        return str
    }
    
    
    /**园区方已登录 已认证*/
    func initStatusSixth(){
        var str = String()
        httpGetPersonAccountRequire()
        str = DSAccountInfo.sharedInstance().parkName!+" "+DSAccountInfo.sharedInstance().job!
        self.initAuthenticationHead(true,subTitle:str)
        let arr2 = NSMutableArray()
        self.initMyCollection(arr2)
        self.initMyActivity(arr2)
        self.dataSource.addObject(arr2)
        self.initThirdSection()
    }
    

    func initThirdSection(){
        let arr3 = NSMutableArray()
        self.initShareToFriend(arr3)
        self.initSetting(arr3)
        self.dataSource.addObject(arr3)
    }
}

class DSMineTableViewDelegate: HTBaseTableViewDelegate {
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section==0){
            return 0
        }
        return 15
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section==0{
            return 145
        }else{
            return 44
        }
    }
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.backgroundColor = UIColor.clearColor()
    }
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor=UIColor.clearColor()
    }
}
