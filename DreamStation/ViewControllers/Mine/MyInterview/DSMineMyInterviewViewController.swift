//
//  DSMineMyInterviewViewController.swift
//  DreamStation
//
//  Created by xjb on 16/8/17.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit
private let STRING_MINE = "DSMineStrings"
class DSMineMyInterviewViewController: HTBaseViewController {

    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet var alertLab: UILabel!
    @IBOutlet var alertImgView: UIImageView!
    
    var projectDelegate:DSMineMyInterviewTableViewDelegate!
    var projectDataSource = NSMutableArray()
    var projectHttpArry = NSMutableArray()
    
    var page = 0
    //顶部刷新
    var header = MJRefreshNormalHeader()
    //底部刷新
    var footer = MJRefreshAutoNormalFooter()

    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSMineMyInterviewViewController", bundle: nil)
        let vc:DSMineMyInterviewViewController=storyboard.instantiateViewControllerWithIdentifier("DSMineMyInterviewViewController")as! DSMineMyInterviewViewController
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = loginBg_Color
        self.myTableView.backgroundColor = loginBg_Color
        self.addProjectPage()
        httpInvestorsFollowListRequire()
        alertLab.hidden = true
        alertImgView.hidden = true
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.lt_reset()
        self.initTitleBar()
    }
    
    override func initTitleBar() {
        super.initTitleBar()
        self.title=loadString("MineMyDate", tableId: STRING_MINE)
    }
    
    //MARK:加载项目方
    func addProjectPage(){
        self.addHeaderFooter()
        self.projectDelegate = DSMineMyInterviewTableViewDelegate()
        //initProjectDataSource()
        self.projectDelegate.dataSource = self.projectDataSource
        self.projectDelegate.block = {[weak self] (sender: AnyObject) in
            let info:DSPleaseFocusCellModel = sender as! DSPleaseFocusCellModel
            self?.httpDeleteFollowRequire(info.orderId, itemId: info.itemId)
        }
        registerCell(self.myTableView, cell: DSMinePleaseFocusCell.self)
        self.myTableView.delegate = self.projectDelegate
        self.myTableView.dataSource = self.projectDelegate
        self.myTableView.showsVerticalScrollIndicator = false
        
    }

    
    //MARK:添加上拉加载 下拉刷新
    func addHeaderFooter(){
        self.header.setRefreshingTarget(self, refreshingAction: #selector(DSMineMyInterviewViewController.upPullLoadData))
        self.header.lastUpdatedTimeLabel.hidden = true
        self.header.stateLabel.hidden = true
        self.footer.setRefreshingTarget(self, refreshingAction: #selector(DSMineMyInterviewViewController.downPlullLoadData))
        self.footer.stateLabel.hidden = true
        self.footer.refreshingTitleHidden = true
        self.myTableView.mj_header = self.header
        self.myTableView.mj_footer = self.footer
    }
    
    //MARK:下拉刷新
    func upPullLoadData(){
        self.page = 0
        self.projectDataSource = NSMutableArray()
        self.httpInvestorsFollowListRequire()
        self.myTableView.reloadData()
        //        self.myTableView.mj_footer.endRefreshing()
        //        self.myTableView.mj_header.endRefreshing()
    }
    //MARK:上拉加载
    func downPlullLoadData(){
        //self.httpInvestorsFollowListRequire()
        self.myTableView.reloadData()
        self.myTableView.mj_footer.endRefreshing()
        self.myTableView.mj_header.endRefreshing()
    }

    
    
    
    
    //MARK:----------http投资者的约谈-----------
    func httpInvestorsFollowListRequire(){
        let cmd:HttpCommand=DSHttpInvestorsFollowListCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self?.httpInvestorsFollowListResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_InvestorsFollowList_model] = "INTERVIEW"
        dic[kHttpParamKey_InvestorsFollowList_page] = String(self.page)
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
    }
    func httpInvestorsFollowListResponse(result:RequestResult){
        let r:DSHttpInvestorsFollowListResult = result as! DSHttpInvestorsFollowListResult
        if r.isOk() {
            self.projectHttpArry = NSMutableArray()
            self.projectHttpArry = r.getAllContent()
            if self.projectHttpArry.count != 0 {
                //self.page = self.page + 1
            }
            self.initProjectDataSource()
            self.addProjectPage()
            self.myTableView .reloadData()
        }
        self.myTableView.mj_footer.endRefreshing()
        self.myTableView.mj_header.endRefreshing()
    }
    //MARK:--------删除约谈----------
    func httpDeleteFollowRequire(id:String?,itemId:String?){
        let cmd:HttpCommand=DSHttpDeleteFollowCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self?.httpDeleteFollowResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_DeleteFollow_id] = id
        dic[kHttpParamKey_DeleteFollow_itemId] = itemId
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
    }
    func httpDeleteFollowResponse(result:RequestResult){
        let r:DSHttpDeleteFollowResult = result as! DSHttpDeleteFollowResult
        if r.isOk() {
            self.projectDataSource = NSMutableArray()
            self.httpInvestorsFollowListRequire()
        }
    }
    //MARK:--------数据加载----------
    func initProjectDataSource(){
        if self.projectHttpArry.count == 0 && self.projectDataSource.count == 0 {
            alertLab.hidden = false
            alertImgView.hidden = false
        }else{
            alertLab.hidden = true
            alertImgView.hidden = true
        }
        for index in 0..<self.projectHttpArry.count {
            let arr = NSMutableArray()
            let aa:DSInvestorsFollowListInfo = self.projectHttpArry[index] as! DSInvestorsFollowListInfo
            var city:String?
            var path:String?
            let hotCellInfo = DSPleaseFocusCellModel()
            hotCellInfo.className = "DSMinePleaseFocusCell"
            hotCellInfo.titleValue = aa.productName
            hotCellInfo.itemId = aa.itemId
            hotCellInfo.orderId = aa.orderId
            for i in 0..<aa.categories.count {
                let info = aa.categories[i] as! DSInvestorsCategoriesInfo
                if info.catName == "所属行业" {
                    hotCellInfo.categories .addObject(info.descriptio!)
                }else if info.catName == "所在地区" {
                    city = self.catTihuan(city, httpStr: info.descriptio!)
                    //city = info.descriptio
                }else if info.catName == "融资阶段" {
                    path = self.catTihuan(path, httpStr: info.descriptio!)
                    //path = info.descriptio!
                }
            }
            //hotCellInfo.detailValue = city!+" "+path!
            hotCellInfo.detailValue = self.tihuanDetail(city, path: path)
            hotCellInfo.block = {[weak self] in
                let vc:DSHotDetailViewController = DSHotDetailViewController.createViewController(nil) as! DSHotDetailViewController
                vc.projectId = aa.productId
                vc.hidesBottomBarWhenPushed = true
                self!.pushViewController(vc, animated: true)
            }
            hotCellInfo.videoBlock = {[weak self] in
                if self?.isUrlNil(aa.productUrl) == false {
                    self?.gotoYouKuVideoPlayView(aa.productUrl!, title: aa.productName)
                }else if self?.isUrlNil(aa.videoUrl) == false{
                    self?.gotoYouKuVideoPlayView(aa.videoUrl!, title: aa.productName)
                }else if self?.isUrlNil(aa.videoUrl4Provider) == false{
                    self!.gotoYouKuVideoPlayView(aa.videoUrl4Provider!,title: aa.productName)
                }else{
                    SMToast("视频有误！")
                }
                
            }
            arr.addObject(hotCellInfo)
            self.projectDataSource .addObject(arr)
        }
    }

    func tihuanDetail(city:String?,path:String?) -> (String?) {
        if city != nil && path != nil {
            return city!+"／"+path!
        }else if city == nil && path != nil{
            return path!
        }else if city != nil && path == nil{
            return city!
        }else{
            return nil
        }
    }
    func catTihuan(str:String?,httpStr:String?) -> (String?) {
        var string:String?
        if str != nil {
            string = str!+"／"+httpStr!
        }else{
            string = httpStr
        }
        return string!
    }
    func isUrlNil(str:String?) -> (Bool) {
        if str != nil {
            return self.isIncludeChineseIn(str)
        }else{
            return true
        }
    }
    
    //MARK:判断是否有汉字
    func isIncludeChineseIn(string: String?) -> Bool {
        for (_, value) in string!.characters.enumerate() {
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        return false
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
class DSMineMyInterviewTableViewDelegate: HTBaseTableViewDelegate {
    var block:passParameterBlock!
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 125
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor=UIColor.clearColor()
    }
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor=UIColor.clearColor()
    }
}
