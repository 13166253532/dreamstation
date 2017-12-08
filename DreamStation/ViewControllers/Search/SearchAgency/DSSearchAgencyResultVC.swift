//
//  DSSearchAgencyResultVC.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSSearchAgencyResultVC: HTBaseViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var attImage: UIImageView!
    @IBOutlet var attLabel: UILabel!
    
    var delegate:DSInvesTableViewDelegate!
    var dataSource:NSMutableArray = NSMutableArray()
    var name:String?
    
    var page = 0
    //顶部刷新
    var header = MJRefreshNormalHeader()
    //底部刷新
    var footer = MJRefreshAutoNormalFooter()
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSSearchAgencyResultVC", bundle: nil)
        let vc:DSSearchAgencyResultVC=storyboard.instantiateViewControllerWithIdentifier("DSSearchAgencyResultVC")as! DSSearchAgencyResultVC
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.lt_reset()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTitleBar()
        self.attImage.hidden = true
        self.attLabel.hidden = true
        self.initTableView()
        // Do any additional setup after loading the view.
    }
    override func initTitleBar() {
        super.initTitleBar()
        self.title=self.name
    }
    
    func initTableView(){
        self.initTableViewData()
        self.addHeaderFooter()
        self.delegate = DSInvesTableViewDelegate()
        self.delegate.dataSource = self.dataSource
        registerCell(self.tableView, cell: DSInvestorsTableViewCell.self)
        self.tableView.delegate = self.delegate
        self.tableView.dataSource = self.delegate
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
        self.httpSearchAgencyRequire(self.name!)
        self.tableView.reloadData()
    }
    
    func initTableViewData(){
        self.httpSearchAgencyRequire(self.name!)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DSSearchAgencyResultVC{
    
    func httpSearchAgencyRequire(name:String){
        let cmd:DSHttpSearchAgencyCmd = DSHttpSearchAgencyCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpSearchAgencyCmd
        let block:httpBlock = {[weak self](result:RequestResult!,useInfo:AnyObject!)->()in
            self!.httpSearchAgencyResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate = completeDelegate
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_SearchAgency_name] = name
        dic[kHttpParamKey_SearchAgency_page] = String(self.page)
        cmd.requestInfo = dic as [NSObject:AnyObject]
        print("url == ",cmd.getUrl())
        cmd.execute()
    }
    
    func httpSearchAgencyResponse(result:RequestResult){
        let r:DSHttpSearchAgencyResult = result as! DSHttpSearchAgencyResult
        if r.isOk() {
            if r.getAllAgencyData().count > 0 {
                self.page = self.page + 1
                self.getSearchData(r.getAllAgencyData())
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
    
    func getSearchData(data:NSMutableArray){
        //self.dataSource.removeAllObjects()
            for index in 0..<data.count {
            let ar:DSSearchAgencyInfo = data[index] as! DSSearchAgencyInfo
            let info = DSInvestorsCellModel()
            info.className = "DSInvestorsTableViewCell"
            if index == data.count-1 {
                info.isAplay = true
            }
            info.InvesId = ar.id
            info.InvesName = ar.company
            info.videoText = ar.video_title
            info.InvesHeadImageUrl = self.judegeTheStr(HTHttpConfig.sharedInstance().getServerAddress(""), str2: ar.logo)
            info.videoText = ar.video_title
            info.videoImg = self.judegeTheStr(HTHttpConfig.sharedInstance().getServerAddress(""), str2: ar.video_pic)
            info.videoUrl = ar.video_url
            info.isVideo = self.isVideo(ar)
            let list = ar.cats
            for i in 0..<list!.count{
                let cats:DSSearchAgencyCats = ar.cats?[i] as! DSSearchAgencyCats
                if cats.catName == "所属行业" || cats.catName == "关注领域" {
                    if info.Invesindustry != nil{
                        info.Invesindustry = info.Invesindustry!+"／"+cats.descriptions!
                    }else{
                        info.Invesindustry = cats.descriptions
                    }
                }else if cats.catName == "融资阶段" || cats.catName == "投资阶段"{
                    if info.InvesPhase != nil{
                        info.InvesPhase = info.InvesPhase!+"／"+cats.descriptions!
                    }else{
                        info.InvesPhase = cats.descriptions
                    }
                }
            }
            info.block = {
                [weak self] in
                if DSAccountInfo.sharedInstance().personId != nil {
                    
                    if self!.limitsStatus() == true {
                        self!.canEnterPerDetail(ar.id,num:ar.followNum)
                    }else{
                        SMToast("尚未有权限进入")
                    }
                    
                }else{
                    self!.gotoLoginVC()
                }
            }
            info.videoBlock = {
                if DSAccountInfo.sharedInstance().personId != nil {
                    if self.limitsStatus() == true {
                        if ar.video_url == nil {
                            SMToast("视频地址为空！")
                        }else if ((self.isIncludeChineseIn(ar.video_url!)) != false){
                            SMToast("视频地址有误！")
                        }else{
                            //self.pushWebViewController(ar.video_url!,title: ar.video_title)
                            self.gotoYouKuVideoPlayView(ar.video_url!, title: ar.video_title)
                        }
                    }else{
                        SMToast("由于您的身份限制，暂时无法查看")
                    }
                }else{
                    self.gotoLoginVC()
                }
            }
            self.dataSource .addObject(info)
        }
        self.tableView.reloadData()
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
    func gotoLoginVC(){
        let vc:DSLoginViewController = DSLoginViewController.createViewController(nil) as! DSLoginViewController
        vc.hidesBottomBarWhenPushed = true
        vc.loginReturnType = LOGINTYPE.TABBARLOGIN
        self.pushViewController(vc, animated: true)
    }
    
    func isVideo(info:DSSearchAgencyInfo) -> (Bool){
        if info.video_url != nil && info.video_url?.characters.count != 0 {
            return true
        }else{
            return false
        }
    }
    func canEnterPerDetail(id:String?,num:String?){
        let vc:DSPerInvesDetailsViewController=DSPerInvesDetailsViewController.createViewController(nil) as! DSPerInvesDetailsViewController
        //vc.followNum = num
        vc.person_id = id
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(vc, animated: true)
    }
    func limitsStatus()->(Bool){
        
        if DSAccountInfo.sharedInstance().authorized == "1"{
            return true
        }
        return false
    }
    func judegeTheStr(str1:String,str2:String?)->String{
        if str2 == nil{
            return str1
        }else{
            return str1.stringByAppendingFormat("/resource/view/"+str2!)
        }
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
    
}

