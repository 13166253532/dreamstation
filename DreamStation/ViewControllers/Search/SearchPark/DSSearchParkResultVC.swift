//
//  DSSearchParkResultVC.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/13.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSSearchParkResultVC: HTBaseViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var attImage: UIImageView!
    @IBOutlet var attLabel: UILabel!

    var name:String?
    var dataSource:NSMutableArray = NSMutableArray()
    var delegate:DSSearchParkResultVCDelegate!
    
    var page = 0
    //顶部刷新
    var header = MJRefreshNormalHeader()
    //底部刷新
    var footer = MJRefreshAutoNormalFooter()
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSSearchParkResultVC", bundle: nil)
        let vc:DSSearchParkResultVC=storyboard.instantiateViewControllerWithIdentifier("DSSearchParkResultVC")as! DSSearchParkResultVC
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.backgroundColor = grayBgColor
        self.navigationController?.navigationBar.lt_reset()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTitleBar()
        self.attImage.hidden = true
        self.attLabel.hidden = true
        self.initTableViewData()
        self.initTableView()
    }
    override func initTitleBar() {
        super.initTitleBar()
        self.title=self.name
    }
    func initTableView(){
        self.addHeaderFooter()
        self.delegate = DSSearchParkResultVCDelegate()
        registerCell(self.tableView, cell: DSParkPageCell.self)
        delegate.dataSource = self.dataSource
        self.tableView.delegate = self.delegate
        self.tableView.dataSource = self.delegate
        setExtraCellLineHidden(self.tableView)
    }
    
    //MARK:添加上拉加载 下拉刷新
    func addHeaderFooter(){
        self.header.setRefreshingTarget(self, refreshingAction: #selector(DSSearchParkResultVC.upPullLoadData))
        self.header.lastUpdatedTimeLabel.hidden = true
        self.header.stateLabel.hidden = true
        self.footer.setRefreshingTarget(self, refreshingAction: #selector(DSSearchParkResultVC.downPlullLoadData))
        self.footer.stateLabel.hidden = true
        self.footer.refreshingTitleHidden = true
        self.tableView.mj_header = self.header
        self.tableView.mj_footer = self.footer
    }
    
    //MARK:下拉刷新
    func upPullLoadData(){
        self.page = 0
        self.dataSource = NSMutableArray()
        self.initTableViewData()
        self.initTableView()
        self.tableView.reloadData()
        //        self.myTableView.mj_footer.endRefreshing()
        //        self.myTableView.mj_header.endRefreshing()
    }
    //MARK:上拉加载
    func downPlullLoadData(){
        self.initTableViewData()
        self.tableView.reloadData()
    }

    func initTableViewData(){
        self.httpSearchParkRequier(self.name!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

class DSSearchParkResultVCDelegate: DSLoginTableViewDelegate {
    let bizhi = Double(UIScreen.mainScreen().bounds.height)/568
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 260*CGFloat(bizhi)
    }
    override  func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.backgroundColor = UIColor.clearColor()
    }
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor=UIColor.clearColor()
    }
}

extension DSSearchParkResultVC{
    
    func httpSearchParkRequier(name:String){
        let cmd:DSHttpParkListCmd = DSHttpParkListCmd.httpCommandWithVersion(PHttpVersion_v1) as!DSHttpParkListCmd
        let block:httpBlock = {[weak self](result:RequestResult!,useInfo:AnyObject!)->()in
            self!.httpSearchParkResult(result)
        }
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate = completeDelegate
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_ParkList_park] = name
        dic[kHttpParamKey_ParkList_page] = String(self.page)
        cmd.requestInfo = dic as [NSObject:AnyObject]
        print("url == ",cmd.getUrl())
        cmd.execute()
    }
    
    func httpSearchParkResult(result:RequestResult){
        let r:DSHttpParkListResult = result as! DSHttpParkListResult
        if r.isOk() {
            if r.getAllContents().count > 0 {
                self.page = self.page + 1
                self.getSearchParkData(r.getAllContents())
            }else{
                if self.dataSource.count == 0{
                    self.attImage.hidden = false
                    self.attLabel.hidden = false
                }
            }
        }
        self.tableView.mj_footer.endRefreshing()
        self.tableView.mj_header.endRefreshing()
    }
    
    func getSearchParkData(data:NSMutableArray){
        //self.dataSource.removeAllObjects()
        for index in 0..<data.count {
            let webInfo = data[index] as! DSSearchParkInfo
            let info:DSParkCellModel = DSParkCellModel()
            info.className = "DSParkPageCell"
            info.headImage = self.judgeString(webInfo.videoImage)
            info.parkName = webInfo.parkName
            info.parkSub = webInfo.introduction
            info.cityName = self.tiHuanAddress(webInfo.detailAddressArray)
            if self.isIncludeChineseIn(self.judgeString(webInfo.videoImage)) != true {
                info.videoImage = self.judgeString(webInfo.videoImage)
            }
            info.videoSub = webInfo.videoTitle
            info.block = {[weak self]in
                if self?.checkoutLogin() == true {
                    self?.checkoutAuthorized(webInfo.id!)
                }else{
                    self!.gotoLoginVC()
                }
            }
            info.goBlock = {[weak self](value:AnyObject)in
                if DSAccountInfo.sharedInstance().personId != nil  {
                    if DSAccountInfo.sharedInstance().authorized == "1" {
                        if self!.isIncludeChineseIn(webInfo.videoUrl!) != true {
                            //self!.pushWebViewController(infos.videoUrl!,title: infos.videoTitle)
                            self!.judgeRoleName(webInfo)
                        }else{
                            SMToast("视频地址有误！")
                        }
                    }else{
                        SMToast("由于您的身份限制，暂时无法查看")
                    }
                }else{
                    self!.gotoLoginVC()
                }
            }
            self.dataSource.addObject(info)
            self.tableView.reloadData()
        }
    }
    func judgeRoleName(infos:DSSearchParkInfo){
        if DSAccountInfo.sharedInstance().role != "PARK_ADMIN"  {
            //self.pushWebViewController(infos.videoUrl!,title: infos.videoTitle)
            self.gotoYouKuVideoPlayView(infos.videoUrl!, title: infos.videoTitle)
        }else{
            if DSAccountInfo.sharedInstance().personId == infos.id {
                //self.pushWebViewController(infos.videoUrl!,title: infos.videoTitle)
                self.gotoYouKuVideoPlayView(infos.videoUrl!, title: infos.videoTitle)
            }else{
                SMToast("由于您的身份限制，暂时无法查看")
            }
        }
    }
    
    func gotoLoginVC(){
        let vc:DSLoginViewController = DSLoginViewController.createViewController(nil) as! DSLoginViewController
        vc.loginReturnType = LOGINTYPE.TABBARLOGIN
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(vc, animated: true)
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
    func tiHuanAddress(arr:NSMutableArray) -> (String) {
        var address = String()
        if arr.count != 0 {
            for index in 0..<arr.count {
                let addressInfo:DSParkListDetailAddressinfo = arr[index] as! DSParkListDetailAddressinfo
                if address.characters.count == 0 {
                    address = addressInfo.city!
                }else{
                    address = address+"/"+addressInfo.city!
                }
            }
        }
        return address
    }

    
    func shifouLogin() -> (Bool) {
        if DSAccountInfo.sharedInstance().personId != nil {
            return true
        }else{
            return false
        }
    }
    func puanduanauthorized(id:String){
        if DSAccountInfo.sharedInstance().authorized == "1" {
            let vc:DSParkDetailsVC=DSParkDetailsVC.createViewController(nil) as! DSParkDetailsVC
            vc.parkId = id
            vc.hidesBottomBarWhenPushed = true
            self.pushViewController(vc, animated: true)
        }else{
            SMToast("由于您的身份限制：暂时无法查看")
        }
    }

//    func pushWebViewController(urlstr:String,title:String?) {
//        let URL:NSURL = NSURL.init(string: urlstr)!
//        
//        let webViewController:STKWebKitViewController = STKWebKitViewController.init(URL: URL)
//        webViewController.hidesBottomBarWhenPushed=true;
//        if title != nil {
//            webViewController.title = title
//        }
//        self.navigationController?.pushViewController(webViewController, animated: true)
//    }
    func judgeString(str:String?)->(String){
        if str != nil {
            return HTHttpConfig.sharedInstance().getServerAddress("").stringByAppendingFormat("/resource/view/"+str!)
        }
        return ""
    }
    
    func isIncludeChineseIn(string: String) -> Bool {
        for (_, value) in string.characters.enumerate() {
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }
 
}
