//
//  DSInvesCellViewController.swift
//  DreamStation
//
//  Created by xjb on 16/8/1.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit
private let DSINVESTORS = "DSInvestors"
enum InvesPageType: Int{
    case PersonPage = 1
    case InstituPage = 2
}

enum SequenPageType: Int{
    case HeatPage = 1
    case TimePage = 2
}
class DSInvesCellViewController: HTBaseViewController {

    @IBOutlet weak var myTableView: UITableView!
    var dataSource = NSMutableArray()
    var delegate:DSInvesTableViewDelegate!
    var isPersonal:Bool!
    
    var invesPageType:InvesPageType = .PersonPage
    var sequenPageType:SequenPageType = .HeatPage
    
    var dict:NSMutableDictionary!
    var arr = NSMutableArray()
    
    var page = 0
    
    var institutionSX:String?
    var perHttpBlock:httpBlock!
    var invesHttpBlock:httpBlock!
    
    
    //顶部刷新
    var header = MJRefreshNormalHeader()
    //底部刷新
    var footer = MJRefreshAutoNormalFooter()
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSInvesCellViewController", bundle: nil)
        let vc:DSInvesCellViewController=storyboard.instantiateViewControllerWithIdentifier("DSInvesCellViewController")as! DSInvesCellViewController
        vc.createArgs=createArgs
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.page = 0
        self.dataSource = NSMutableArray()
        self.httpGetData()
        self.initTableView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBarController!.tabBar.transform = CGAffineTransformMakeTranslation(0, 0)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.perHttpBlock = nil
        self.invesHttpBlock = nil
        if self.institutionSX != DSAccountInfo.sharedInstance().institutionSX {
            self.institutionSX = DSAccountInfo.sharedInstance().institutionSX
            self.page = 0
            self.dataSource = NSMutableArray()
            self.httpGetData()
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.dict = NSMutableDictionary()
    }
    func initTableView(){
        self.addHeaderFooter()
        registerCell(self.myTableView, cell: DSInvestorsTableViewCell.self)
        self.delegate = DSInvesTableViewDelegate()
        //self.httpGetData()
        self.delegate.dataSource = self.dataSource
        self.myTableView.delegate = self.delegate
        self.myTableView.dataSource = self.delegate
        self.myTableView.separatorStyle = .None
        self.myTableView.backgroundColor = grayBgColor
    }
    //MARK:添加上拉加载 下拉刷新
    func addHeaderFooter(){
        self.header.setRefreshingTarget(self, refreshingAction: #selector(DSInvesCellViewController.upPullLoadData))
        self.header.lastUpdatedTimeLabel.hidden = true
        self.header.stateLabel.hidden = true
        self.footer.setRefreshingTarget(self, refreshingAction: #selector(DSInvesCellViewController.downPlullLoadData))
        self.footer.stateLabel.hidden = true
        self.footer.refreshingTitleHidden = true
        self.myTableView.mj_header = self.header
        self.myTableView.mj_footer = self.footer
    }
    
    //MARK:下拉刷新
    func upPullLoadData(){
        self.dataSource = NSMutableArray()
        self.page = 0
        self.httpGetData()
        self.myTableView.reloadData()
    }
    //MARK:上拉加载
    func downPlullLoadData(){
        self.httpGetData()
        self.myTableView.reloadData()
    }

    func httpGetData(){
        switch self.invesPageType {
        case .InstituPage:
            httpAccountsInstituListRequire()
            break
        case .PersonPage:
            httpPerInvestmentListRequire()
            break
        }
        self.initTableView()
        self.myTableView.reloadData()
    }
    


    func judegeTheStr(str1:String,str2:String?)->String{
        if str2 == nil{
            return str1
        }else{
           return str1.stringByAppendingFormat("/resource/view/"+str2!)
        }
    }
    
    func isVideo(info:DSAccountsInstituListInfo) -> (Bool){
        if info.video_url == nil || info.video_url?.characters.count == 0  {
            return false
        }else{
           return true
        }
    }
    
    func gotoLoginVC(){
        let vc:DSLoginViewController = DSLoginViewController.createViewController(nil) as! DSLoginViewController
        vc.hidesBottomBarWhenPushed = true
        vc.loginReturnType = LOGINTYPE.TABBARLOGIN
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

    func isPerVideo(info:DSPerInvestmentListInfo) -> (Bool){
        if info.videoUrl == nil || info.videoUrl?.characters.count == 0 {
            return false
        }else{
            return true
        }
    }
    func canEnterInvDetail(id:String?,num:String?){
        let vc:DSPerInvesDetailsViewController=DSPerInvesDetailsViewController.createViewController(nil) as! DSPerInvesDetailsViewController
        vc.invesPageType = self.invesPageType
       // vc.followNum = num
        vc.person_id = id
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(vc, animated: true)
    }
    
    func canEnterPerDetail(id:String?,num:String?){
        let vc:DSPerInvesDetailsViewController=DSPerInvesDetailsViewController.createViewController(nil) as! DSPerInvesDetailsViewController
        vc.invesPageType = self.invesPageType
        //vc.followNum = num
        vc.person_id = id
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(vc, animated: true)
    }
    func limitsStatus()->(Bool){
        if DSAccountInfo.sharedInstance().authorized == "1" {
            return true
        }
        return false
    }
    func tihuanTimeHeat() -> (String) {
        if self.sequenPageType == .HeatPage {
            return "followCount"
        }else{
            return "createTime"
        }
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
class DSInvesTableViewDelegate: DSLoginTableViewDelegate {
    var isVideo:Bool!
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let info = self.dataSource[indexPath.row] as! DSInvestorsCellModel
        if info.isVideo == true {
            return 155
        }else{
          return 95
        }
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
