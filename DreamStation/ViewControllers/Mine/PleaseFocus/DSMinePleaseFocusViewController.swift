//
//  DSMinePleaseFocusViewController.swift
//  DreamStation
//
//  Created by xjb on 16/8/25.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit
private let STRING_MINE = "DSMineStrings"
class DSMinePleaseFocusViewController: HTBaseViewController {

    @IBOutlet weak var myTableView: UITableView!
    var delegate:DSMinePleaseFocusTableViewDelegate!
    var dataSource:NSMutableArray = NSMutableArray()
    var page = 0
    //顶部刷新
    var header = MJRefreshNormalHeader()
    //底部刷新
    var footer = MJRefreshAutoNormalFooter()
    
    var city:String?
    var phease:String?
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSMinePleaseFocusViewController", bundle: nil)
        let vc:DSMinePleaseFocusViewController=storyboard.instantiateViewControllerWithIdentifier("DSMinePleaseFocusViewController")as! DSMinePleaseFocusViewController
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.httpPleasefocuListRequire()
        self.view.backgroundColor = loginBg_Color
        self.myTableView.backgroundColor = loginBg_Color
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.lt_reset()
        self.initTitleBar()
    }
    override func initTitleBar() {
        super.initTitleBar()
        if DSAccountInfo.sharedInstance().role == "INDIVIDUAL" || DSAccountInfo.sharedInstance().role == "ROLE_INDIVIDUAL" {
            self.title = loadString("MineInviteMeFollow", tableId: STRING_MINE)
        }else{
            self.title = loadString("MineInviteUsFollow", tableId: STRING_MINE)
        }
        self.initTableView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func initTableView(){
        self.addHeaderFooter()
        self.delegate = DSMinePleaseFocusTableViewDelegate()
        self.delegate.dataSource = self.dataSource
        self.delegate.block = {[weak self] (sender: AnyObject) in
            let info:DSPleaseFocusCellModel = sender as! DSPleaseFocusCellModel
           self?.httpDeleteFollowRequire(info.orderId, itemId: info.itemId)
        }
        registerCell(self.myTableView, cell: DSMinePleaseFocusCell.self)
        setExtraCellLineHidden(self.myTableView)
        self.myTableView.delegate = self.delegate
        self.myTableView.dataSource = self.delegate
        
    }
    
    
    //MARK:添加上拉加载 下拉刷新
    func addHeaderFooter(){
        self.header.setRefreshingTarget(self, refreshingAction: #selector(DSMinePleaseFocusViewController.upPullLoadData))
        self.header.lastUpdatedTimeLabel.hidden = true
        self.header.stateLabel.hidden = true
        self.footer.setRefreshingTarget(self, refreshingAction: #selector(DSMinePleaseFocusViewController.downPlullLoadData))
        self.footer.stateLabel.hidden = true
        self.footer.refreshingTitleHidden = true
        self.myTableView.mj_header = self.header
        self.myTableView.mj_footer = self.footer
    }
    
    //MARK:下拉刷新
    func upPullLoadData(){
        self.page = 0
        self.dataSource = NSMutableArray()
        self.httpPleasefocuListRequire()
        self.myTableView.reloadData()
    }
    //MARK:上拉加载
    func downPlullLoadData(){
        self.page = 0
        self.dataSource = NSMutableArray()
        self.httpPleasefocuListRequire()
        self.myTableView.reloadData()
    }

    
    
    //MARK:--------删除求关注项目----------
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
            self.dataSource = NSMutableArray()
            self.page = 0
            self.httpPleasefocuListRequire()
        }
    }
    
    //MARK:--------获取求关注项目列表----------
    func httpPleasefocuListRequire(){
        let cmd:HttpCommand=DSHttpPleasefocuListCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self?.httpPleasefocuListResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        
        if DSAccountInfo.sharedInstance().role == "INDIVIDUAL"||DSAccountInfo.sharedInstance().role == "ROLE_INDIVIDUAL" {
            dic[kHttpParamKey_PleasefocuList_individualId] = DSAccountInfo.sharedInstance().personId
        }else{
            dic[kHttpParamKey_PleasefocuList_institutionId] = DSAccountInfo.sharedInstance().institutionId
        }
        dic[kHttpParamKey_PleasefocuList_page] = String(self.page)
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpPleasefocuListResponse(result:RequestResult){
        let r:DSHttpPleasefocuListResult = result as! DSHttpPleasefocuListResult
        if r.isOk() {
           self.initdataSource(r.getAllContent())
            self.initTableView()
            self.myTableView .reloadData()
        }
        self.myTableView.mj_footer.endRefreshing()
        self.myTableView.mj_header.endRefreshing()
    }
    
    
    func initdataSource(arr:NSMutableArray){
        if arr.count == 0 {
            if self.dataSource.count == 0 {
               self.myTableView.alpha = 0
            }
        }else{
            self.page = self.page + 1
            for index in 0..<arr.count {
                self.city = nil
                self.phease = nil
                let infos = arr[index] as! DSPleasefocuListInfo
                let arr = NSMutableArray()
                let info = DSPleaseFocusCellModel()
                info.className = "DSMinePleaseFocusCell"
                info.orderId = infos.orderId
                info.itemId = infos.itemId
                info.titleValue = infos.productName
                for i in 0..<infos.catArray.count {
                    let catInfo:DSPleasefocuListCatInfo = infos.catArray[i] as! DSPleasefocuListCatInfo
                    if catInfo.name == "所属行业" {
                        info.categories .addObject(catInfo.descriptions!)
                    }else if catInfo.name == "所在地区" {
                        self.city = self.catTihuan(self.city, httpStr: catInfo.descriptions)
                    }else if catInfo.name == "融资阶段" {
                        self.phease = self.catTihuan(self.phease, httpStr: catInfo.descriptions)
                    }
                }
                info.detailValue = self.detailValueTihuan(self.city, phease: self.phease)
                info.block = {[weak self] in
                    let vc:DSHotDetailViewController = DSHotDetailViewController.createViewController(nil) as! DSHotDetailViewController
                    vc.projectId = infos.productId
                    vc.hidesBottomBarWhenPushed = true
                    self?.pushViewController(vc, animated: true)
                }
                info.videoBlock = {[weak self] in
                    if self?.isUrlNil(infos.productUrl) == false {
                        self?.judgeVideol(infos.productUrl!, title: infos.productName)
                    }else if self?.isUrlNil(infos.videoUrl) == false{
                        self?.judgeVideol(infos.videoUrl!, title: infos.productName)
                    }else if self?.isUrlNil(infos.videoUrl4Provider) == false{
                        self!.judgeVideol(infos.videoUrl4Provider!,title: infos.productName)
                    }else{
                        SMToast("视频有误！")
                    }
//                    if infos.productUrl != nil {
//                        self?.judgeVideol(infos.productUrl!, title: infos.productName)
//                    }else{
//                        SMToast("暂无项目视频")
//                    }
                }
                arr.addObject(info)
                self.dataSource .addObject(arr)
            }
        }
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
    
    func judgeVideol(url:String?,title:String?){
        if url != nil {
            let urlString:String = (url!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
            //self.pushWebViewController(urlString,title: title)
            self.gotoYouKuVideoPlayView(urlString, title: title)
        }else{
            SMToast("暂无项目视频")
        }
    }
    //校验url
    func checkUrl(urlString:String) -> Bool {
        let regex = "http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?"
        let pred = NSPredicate.init(format: "SELF MATCHES %@", regex)
        return pred.evaluateWithObject(urlString)
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
    func detailValueTihuan(city:String?,phease:String?) -> (String?) {
        var detailValue:String?
        if city != nil && phease != nil{
            detailValue = city!+"／"+phease!
        }else if city != nil && phease == nil{
            detailValue = city!
        }else if city == nil && phease != nil{
            detailValue = phease!
        }
        return detailValue
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
class DSMinePleaseFocusTableViewDelegate: HTBaseTableViewDelegate {
    var block:passParameterBlock!
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 125
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除"
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let data = self.dataSource[indexPath.section] as! NSMutableArray
        let info = data[indexPath.row] as! DSPleaseFocusCellModel
        self.block(info)
    }
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor=UIColor.clearColor()
    }
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor=UIColor.clearColor()
    }
}
