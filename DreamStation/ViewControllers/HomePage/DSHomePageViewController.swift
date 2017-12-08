//
//  DSHomePageViewController.swift
//  DreamStation
//
//  Created by QPP on 16/7/19.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

private let STRINGTABLEID:String="DSHomePageViewControllerStrings"

class DSHomePageViewController: HTBaseViewController {

    @IBOutlet var homeTableView: UITableView!
    
    var delegate:DSHomePageTableViewDelegate!
    var dataSource:NSMutableArray!
    var imageDataSource:NSMutableArray=NSMutableArray()
    var textContent:NSMutableArray = NSMutableArray()
    
    var BannerInfo:DSHomePageImagePlayerModel!
    
    var homeCellInfo:DSHomePageCellModel!
    var homeCellInfo1:DSHomePageCellModel!
    var homeCellInfo2:DSHomePageCellModel!
    var messageBtn:UIButton!
    var page = 0
    //顶部刷新
    var header = MJRefreshNormalHeader()
    //底部刷新
    var footer = MJRefreshAutoNormalFooter()
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSHomePageViewController", bundle: nil)
        let vc:DSHomePageViewController=storyboard.instantiateViewControllerWithIdentifier("DSHomePageViewController")as! DSHomePageViewController
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTitleBar()
        self.initTableView()
        self.addHeaderFooter()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //HTHttpConfig.sharedInstance().isout=false//内网
        HTHttpConfig.sharedInstance().isout=true//外网
        self.homeTableView.reloadData()
        self.messageBtnImage()
        self.httpBannerRequire()
        self.httpHomeRequire()
    }
    
    //MARK:添加上拉加载 下拉刷新
    func addHeaderFooter(){
        self.header.setRefreshingTarget(self, refreshingAction: #selector(DSHomePageViewController.upPullLoadData))
        self.header.lastUpdatedTimeLabel.hidden = true
        self.header.stateLabel.hidden = true
//        self.footer.setRefreshingTarget(self, refreshingAction: #selector(DSHomePageViewController.downPlullLoadData))
        self.footer.stateLabel.hidden = true
        self.footer.refreshingTitleHidden = true
        self.homeTableView.mj_header = self.header
        self.homeTableView.mj_footer = self.footer
        self.homeTableView.backgroundColor = loginBg_Color
        self.homeTableView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            self.downPlullLoadData()
        })
    }
    
    //MARK:下拉刷新
    func upPullLoadData(){
        self.page = 0
        self.httpBannerRequire()
        self.httpHomeRequire()
    }
    
    //MARK:上拉加载
    func downPlullLoadData(){
        self.homeTableView.mj_footer.endRefreshing()
     }
    
    
    func initTableView(){
        self.initTableViewData()
        self.delegate = DSHomePageTableViewDelegate()
        self.delegate.dataSource = self.dataSource
        registerCell(self.homeTableView, cell: DSHomePageBannerTableViewCell.self)
        registerCell(self.homeTableView, cell: DSHomePageTableViewCell.self)
        self.homeTableView.delegate = self.delegate
        self.homeTableView.dataSource = self.delegate
        self.homeTableView.backgroundColor = NavigationTextFieldColor
    }

    func initTableViewData(){
        self.dataSource = NSMutableArray()
        self.initBannerView()
        self.initViewCell()
    }
    
    
    func initBannerView(){
        BannerInfo = DSHomePageImagePlayerModel()
        BannerInfo.className = "DSHomePageBannerTableViewCell"
        BannerInfo.block={
            [weak self](banner:AnyObject) in
            let url:String=banner as! String
            //self!.pushWebViewController(url,title: String())
            self?.gotoYouKuVideoPlayView(url, title: String())
        }
        
        self.dataSource.addObject(BannerInfo)
    }
    
//    func pushWebViewController(urlstr:String,title:String?) {
//        let URL:NSURL = NSURL.init(string: urlstr)!
//        let webViewController:STKWebKitViewController = STKWebKitViewController.init(URL: URL)
//        if title != nil {
//            webViewController.title = title
//        }
//        webViewController.hidesBottomBarWhenPushed=true;
//        
//        self.navigationController?.pushViewController(webViewController, animated: true)
//      
//    }
    
    
    
    func initViewCell(){
       
        homeCellInfo = DSHomePageCellModel()
        homeCellInfo.className = "DSHomePageTableViewCell"
        homeCellInfo.labelText = "项目方视频集锦"
        homeCellInfo.block = {
        }
        
        homeCellInfo1 = DSHomePageCellModel()
        homeCellInfo1.className = "DSHomePageTableViewCell"
        homeCellInfo1.labelText = "投资方方视频集锦"
        homeCellInfo1.block = {
        }
        
        homeCellInfo2 = DSHomePageCellModel()
        homeCellInfo2.className = "DSHomePageTableViewCell"
        homeCellInfo2.labelText = "园区视频集锦"
        homeCellInfo2.block = {
        }
        
        self.dataSource.addObject(homeCellInfo)
        self.dataSource.addObject(homeCellInfo1)
        self.dataSource.addObject(homeCellInfo2)
       
    }
    
    override func initTitleBar() {
        super.initTitleBar()
        self.title=loadString("DSHomePageTitle", tableId: TITLESTRINGTABLEID)
        
        let leftBtn:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "homePage_player"), style: .Plain, target: self, action: #selector(playerOfClick))
        self.navigationItem.leftBarButtonItem = leftBtn
        
        let rightBtn1:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "homePage_activity"), style: .Plain, target: self, action: #selector(activityOfClick))

        self.messageBtn = UIButton.init(type: .Custom)
        self.messageBtn.frame = CGRectMake(0, 0, 23, 23)
        self.messageBtn.addTarget(self, action: #selector(messageOfClick), forControlEvents: .TouchUpInside)
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
    
    //MARK:切换网络
    func change(sender:UIButton){
        sender.selected = !sender.selected
        if sender.selected == true {
            sender.setTitle("外网", forState: .Normal)
            HTHttpConfig.sharedInstance().isout=true
            self.httpBannerRequire()
            self.httpHomeRequire()
            
        }else{
            sender.setTitle("内网", forState: .Normal)
            HTHttpConfig.sharedInstance().isout=false
            self.httpBannerRequire()
            self.httpHomeRequire()
        }
    }
    
    //MARK:消息
    func messageOfClick(){
        self.messageBtn.enabled = false
        if DSAccountInfo.sharedInstance().access_token != nil&&DSAccountInfo.sharedInstance().personId != nil {
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

    //MARK:活动
    func activityOfClick(){
  
        let vc:DSActivityViewController = DSActivityViewController.createViewController(nil) as! DSActivityViewController
         vc.hidesBottomBarWhenPushed = true
         vc.isMyActivity = false
        self.pushViewController(vc, animated: true)
        
    }
    //MARK:视频播放
    func playerOfClick(){

        let vc:DSVideoPlayerViewController = DSVideoPlayerViewController.createViewController(nil) as! DSVideoPlayerViewController
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension DSHomePageViewController{
    
    func httpBannerRequire(){
        let cmd:HttpCommand=DSHttpBannerCmd.httpCommandWithVersion(PHttpVersion_v1)!
        let block:httpBlock={[weak self]
            (result:RequestResult!,useInfo:AnyObject!)->() in
            self!.httpBannerResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpBannerResponse(result:RequestResult){
        let r:DSHttpBannerResult=result as! DSHttpBannerResult
         if r.isOk(){
            self.BannerInfo.data = NSMutableArray()
            //self.BannerInfo.data = r.getBannerList()
            self.bannerImage(r.getBannerList())
        }
    }
    
    func bannerImage(httpList:NSMutableArray) {
        let config:HTHttpConfig = HTHttpConfig.sharedInstance()
        let baseImageUrl:String = config.getServerAddress("")
        for index in 0..<httpList.count {
            let aa:DSBannerInfo = httpList[index] as! DSBannerInfo
            aa.image = baseImageUrl.stringByAppendingFormat("/resource/view/"+aa.image!)
            if aa.isPublish == "1" {
              self.BannerInfo.data.addObject(aa)
            }
        }
        self.homeTableView.reloadData()
    }
    
    func httpHomeRequire(){
    
        let cmd:HttpCommand = DSHttpProgramsListCmd.httpCommandWithVersion(PHttpVersion_v1)
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_ProgramsList_type] = "HOME"
        dic[kHttpParamKey_ProgramsList_page] = "0"
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let block:httpBlock = {
            (result:RequestResult!,useInfo:AnyObject!)->() in
            self.httpHomeResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate = completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpHomeResponse(result:RequestResult){
    
        let r:DSHttpProgramsListResult = result as! DSHttpProgramsListResult
        if r.isOk() {
            self.getHttpData(r.getAllContent())
            //self.initTableViewData()
            self.homeTableView.reloadData()
        }
        self.homeTableView.mj_header.endRefreshing()


    }
    
    func getHttpData(data:NSMutableArray){
        if data.count==1{
            
            let httpInfo = data[0] as! DSProgramsListInfo
            self.getOrder(httpInfo)
            self.dataSource.addObject(homeCellInfo)
        }
        
        if data.count>1 {
            let httpInfo = data[0] as! DSProgramsListInfo
            self.getOrder(httpInfo)
            let httpInfo1 = data[1] as! DSProgramsListInfo
            self.getOrder(httpInfo1)
            if data.count == 3{
                let httpInfo2 = data[2] as! DSProgramsListInfo
                self.getOrder(httpInfo2)
            }
        }
        self.homeTableView.reloadData()
    }
    func getOrder(httpinfo:DSProgramsListInfo) {
        var typeStr = String()
        if httpinfo.type != nil {
            typeStr = httpinfo.type!
        }
        switch typeStr {
        case "PROVIDER":
            self.addCell(homeCellInfo, httpinfo: httpinfo)
            break
        case "INDIVIDUAL":
            self.addCell(homeCellInfo1, httpinfo: httpinfo)
            break
        case "PARK":
            self.addCell(homeCellInfo2, httpinfo: httpinfo)
            break
        default:
            break
        }
    }
    func addCell(cellinfo:DSHomePageCellModel,httpinfo:DSProgramsListInfo){
        let config:HTHttpConfig = HTHttpConfig.sharedInstance()
        let baseImageUrl:String = config.getServerAddress("")
        let imageUrl2:String = baseImageUrl.stringByAppendingFormat("/resource/view/"+httpinfo.image!)
        cellinfo.imageText = imageUrl2
        cellinfo.labelText = httpinfo.text
        cellinfo.type = httpinfo.type
        cellinfo.block = {
            [weak self] in
            //self?.pushWebViewController(httpinfo.video!,title: httpinfo.text)
            self?.gotoYouKuVideoPlayView(httpinfo.video!, title: httpinfo.text)
        }
    }
}

class DSHomePageTableViewDelegate: DSLoginTableViewDelegate {
    var bizhi:CGFloat!
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //if bizhi != nil {
            //return (UIScreen.mainScreen().bounds.width-20)/bizhi+10
        //}else{
            //return (UIScreen.mainScreen().bounds.width-20)/(533/300)+10
        //}
        if indexPath.row == 0 {
            return (UIScreen.mainScreen().bounds.width)/(750/400)+10
        }else{
            return (UIScreen.mainScreen().bounds.width-20)/(710/320)+56
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section==0{
            return 0
        }else{
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.backgroundColor = UIColor.clearColor()
    }
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor=UIColor.clearColor()
    }
    
}
