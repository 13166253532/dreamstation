//
//  DSActivityDetailViewController.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/25.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSActivityDetailViewController: HTBaseViewController {
    
    @IBOutlet var detailTableView: UITableView!
    
    @IBOutlet var detailBtn: UIButton!
    
    @IBOutlet var tabelViewLayout: NSLayoutConstraint!
    var testTitle:String?
    var testImage:String?
    var pageUrl:String?
    var activityId : String?
    var info:DSActivityCellModel!
    var delegate:DSActivityDetailDelegate!
    var dataSource:NSMutableArray = NSMutableArray()
    var isMyActivity:Bool!
    var titleImageString:String?
    var titleString:String?
    var introductString:String?
    var testUrl:String?
    var isClickShare:Bool = true
    
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard = UIStoryboard(name: "DSActivityDetailViewController", bundle: nil)
        let vc:DSActivityDetailViewController=storyboard.instantiateViewControllerWithIdentifier("DSActivityDetailViewController") as! DSActivityDetailViewController
        
        return vc
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailBtn.layer.cornerRadius = 3
        self.edgesForExtendedLayout = UIRectEdge.None
        self.initTitleBar()
        self.initTableView()
     
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.httpActivityDetailRequire()
    }
    
    
    override func initTitleBar() {
        super.initTitleBar()
        self.title = loadString("DSActivityDetailTitle", tableId: TITLESTRINGTABLEID)
        let rightBtn:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "homePage_fenxiang"), style: .Plain, target: self, action: #selector(DSActivityDetailViewController.clickShare))
        
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    
    //MARK:------分享
    func clickShare(){
        self.pageUrl = "http://www.wingmediadream.com/wingmedia_web/share/activity.html?id="+self.activityId!
//        HTShareSDKTool.sharedShareSDKTool().shareForPlat(self.pageUrl, withImage: "share_weibo", withTitle: self.testTitle)
//        HTShareSDKTool.sharedShareSDKTool().registerApp()
        
        
        //if self.isClickShare == true {
            let shareAlertView:XSShareAlertView = XSShareAlertView.init(cancelBtn: {
                print("取消")
                //self.isClickShare = true
                }, withSinaBtn: {
                    [weak self] in
                    self!.sinaAlertView()
                }, withWechatBtn: {[weak self] in
                    self!.wechatAlertView()
            }) {
                self.momentAlerView()
            }
            self.view.window!.addSubview(shareAlertView)
            //self.isClickShare = false
       // }
  
    }
    
    //MARK:---新浪分享
    func sinaAlertView(){
        
//        let sinaView:XSSinaShareAlertView = XSSinaShareAlertView.init(cancelBtn: {
//            print("取消")
//            self.isClickShare = true
//            }, withSureBtn: { (value:String?) in
//                print(value)
//                self.isClickShare = true
                //let resultString:String = self.titleString!.stringByAppendingString(self.isPassValue(value))
        
        var str = String()
        if self.titleString != nil {
            str = "我在极客出发发现了一个很棒的活动【"+self.titleString!+"】，你们快来看看吧！"
        }else{
            str = "我在极客出发发现了一个很棒的活动【】，你们快来看看吧！"
        }
        HTShareSDKTool.sharedShareSDKTool().shareForSina(str, withImage: self.titleImageString, withUrl: self.pageUrl)
        
//            }, withImageString: self.titleImageString, withTitleString: self.titleString);
//        self.view.window!.addSubview(sinaView)
    }
    func isPassValue(str:String?)->(String){
        if str != nil {
            return str!
        }
        return ""
    }
    
    
    //MARK:---微信分享
    func wechatAlertView(){

//        let wechatView:XSWechatShareAlertView = XSWechatShareAlertView.init(cancelBtn: { 
//            print("取消")
//            self.isClickShare = true
//            }, withSureBtn: { (value:String?) in
//                print(value)
//                self.isClickShare = true
                HTShareSDKTool.sharedShareSDKTool().shareForWechat(self.titleString, withImage: self.titleImageString, withUrl: self.pageUrl, withContent: self.webchatString() as String)
//            }, withTitle: self.titleString, withTitleImage: self.titleImageString, withContent: self.introductString)
//        self.view.window!.addSubview(wechatView)
        
    }
    func webchatString()->(NSString){
        if self.introductString == nil || self.introductString!.characters.count == 0 {
            return "活动介绍：无"
        }else{
            return self.introductString! as NSString
        }
    }
    
    //MARK:---微信朋友圈分享
    func momentAlerView(){
        
//        let momentView:XSMomentsShareAlertView = XSMomentsShareAlertView.init(cancelBtn: { 
//            print("取消")
//            self.isClickShare = true
//            }, withSureBtn: { 
//                print("确定")
//                self.isClickShare = true
                HTShareSDKTool.sharedShareSDKTool().shareForMoments(self.titleString, withImage: self.titleImageString, withUrl: self.pageUrl)
            //}, withImageString: self.titleImageString, withTitle:self.titleString)
//        self.view.window!.addSubview(momentView)
    }
    
    
    func initTableView(){
        if isMyActivity == true {
            self.detailBtn.hidden = true
            self.tabelViewLayout.constant = 0
        }
        self.initTableViewData()
        self.delegate = DSActivityDetailDelegate()
        self.delegate.dataSource = self.dataSource
        registerCell(self.detailTableView, cell: DSActivityDetailFirstCell.self)
        registerCell(self.detailTableView, cell: DSActivityDetailSecondCell.self)
        registerCell(self.detailTableView, cell: DSActivityDetailThirdCell.self)
        self.detailTableView.delegate = self.delegate
        self.detailTableView.dataSource = self.delegate
        self.detailTableView.backgroundColor = loginBg_Color
    }
    func initTableViewData(){
        self.httpActivityDetailRequire()
    }

    @IBAction func btnOfClick(sender: UIButton) {
        
        let vc:DSActivityJoinViewController = DSActivityJoinViewController.createViewController(nil) as! DSActivityJoinViewController
        vc.activityId = self.activityId
        self.pushViewController(vc, animated: true)
   
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DSActivityDetailViewController{

    func httpActivityDetailRequire(){
    
        let cmd:HttpCommand = DSHttpDetailActivityCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {
            (result:RequestResult!,useInfo:AnyObject!)->() in
            self.httpActivityDetailResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_DetailActivity_id] = self.activityId
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url==%@",cmd.getUrl())
        self.testUrl = cmd.getUrl()
        cmd.execute()
        
    }
    
    func httpActivityDetailResponse(result:RequestResult){
        
        let r:DSHttpDetailActivityResult = result as! DSHttpDetailActivityResult
        if result.isOk() {
            self.getHttpData(r.getAllData())
            self.detailTableView.reloadData()
        }
    }
    
    func getHttpData(data:DSDetailActivityInfo){
        self.dataSource.removeAllObjects()
        self.initFirstTableData(data)
        self.initSecondTableData(data)
    }
    
    func initFirstTableData(data:DSDetailActivityInfo){
        
        let infoList:NSMutableArray = NSMutableArray()
        
        let firstCellInfo:DSDetailFirstCellModel = DSDetailFirstCellModel()
        firstCellInfo.className = "DSActivityDetailFirstCell"
       
        self.titleImageString =  HTHttpConfig.sharedInstance().getServerAddress("").stringByAppendingFormat("/resource/view/"+data.smartImage!)
        self.titleString = data.name
        firstCellInfo.titleImageValue = self.titleImageString
        firstCellInfo.titleLabelValue = data.name
        firstCellInfo.status = data.status
        
        let secondCellInfo:DSDetailSecondCellModel = DSDetailSecondCellModel()
        secondCellInfo.className = "DSActivityDetailSecondCell"
        secondCellInfo.locationValue = data.address
        let str:String = "-"
        let str1 = str+timeStampToString(data.endTime!)
        let dateStr = timeStampToString(data.beginTime!) + str1
        secondCellInfo.datelValue = dateStr
        
        infoList.addObject(firstCellInfo)
        infoList.addObject(secondCellInfo)
        self.dataSource.addObject(infoList)

        if data.userSign == "1" {
            self.detailBtn.enabled = false
            self.detailBtn.setTitle("已报名", forState: .Normal)
            self.detailBtn.backgroundColor = enabledColor
        }else if firstCellInfo.status == "SIGN_UP" {
            self.detailBtn.enabled = true
            self.detailBtn.setTitle("报名", forState: .Normal)
            self.detailBtn.backgroundColor = greenNavigationColor
        }else{
            self.detailBtn.enabled = false
            self.detailBtn.setTitle("报名截止", forState: .Normal)
            self.detailBtn.backgroundColor = enabledColor
        }
}
    
    func initSecondTableData(data:DSDetailActivityInfo){
        
        let detailInfoList:NSMutableArray = NSMutableArray()
        
        let thirdCellInfo:DSDetailThirdCellModel = DSDetailThirdCellModel()
        thirdCellInfo.className = "DSActivityDetailThirdCell"
        thirdCellInfo.introducValue = data.description2
        self.introductString = data.description2
        detailInfoList.addObject(thirdCellInfo)
        self.testTitle = data.description2
        self.dataSource.addObject(detailInfoList)
    }
}


class DSActivityDetailDelegate: HTBaseTableViewDelegate {

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section==0{
            return 0
        }else{
            return 10
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        if indexPath.section == 0&&indexPath.row == 0 {
            return 130
        }else if indexPath.section == 0&&indexPath.row == 1{
            return 88
        }
        else if indexPath.section == 1&&indexPath.row == 0 {
            //return getTextRectSize(self.dataSource.objectAtIndex(1).firstObject().introducValue!, font: UIFont.systemFontOfSize(14), size: CGSizeMake(tableView.frame.width-20, 1000)).height+50
           let infoArray = self.dataSource[1] as! NSMutableArray
            let info = infoArray[0] as! DSDetailThirdCellModel
           return getTextRectSize(info.introducValue, font: UIFont.systemFontOfSize(14), size: CGSizeMake(tableView.frame.width-20, 1000)).height+50
            }
        return 0
    }
}

