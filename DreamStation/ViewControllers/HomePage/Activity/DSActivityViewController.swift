//
//  DSActivityViewController.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/25.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSActivityViewController: HTBaseViewController {

    @IBOutlet var activityTableView: UITableView!
    @IBOutlet var attImageView: UIImageView!
    @IBOutlet var attLabel: UILabel!
    
    var delegate:DSActivityDelegate!
    var dataSource = NSMutableArray()
    var activityInfo:DSActivityCellModel!
    var isMyActivity:Bool!
    var page = 0
    //顶部刷新
    var header = MJRefreshNormalHeader()
    //底部刷新
    var footer = MJRefreshAutoNormalFooter()
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSActivityViewController", bundle: nil)
        let vc:DSActivityViewController=storyboard.instantiateViewControllerWithIdentifier("DSActivityViewController")as! DSActivityViewController
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.attImageView.hidden = true
        self.attLabel.hidden = true
        self.initTitleBar()
        self.initTableViewData()
        self.initTableView()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //self.tabBarController!.tabBar.transform = CGAffineTransformMakeTranslation(0, 0)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //self.dataSource = NSMutableArray()
        //self.initTableViewData()
    }
    override func initTitleBar() {
        super.initTitleBar()
        if  self.isMyActivity == true  {
            self.title = loadString("DSMyActivityTitle", tableId: TITLESTRINGTABLEID)
        }else{
            self.title = loadString("DSActivityTitle", tableId: TITLESTRINGTABLEID)
        }
    }
   
    func initTableView(){
        self.addHeaderFooter()
        self.delegate = DSActivityDelegate()
        self.delegate.dataSource = self.dataSource
        registerCell(self.activityTableView, cell: DSActivityTableViewCell.self)
        self.activityTableView.delegate = self.delegate
        self.activityTableView.dataSource = self.delegate
        self.activityTableView.backgroundColor = loginBg_Color
    }
    //MARK:添加上拉加载 下拉刷新
    func addHeaderFooter(){
        self.header.setRefreshingTarget(self, refreshingAction: #selector(DSActivityViewController.upPullLoadData))
        self.header.lastUpdatedTimeLabel.hidden = true
        self.header.stateLabel.hidden = true
        self.footer.setRefreshingTarget(self, refreshingAction: #selector(DSActivityViewController.downPlullLoadData))
        self.footer.stateLabel.hidden = true
        self.footer.refreshingTitleHidden = true
        self.activityTableView.mj_header = self.header
        self.activityTableView.mj_footer = self.footer
    }
    
    //MARK:下拉刷新
    func upPullLoadData(){
        self.page = 0
        self.dataSource = NSMutableArray()
        self.initTableViewData()
        self.activityTableView.reloadData()
        //        self.activityTableView.mj_footer.endRefreshing()
        //        self.activityTableView.mj_header.endRefreshing()
    }
    //MARK:上拉加载
    func downPlullLoadData(){
        self.initTableViewData()
        self.activityTableView.reloadData()
        
    }

    func initTableViewData(){
        if self.isMyActivity == true {
            self.httpMyActivityRequire()
        }else{
            self.httpActivityListRequire()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DSActivityViewController{

    //MARK:------活动列表------
    func httpActivityListRequire(){
        let cmd:HttpCommand = DSHttpActivitiesListCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock={
            (result:RequestResult!,useInfo:AnyObject!)->() in
            self.httpActivityListResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        let dic = NSMutableDictionary()
        dic[kHttpParamKey_ActivitiesList_page] = String(self.page)
        dic[kHttpParamKey_ActivitiesList_sortType] = "ASC"
        dic[kHttpParamKey_ActivitiesList_sortItem] = "sortNumber"
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpActivityListResponse(result:RequestResult){
        let r:DSHttpActivitiesListResule = result as! DSHttpActivitiesListResule
        if result.isOk() {
            self.getHttpData(r.getAllContent())
            self.initTableView()
            self.activityTableView.reloadData()
            
        }else{
            SMToast("请查看当前网络状态！")
        }
        self.activityTableView.mj_footer.endRefreshing()
        self.activityTableView.mj_header.endRefreshing()
    }
    func getHttpData(data:NSMutableArray){
        if data.count != 0 {
            self.page = self.page + 1
        }else{
            if self.page != 1 {
                SMToast("加载完毕")
            }
        }
        let dataList:NSMutableArray = NSMutableArray()
        for index in 0 ..< data.count {
            let httpInfo=data[index] as! DSActivitiesListInfo
            let activityCellInfo = DSActivityCellModel()
            activityCellInfo.className = "DSActivityTableViewCell"
            let imageUrl:String = HTHttpConfig.sharedInstance().getServerAddress("").stringByAppendingFormat("/resource/view/"+httpInfo.smartImage!)
            activityCellInfo.activityImage = imageUrl
            activityCellInfo.titleValue = httpInfo.name
            print(httpInfo.sortNumber,httpInfo.name)
            let str:String = "-"
            let str1 = str+timeStampToString(httpInfo.endTime!)
            let dateStr = timeStampToString(httpInfo.beginTime!) + str1
            activityCellInfo.dateValue = dateStr
            activityCellInfo.locationValue = httpInfo.address
            if httpInfo.status != nil {
               activityCellInfo.status = httpInfo.status
            }else{
                continue
            }
            activityCellInfo.block = {
                [weak self]in
                if DSAccountInfo.sharedInstance().access_token != nil {
                    let vc:DSActivityDetailViewController = DSActivityDetailViewController.createViewController(nil) as! DSActivityDetailViewController
                    vc.activityId = httpInfo.id
                    vc.isMyActivity = false
                    self!.pushViewController(vc, animated: true)
                }else{
                    let vc:DSLoginViewController = DSLoginViewController.createViewController(nil) as! DSLoginViewController
                    vc.loginReturnType = LOGINTYPE.TABBARLOGIN
                    vc.hidesBottomBarWhenPushed = true
                    self!.pushViewController(vc, animated: true)
                }
            }
            if activityCellInfo.status != "SIGN_UP_END" {
               dataList.addObject(activityCellInfo)
            }
        }
        self.dataSource.addObject(dataList)
}

    //MARK: -----我的活动接口----
    func httpMyActivityRequire(){
         self.dataSource = NSMutableArray()
        let cmd:HttpCommand = DSHttpMyActivityCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {
            (result:RequestResult!,useInfo:AnyObject!)->() in
            self.httpMyAcitvityResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate = completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpMyAcitvityResponse(result:RequestResult){
        let r:DSHttpMyActivityResult = result as! DSHttpMyActivityResult
        if result.isOk() {
            self.getMyHttpData(r.getAllContent())
            self.initTableView()
            self.activityTableView.reloadData()
            
        }else{
            SMToast("请查看当前网络状态！")
        }
        self.activityTableView.mj_footer.endRefreshing()
        self.activityTableView.mj_header.endRefreshing()
    }
    func getMyHttpData(data:NSMutableArray){
        let dataList:NSMutableArray = NSMutableArray()
        if data.count == 0 {
            self.attImageView.hidden = false
            self.attLabel.hidden = false
        }else{
            for index in 0..<data.count {
                let httpInfo = data[index] as! DSMyActivityInfo
                let myActivityInfo = DSActivityCellModel()
                myActivityInfo.className = "DSActivityTableViewCell"
                myActivityInfo.activityImage = self.judgeImage(httpInfo.smartImage)
                myActivityInfo.titleValue = httpInfo.name
                let str:String = "-"
                let str1 = str+timeStampToString(httpInfo.endTime!)
                let dateStr = timeStampToString(httpInfo.beginTime!) + str1
                myActivityInfo.dateValue = dateStr
                myActivityInfo.locationValue = httpInfo.address
                myActivityInfo.status = httpInfo.status
                myActivityInfo.block = {
                    [weak self] in
                    let vc:DSActivityDetailViewController = DSActivityDetailViewController.createViewController(nil) as! DSActivityDetailViewController
                    vc.activityId = httpInfo.id
                    vc.isMyActivity = true
                    self!.pushViewController(vc, animated: true)
                }
                if myActivityInfo.status != "SIGN_UP_END"{
                    dataList.addObject(myActivityInfo)
                }
                //dataList.addObject(myActivityInfo)
            }
            self.dataSource.addObject(dataList)
        }
    }
    func judgeImage(str:String?)->(String){
        if str != nil {
            return HTHttpConfig.sharedInstance().getServerAddress("").stringByAppendingFormat("/resource/view/"+str!)
        }
        return ""
    }
}
class DSActivityDelegate: HTBaseTableViewDelegate {
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    override  func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if (section==0){
            return 0
        }
        return 0
    }
}



