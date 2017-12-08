//
//  DSParkViewController.swift
//  DreamStation
//
//  Created by QPP on 16/7/19.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSParkViewController: HTBaseViewController {

    @IBOutlet weak var layout: NSLayoutConstraint!
    
    @IBOutlet weak var myTableView: UITableView!

    @IBOutlet weak var tixingLabel: UILabel!
    @IBOutlet weak var tixingImage: UIImageView!
    var delegate:DSParkTableViewDelegate!
    var dataSource = NSMutableArray()
    var Shutdown = false
    var cityName:String?
    var messageBtn:UIButton!
    var cityCellInfo:DSParkCellModel!
    
    var page = 0
    //顶部刷新
    var header = MJRefreshNormalHeader()
    //底部刷新
    var footer = MJRefreshAutoNormalFooter()
    
    var dingshiTime:NSTimer?
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSParkViewController", bundle: nil)
        let vc:DSParkViewController=storyboard.instantiateViewControllerWithIdentifier("DSParkViewController")as! DSParkViewController
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityName = "全部"
        self.initTitleBar()
        //self.httpParkListRequire()
        self.initTableView()
        self.cityCellInfo.cityName=self.cityName
        self.page = 0
        self.cleanData()
        self.parkHttpRequire()

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.messageBtnImage()
        if self.cityName != self.cityCellInfo.cityName {
            self.cityCellInfo.cityName=self.cityName
            self.page = 0
            self.cleanData()
            self.parkHttpRequire()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func initTitleBar() {
        super.initTitleBar()
        self.view.backgroundColor = loginBg_Color
        self.title=loadString("DSParkTitle", tableId: TITLESTRINGTABLEID)
        let leftBtn:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "Park_ search"), style: .Plain, target: self, action: #selector(self.gotoSearch))
        self.navigationItem.leftBarButtonItem = leftBtn
        
        let rightBtn1:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "Park_ activity"), style: .Plain, target: self, action: #selector(self.gotoActivity))
        
        self.messageBtn = UIButton.init(type: .Custom)
        self.messageBtn.frame = CGRectMake(0, 0, 23, 23)
        self.messageBtnImage()
        self.messageBtn.addTarget(self, action: #selector(gotoMessage), forControlEvents: .TouchUpInside)
        let messageItem:UIBarButtonItem = UIBarButtonItem.init(customView: self.messageBtn)
        
        let list:NSArray = [messageItem,rightBtn1]
        self.navigationItem.rightBarButtonItems = list as? [UIBarButtonItem]

    }
    
    //改变消息按钮背景图片
    func messageBtnImage(){
        self.messageBtn.enabled = true
        if DSAccountInfo.sharedInstance().isRead == nil||DSAccountInfo.sharedInstance().isRead == "1" {
            self.messageBtn.setBackgroundImage(UIImage.init(named: "homePage_message"), forState: .Normal)
        }else{
            self.messageBtn.setBackgroundImage(UIImage.init(named: "homePage_messageNoRead"), forState: .Normal)
        }
    }
    //MARK:- 搜索
    func gotoSearch(){
        let vc:DSSearchViewController = DSSearchViewController.createViewController(nil) as! DSSearchViewController
        vc.hidesBottomBarWhenPushed = true
        vc.dataType = .ParkData
        self.pushViewController(vc, animated: true)
        
    }
    //MARK:- 活动
    func gotoActivity(){
        
        let vc:DSActivityViewController = DSActivityViewController.createViewController(nil) as! DSActivityViewController
        vc.hidesBottomBarWhenPushed = true
        vc.isMyActivity = false
        self.pushViewController(vc, animated: true)
    }
    //MARK:- 消息
    func gotoMessage(){
        self.messageBtn.enabled = false
        if DSAccountInfo.sharedInstance().personId != nil {
            let vc:DSMessageVC = DSMessageVC.createViewController(nil) as! DSMessageVC
            vc.hidesBottomBarWhenPushed = true
            self.pushViewController(vc, animated: true)
        }else{
            SMToast("请先登录")
            let vc:DSLoginViewController = DSLoginViewController.createViewController(nil) as! DSLoginViewController
            vc.loginReturnType = LOGINTYPE.TABBARLOGIN
            vc.hidesBottomBarWhenPushed = true
            self.pushViewController(vc, animated: true)
        }
    }
    
        
    func parkHttpRequire(){
        if self.cityName == "全部" {
            self.httpParkListRequire()
        }else{
            self.httpSearchParkRequire()
        }
    }
    
    
    //添加定时器
    func addTime(){
        self.dingshiTime = NSTimer.scheduledTimerWithTimeInterval(15, target: self, selector:#selector(DSParkViewController.timerAction), userInfo: nil, repeats: false)
        
    }
    func timerAction(){
        self.dingshiTime!.invalidate()
        self.dingshiTime=nil
        self.Shutdown = false
        delegate.Shutdown = self.Shutdown
        self.myTableView .reloadData()
    }
    
    
    func checkoutLogin() -> (Bool) {
        if DSAccountInfo.sharedInstance().personId != nil {
            return true
        }else{
            return false
        }
    }
    func checkoutAuthorized(id:String){
        if DSAccountInfo.sharedInstance().authorized == "1"{
            if DSAccountInfo.sharedInstance().role != "PARK_ADMIN" {
                self.gotoParkDetailsVC(id)
            }else{
                self.parkRole(id)
            }
        }else{
            SMToast("由于您的身份限制，暂时无法查看")
        }
    }
    func parkRole(id:String){
        if DSAccountInfo.sharedInstance().personId == id{
            self.gotoParkDetailsVC(id)
        }else{
            SMToast("由于您的身份限制，暂时无法查看")
        }
    }
    func gotoParkDetailsVC(id:String){
        let vc:DSParkDetailsVC=DSParkDetailsVC.createViewController(nil) as! DSParkDetailsVC
        vc.parkId = id
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(vc, animated: true)
    }
//    func pushWebViewController(urlstr:String,title:String?) {
//        let urlString = urlstr.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
//        let URL:NSURL = NSURL.init(string: urlString)!
//        let webViewController:STKWebKitViewController = STKWebKitViewController.init(URL: URL)
//        webViewController.hidesBottomBarWhenPushed=true;
//        if title != nil {
//            webViewController.title = title
//        }
//        self.navigationController?.pushViewController(webViewController, animated: true)
//    }
    func changeImgUrl(httpStr:String)->(String?){
        if self.isIncludeChineseIn(httpStr) != true {
           let url = HTHttpConfig.sharedInstance().getServerAddress("").stringByAppendingFormat("/resource/view/"+httpStr)
            return url
        }
        return nil
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
}
class DSParkTableViewDelegate: HTBaseTableViewDelegate {
    var Shutdown = false
    let bizhi = Double(UIScreen.mainScreen().bounds.height)/568
    var cityCellInfo:DSParkCellModel!
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 && indexPath.section==0{
            if Shutdown == false {
                return 50
            }else{
                return 0
            }
        }else{
            return 260*CGFloat(bizhi)
        }
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section==0{
            return 0
        }else{
            return 30
        }
    }
    override  func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell=NSBundle.mainBundle().loadNibNamed(self.cityCellInfo.className, owner: self, options: nil)?.last as! HTBaseTableViewCell
        cell.configurateTheCell(self.cityCellInfo)
        return cell//self.headView
    }
}
