//
//  DSMyAttentionViewController.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/15.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit
private let STRING_MINE = "DSMineStrings"
class DSMyAttentionViewController: HTBaseViewController {

    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var Label: UILabel!
    
    var deleteSuccessBlock:passParameterBlock!
    var delegate:DSMyAttentionDelegate!
    var dataSource:NSMutableArray = NSMutableArray()
    
    var page = 0
    //顶部刷新
    var header = MJRefreshNormalHeader()
    //底部刷新
    var footer = MJRefreshAutoNormalFooter()

    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSMyAttentionViewController", bundle: nil)
        let vc:DSMyAttentionViewController=storyboard.instantiateViewControllerWithIdentifier("DSMyAttentionViewController")as! DSMyAttentionViewController
        vc.createArgs=createArgs
        return vc
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.lt_reset()
        self.initTitleBar()
        self.dataSource = NSMutableArray()
        self.imageView.hidden = true
        self.Label.hidden = true
        self.tableView.backgroundColor = loginBg_Color
        self.initTitleBar()
        self.initTabelView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func initTitleBar() {
        super.initTitleBar()
        self.title=loadString("MineMyFollow", tableId: STRING_MINE)
    }
    
    func initTabelView(){
        self.addHeaderFooter()
        self.initTableViewData()
        self.delegate = DSMyAttentionDelegate()
        self.delegate.block = {
            (sender: AnyObject , sender1: AnyObject)->() in
            let info:DSInvestorsCellModel = sender as! DSInvestorsCellModel
            self.httpDeleteFollowRequire(info.orderId, itemId: info.itemId,anyobject: sender1)
        }

        self.deleteSuccessBlock = {(value:AnyObject?) in
        self.performSelectorOnMainThread(#selector(DSMyAttentionViewController.refreshUI(_:)), withObject: value, waitUntilDone: true)
            
        }
        self.delegate.dataSource = self.dataSource
        registerCell(self.tableView, cell:DSInvestorsTableViewCell.self )
        self.tableView.delegate = self.delegate
        self.tableView.dataSource = self.delegate
        self.tableView.separatorStyle = .None
        
    }
    func refreshUI(object: AnyObject?) {
        
        let indexPath = object as? NSIndexPath
        let ary = self.dataSource.objectAtIndex((indexPath?.section)!)
        ary.removeObjectAtIndex((indexPath?.row)!)
        //2.reload
        //直接使用reload方法界面的变化非常迅速，用户体验非常不好
        //                self.tableView.reloadData()
        //这个具有动画效果
        self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
    }

    //MARK:添加上拉加载 下拉刷新
    func addHeaderFooter(){
        self.header.setRefreshingTarget(self, refreshingAction: #selector(DSMyAttentionViewController.upPullLoadData))
        self.header.lastUpdatedTimeLabel.hidden = true
        self.header.stateLabel.hidden = true
        self.footer.setRefreshingTarget(self, refreshingAction: #selector(DSMyAttentionViewController.downPlullLoadData))
        self.footer.stateLabel.hidden = true
        self.footer.refreshingTitleHidden = true
        self.tableView.mj_header = self.header
        self.tableView.mj_footer = self.footer
    }
    
    //MARK:下拉刷新
    func upPullLoadData(){
        self.page = 0
        self.dataSource = NSMutableArray()
        self.httpMyAttentionRequire()
        self.tableView.reloadData()
        //        self.tableView.mj_footer.endRefreshing()
        //        self.tableView.mj_header.endRefreshing()
    }
    //MARK:上拉加载
    func downPlullLoadData(){
        self.page = 0
        self.dataSource = NSMutableArray()
        self.httpMyAttentionRequire()
        self.tableView.reloadData()
    }

    
    
    func initTableViewData(){
        self.httpMyAttentionRequire()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DSMyAttentionViewController{

    func httpMyAttentionRequire(){
        let cmd:DSHttpProductFollowListCmd = DSHttpProductFollowListCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpProductFollowListCmd
        let block:httpBlock = {
            (result:RequestResult!,userInfo:AnyObject!)->() in
            self.httpMyAttentionResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate = completeDelegate
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_ProductFollowList_userId] = DSAccountInfo.sharedInstance().productsId
        dic[kHttpParamKey_ProductFollowList_page] = String(self.page)
        cmd.requestInfo = dic as [NSObject:AnyObject]
        print("url == %@",cmd.getUrl())
        cmd.execute()
        
    }
    
    func httpMyAttentionResponse(result:RequestResult){
        let r:DSHttpProductFollowListResult = result as! DSHttpProductFollowListResult
        if r.isOk() {
            self.getHttpData(r.getAllContent())
            self.tableView.reloadData()
        }
        self.tableView.mj_footer.endRefreshing()
        self.tableView.mj_header.endRefreshing()
    }
    
    func getHttpData(data:NSMutableArray){
        
        if data.count == 0 {
            if self.dataSource.count == 0 {
                self.imageView.hidden = false
                self.Label.hidden = false
            }
        }else{
             self.page = self.page + 1
            self.imageView.hidden = true
            self.Label.hidden = true
            
            for index in 0..<data.count {
                let dataList:NSMutableArray = NSMutableArray()
                let httpInfo = data[index] as! DSProductFollowListInfo
                let info = DSInvestorsCellModel()
                if index == data.count-1 {
                    info.isAplay = true
                }
                info.className = "DSInvestorsTableViewCell"
                if httpInfo.investorType != "INDIVIDUAL" {
                  info.InvesName = httpInfo.companyName
                }else{
                    info.InvesName = httpInfo.userName
                }
                info.itemId = httpInfo.itemId
                info.orderId = httpInfo.orderId
                info.InvesId = httpInfo.investmentUserId
                info.InvesType = httpInfo.orderModel
                info.videoUrl = httpInfo.videoUrl
                if httpInfo.avaterUrl != nil && httpInfo.avaterUrl?.characters.count < 75  {
                    //print(httpInfo.avaterUrl)
                    info.InvesHeadImageUrl = self.tihuanUrl(httpInfo.avaterUrl!)
                }
                info.videoText = httpInfo.introduceDesc
                info.videoUrl = httpInfo.videoUrl
                info.isVideo = self.isVideo(httpInfo)
                if httpInfo.categor != nil {
                    //for i in 0..<httpInfo.categor!.count {
                        //let cats:DSProductFollowCategoriesInfo = httpInfo.categor![i] as! DSProductFollowCategoriesInfo
                       // print(cats.descriptions)
                    //}
                }
                if httpInfo.introduceImg != nil {
                    info.videoImg = self.tihuanUrl(httpInfo.introduceImg!)
                }
                info.InvesPhase = self.replaceSpace(httpInfo.phase)
                info.Invesindustry = self.replaceSpace(httpInfo.domain)
                info.block = {
                    [weak self] in
                    let vc:DSPerInvesDetailsViewController=DSPerInvesDetailsViewController.createViewController(nil) as! DSPerInvesDetailsViewController
                    if httpInfo.investorType != "INDIVIDUAL" {
                        vc.person_id = httpInfo.userGroupId
                    }else{
                        vc.person_id = httpInfo.investorId
                    }
                    vc.hidesBottomBarWhenPushed = true
                    self!.pushViewController(vc, animated: true)
                }
                info.videoBlock = {[weak self] in
                   //self?.pushWebViewController(httpInfo.videoUrl!,title: httpInfo.introduceDesc)
                    self?.gotoYouKuVideoPlayView(httpInfo.videoUrl!, title: httpInfo.introduceDesc)
                }
                dataList.addObject(info)
                self.dataSource.addObject(dataList)
            }
        }
    }
    //MARK:"/"替换" "
    func replaceSpace(str:String?) -> (String?) {
        if str != nil && str?.characters.count != 0 {
            var string:NSString = str! as NSString
            if string.containsString(" "){
                string = string.stringByReplacingOccurrencesOfString(" ", withString: "／")
            }
            return self.deleteStr(string)
        }
        return String()
    }
    //MARK:最后一位／删除
    func deleteStr(string:NSString) -> (String?) {
        var str:NSString = string
        let str1 = str.substringFromIndex(str.length-1)
        if str1 == "／" {
            str = string.substringToIndex(str.length-1)
        }
        return str as (String)
    }
    func isVideo(info:DSProductFollowListInfo) -> (Bool){
        if info.videoUrl != nil && info.videoUrl?.characters.count != 0 {
            return true
        }else{
            return false
        }
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
    func tihuanUrl(httpStr:String)->(String?){
        
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


class DSMyAttentionDelegate: HTBaseTableViewDelegate {
    var block:passTwoParameterBlock!
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let arr = self.dataSource[indexPath.section] as! NSMutableArray
        let info = arr[0] as! DSInvestorsCellModel
        if info.isVideo == true {
            return 155
        }else{
            return 95
        }
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
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
        let info = data[indexPath.row] as! DSInvestorsCellModel
        self.block(info,indexPath)
    }
}
