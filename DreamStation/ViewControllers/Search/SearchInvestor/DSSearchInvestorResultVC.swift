//
//  DSSearchInvestorResultVC.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSSearchInvestorResultVC: HTBaseViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var attImage: UIImageView!
    @IBOutlet var attLabel: UILabel!
    
    var dataSource:NSMutableArray = NSMutableArray()
    var delegate:DSInvesTableViewDelegate!
    var name:String?
    
    var page = 0
    //顶部刷新
    var header = MJRefreshNormalHeader()
    //底部刷新
    var footer = MJRefreshAutoNormalFooter()
    
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSSearchInvestorResultVC", bundle: nil)
        let vc:DSSearchInvestorResultVC=storyboard.instantiateViewControllerWithIdentifier("DSSearchInvestorResultVC")as! DSSearchInvestorResultVC
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.attImage.hidden = true
        self.attLabel.hidden = true
        self.initTableView()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.initTitleBar()
        self.title=self.name
        self.navigationController?.navigationBar.lt_reset()
    }
    func initTableView(){
        self.initTableViewData()
        self.addHeaderFooter()
        self.delegate = DSInvesTableViewDelegate()
        self.delegate.dataSource = self.dataSource
        registerCell(self.tableView, cell: DSInvestorsTableViewCell.self)
        self.tableView.delegate = self.delegate;
        self.tableView.dataSource = self.delegate;
        self.tableView.backgroundColor = loginBg_Color
        self.tableView.separatorStyle = .None
        setExtraCellLineHidden(self.tableView)
    }
    
    //MARK:添加上拉加载 下拉刷新
    func addHeaderFooter(){
        self.header.setRefreshingTarget(self, refreshingAction: #selector(DSSearchInvestorResultVC.upPullLoadData))
        self.header.lastUpdatedTimeLabel.hidden = true
        self.header.stateLabel.hidden = true
        self.footer.setRefreshingTarget(self, refreshingAction: #selector(DSSearchInvestorResultVC.downPlullLoadData))
        self.footer.stateLabel.hidden = true
        self.footer.refreshingTitleHidden = true
        self.tableView.mj_header = self.header
        self.tableView.mj_footer = self.footer
    }
    
    //MARK:下拉刷新
    func upPullLoadData(){
        self.page = 0
        self.dataSource = NSMutableArray()
        self.initTableView()
        self.tableView.reloadData()
        //        self.tableView.mj_footer.endRefreshing()
        //        self.tableView.mj_header.endRefreshing()
    }
    //MARK:上拉加载
    func downPlullLoadData(){
        self.httpSearchInvestorRequire(self.name!)
        self.tableView.reloadData()
    }
    func initTableViewData(){
        self.httpSearchInvestorRequire(self.name!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension DSSearchInvestorResultVC{
    func httpSearchInvestorRequire(name:String){
        let cmd:DSHttpSearchInvestorCmd = DSHttpSearchInvestorCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpSearchInvestorCmd
        let block:httpBlock = {[weak self](result:RequestResult!,useInfo:AnyObject!)->()in
            self!.httpSearchInvestorRequest(result)
        }
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate = completeDelegate
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_SearchInvestor_name] = name
        dic[kHttpParamKey_SearchInvestor_page] = String(self.page)
        cmd.requestInfo = dic as [NSObject:AnyObject]
        print("url == ",cmd.getUrl())
        cmd.execute()
    }
    
    func httpSearchInvestorRequest(result:RequestResult){
        let r:DSHttpSearchInvestorResult = result as! DSHttpSearchInvestorResult
        if r.isOk() {
            if r.getSearchInvestorData().count > 0 {
                self.page = self.page + 1
                self.getSearchInvestorData(r.getSearchInvestorData())
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
    
    func getSearchInvestorData(data:NSMutableArray){
       // self.dataSource.removeAllObjects()
        
        for index in 0..<data.count {
            let webInfo:DSSearchInvestorInfo = data[index] as! DSSearchInvestorInfo
            let info:DSInvestorsCellModel = DSInvestorsCellModel()
            info.className = "DSInvestorsTableViewCell"
            info.InvesId = webInfo.id
            info.InvesName = webInfo.name
            if index == data.count-1 {
                info.isAplay = true
            }
            info.InvesHeadImageUrl = self.judgeImage(webInfo.avatar)
            info.videoText = webInfo.videoTitle
            info.videoImg = self.judgeImage(webInfo.videoImage)
            info.videoUrl = webInfo.videoUrl
            info.Invesindustry = ""
            info.InvesPhase = ""
            info.InvesLocation = ""
            info.isVideo = self.isVideo(webInfo)
            for index in 0..<webInfo.cats!.count {
                let catsInfo:DSSearchInvestorCats = webInfo.cats?[index] as! DSSearchInvestorCats
                if catsInfo.catName == "所属行业"||catsInfo.catName == "关注领域" {
                    if info.Invesindustry?.characters.count == 0 {
                        info.Invesindustry = self.appendString(catsInfo.descriptions)
                    }else{
                        info.Invesindustry = info.Invesindustry!+"／"+self.appendString(catsInfo.descriptions)
                    }
                    
                }else if catsInfo.catName == "融资阶段"||catsInfo.catName == "投资阶段"{
                    if info.InvesPhase?.characters.count == 0 {
                        info.InvesPhase = self.appendString(catsInfo.descriptions)
                    }else{
                        info.InvesPhase = info.InvesPhase!+"／"+self.appendString(catsInfo.descriptions)
                    }
                }else if catsInfo.catName == "所在地区"||catsInfo.catName == "投资地域"{
                    if info.InvesLocation?.characters.count == 0 {
                        info.InvesLocation = self.appendString(catsInfo.descriptions)
                    }else{
                        info.InvesLocation = info.InvesLocation!+"／"+self.appendString(catsInfo.descriptions)
                    }
                }else if catsInfo.catName == "投资币种"||catsInfo.catName == "主投币种"{
                    info.InvesCurrency = catsInfo.descriptions
                }else if catsInfo.catName == "投资偏好"{
                    info.preferences = catsInfo.descriptions
                }
            }
            info.block = {
                [weak self] in
                if DSAccountInfo.sharedInstance().personId != nil {
                    if self!.limitsStatus() == true {
                        self!.canEnterPerDetail(webInfo.id,num:webInfo.followNum)
                    }else{
                        SMToast("由于您的身份限制，暂时无法查看")
                    }
                }else{
                    self?.gotoLoginVC()
                }
            }
            info.videoBlock = { [weak self] in
                if DSAccountInfo.sharedInstance().personId != nil {
                    if self!.limitsStatus() == true {
                        if webInfo.videoUrl == nil {
                            SMToast("视频地址为空！")
                        }else if ((self?.isIncludeChineseIn(webInfo.videoUrl!)) != false){
                            SMToast("视频地址有误！")
                        }else{
                            self?.gotoYouKuVideoPlayView(webInfo.videoUrl!, title: webInfo.videoTitle)
                        }
                    }else{
                        SMToast("由于您的身份限制，暂时无法查看")
                    }
                }else{
                    self?.gotoLoginVC()
                }
            }
            self.dataSource.addObject(info)
        }
        self.tableView.reloadData()
    }
    func gotoLoginVC(){
        let vc:DSLoginViewController = DSLoginViewController.createViewController(nil) as! DSLoginViewController
        vc.hidesBottomBarWhenPushed = true
        vc.loginReturnType = LOGINTYPE.TABBARLOGIN
        self.pushViewController(vc, animated: true)
    }
    
    func isVideo(info:DSSearchInvestorInfo) -> (Bool){
        if info.videoUrl != nil && info.videoUrl?.characters.count != 0{
            return true
        }else{
            return false
        }
    }
    func limitsStatus()->(Bool){
        if DSAccountInfo.sharedInstance().authorized == "1" {
            return true
        }
        return false
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
    func canEnterPerDetail(id:String?,num:String?){
        let vc:DSPerInvesDetailsViewController=DSPerInvesDetailsViewController.createViewController(nil) as! DSPerInvesDetailsViewController
        //vc.invesPageType = self.invesPageType
        //vc.followNum = num
        vc.person_id = id
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(vc, animated: true)
    }
    

//    func pushWebViewController(urlstr:String,title:String?) {
//        let urlString = urlstr.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
//        let URL:NSURL = NSURL.init(string: urlString)!
//        let webViewController:STKWebKitViewController = STKWebKitViewController.init(URL: URL)
//        if title != nil {
//            webViewController.title = title
//        }
//        webViewController.hidesBottomBarWhenPushed=true;
//        self.navigationController?.pushViewController(webViewController, animated: true)
//    }

    func appendString(str:String?)->(String){
        if str != nil {
            return str!
        }
        return ""
    }
    func judgeImage(str:String?)->(String){
        if str != nil {
            return HTHttpConfig.sharedInstance().getServerAddress("").stringByAppendingFormat("/resource/view/"+str!)
        }
        return ""
    }
}
