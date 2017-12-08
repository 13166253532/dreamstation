//
//  DSCollectionViewController.swift
//  DreamStation
//
//  Created by xjb on 16/8/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit
enum CollectionPageType: Int{
    /// 园区界面
    case ParkPage = 1
    /// 投资方界面
    case InvestorsPage = 2
    ///项目界面
    case ProjectPage = 3
}
private let STRING_MINE = "DSMineStrings"


class DSCollectionViewController: HTBaseViewController {
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!

    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var tixingImageView: UIImageView!
    @IBOutlet weak var tixingLabel: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    var collectionPageType:CollectionPageType = .ParkPage
    
    var page = 0
    //顶部刷新
    var header = MJRefreshNormalHeader()
    //底部刷新
    var footer = MJRefreshAutoNormalFooter()


    var parkDelegate:DSCollectionParkTableViewDelegate!
    var parkDataSource:NSMutableArray!
    var parkHttpArry = NSMutableArray()
    
    var projectDelegate:DSCollectionProjectTableViewDelegate!
    var projectDataSource:NSMutableArray!
    var projectHttpArry = NSMutableArray()
    
    var changeMark:String?
    var changeid:String?
    
    
    var investorsDelegate:DSInvesTableViewDelegate!
    var investorsDataSource:NSMutableArray!
    var investorsHttpArry = NSMutableArray()
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSCollectionViewController", bundle: nil)
        let vc:DSCollectionViewController=storyboard.instantiateViewControllerWithIdentifier("DSCollectionViewController")as! DSCollectionViewController
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.lt_reset()
        self.page = 0
        self.projectHttpArry=NSMutableArray()
        self.investorsHttpArry=NSMutableArray()
        self.parkHttpArry=NSMutableArray()
        self.initTitleBar()
        self.httpCollectionsListRequire()
        self.myTableView.reloadData()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addHeaderFooter()
        self.myTableView.backgroundColor = loginBg_Color
        //self.httpCollectionsListRequire()
    }

    //MARK:添加上拉加载 下拉刷新
    func addHeaderFooter(){
        self.header.setRefreshingTarget(self, refreshingAction: #selector(DSSearchInvestorResultVC.upPullLoadData))
        self.header.lastUpdatedTimeLabel.hidden = true
        self.header.stateLabel.hidden = true
        self.footer.setRefreshingTarget(self, refreshingAction: #selector(DSSearchInvestorResultVC.downPlullLoadData))
        self.footer.stateLabel.hidden = true
        self.footer.refreshingTitleHidden = true
        self.myTableView.mj_header = self.header
        self.myTableView.mj_footer = self.footer
    }
    
    //MARK:下拉刷新
    func upPullLoadData(){
        self.page = 0
        self.projectHttpArry=NSMutableArray()
        self.investorsHttpArry=NSMutableArray()
        self.parkHttpArry=NSMutableArray()
        self.httpCollectionsListRequire()
        self.myTableView.reloadData()
        //        self.myTableView.mj_footer.endRefreshing()
        //        self.myTableView.mj_header.endRefreshing()
    }
    //MARK:上拉加载
    func downPlullLoadData(){
        self.httpCollectionsListRequire()
        self.myTableView.reloadData()
    }

       //MARK:加载数据
    func httpCollectionsListRequire(){
        let cmd:HttpCommand=DSHttpCollectionsListCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock={[weak self](result:RequestResult!,useInfo:AnyObject!)->() in
            self?.httpCollectionsListResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_CollectionList_page] = String(self.page)
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    func httpCollectionsListResponse(result:RequestResult){
        let r:DSHttpCollectionListResule = result as! DSHttpCollectionListResule
        if result.isOk() {
            self.getHttpCollectionsListData(r.getTheContent())
            self.myTableView .reloadData()
        }
        self.myTableView.mj_footer.endRefreshing()
        self.myTableView.mj_header.endRefreshing()
    }
    func getHttpCollectionsListData(data:NSMutableArray){
        if data.count != 0 {
            self.page = self.page + 1
        }
        for index in 0..<data.count {
            let aa:DSHttpCollectionsListInfo = data[index] as! DSHttpCollectionsListInfo
            switch aa.collectionsType {
                //项目
            case "PRODUCT":
                self.projectHttpArry .addObject(aa)
                break
                //投资者
            case "INVESTMENT":
                self.investorsHttpArry .addObject(aa)
                break
                //园区
            case "PARK":
                self.parkHttpArry .addObject(aa)
                break
            default:
                break
            }
        }
       addTableView()
    }
    
    func addTableView(){
        switch self.collectionPageType {
        case .InvestorsPage:
            self.addInvestorsPage()
            break
        case .ParkPage:
            self.addParkPage()
            break
        case .ProjectPage:
            self.addProjectPage()
            break
        }
    }
    //MARK:加载收藏园区方
    func addParkPage(){
        self.parkDataSource = NSMutableArray()
        self.parkDelegate = DSCollectionParkTableViewDelegate()
        registerCell(self.myTableView, cell: DSParkPageCell.self)
        self.initParkDataSource()
        self.parkDelegate.dataSource = self.parkDataSource
        self.myTableView.delegate = self.parkDelegate
        self.myTableView.dataSource = self.parkDelegate
    }
    func initParkDataSource(){
        for index in 0..<self.parkHttpArry.count {
            let aa:DSHttpCollectionsListInfo = self.parkHttpArry[index] as! DSHttpCollectionsListInfo
            let info = DSParkCellModel()
            info.className = "DSParkPageCell"
            info.headImage = aa.iconUrl
            if aa.iconUrl != nil {
                info.headImage = self.tihuanUrl(aa.iconUrl!)
            }
            info.parkName = aa.titleName
            info.parkSub = aa.level
            info.cityName = String()
            for indexs in 0..<aa.typeTag.count {
                var cityStr = aa.typeTag[indexs] as? String
                if cityStr == nil {
                    cityStr = "nil"
                }
                if info.cityName == nil || info.cityName?.characters.count == 0 {
                    info.cityName = cityStr
                }else{
                  info.cityName = info.cityName!+"/"+cityStr!
                }
            }
            //info.cityName =
            info.videoImage = aa.videoPicUrl
            if aa.videoPicUrl != nil {
                info.videoImage = self.tihuanUrl(aa.videoPicUrl!)
            }
            info.videoSub = aa.videoTitle
            info.block = {[weak self] in
                let vc:DSParkDetailsVC=DSParkDetailsVC.createViewController(nil) as! DSParkDetailsVC
                vc.parkId = aa.collections
                vc.hidesBottomBarWhenPushed = true
                self!.pushViewController(vc, animated: true)
            }
            info.goBlock = {[weak self] (sender: AnyObject) in
                if self!.isIncludeChineseIn(aa.videoUrl!) != true {
                    //self!.pushWebViewController(aa.videoUrl!,title: aa.videoTitle)
                    self?.gotoYouKuVideoPlayView(aa.videoUrl!, title: aa.videoTitle)
                }
            }
            self.parkDataSource .addObject(info)
        }
        if self.parkDataSource.count == 0 {
            self.myTableView.alpha = 0
        }
    }

    //MARK:加载项目方
    func addProjectPage(){
        self.projectDataSource = NSMutableArray()
        self.projectDelegate = DSCollectionProjectTableViewDelegate()
        initProjectDataSource()
        self.projectDelegate.dataSource = self.projectDataSource
        registerCell(self.myTableView, cell: DSHotTableViewCell.self)
        registerCell(self.myTableView, cell: DSHotVideoTableViewCell.self)
        registerCell(self.myTableView, cell: DSMineCollectionNoteCell.self)
        self.myTableView.delegate = self.projectDelegate
        self.myTableView.dataSource = self.projectDelegate
        setExtraCellLineHidden(self.myTableView)
        self.rightConstraint.constant=15
        self.leftConstraint.constant=15
    }
    
    func initProjectDataSource(){
        if self.projectHttpArry.count == 0{
            self.myTableView.alpha = 0
        }else{
            for index in 0..<self.projectHttpArry.count {
                let aa:DSHttpCollectionsListInfo = self.projectHttpArry[index] as! DSHttpCollectionsListInfo
                let arr = NSMutableArray()
                let hotCellInfo = DSHotCellModel()
                hotCellInfo.className = "DSHotTableViewCell"
                hotCellInfo.titleValue = aa.titleName
               // hotCellInfo.detailValue = aa.level
                hotCellInfo.detailValue = self.tihuanCityPhac(self.replaceSpace(aa.level), str2: self.replaceSpace(aa.favoriteNotes))
                if aa.typeTag.count != 0 {
                    hotCellInfo.categories = aa.typeTag
                }
                hotCellInfo.block = {[weak self] in
                    let vc:DSHotDetailViewController = DSHotDetailViewController.createViewController(nil) as! DSHotDetailViewController
                    vc.projectId = aa.collections
                    vc.hidesBottomBarWhenPushed = true
                    self!.pushViewController(vc, animated: true)
                }
                let hotVideoCellInfo = DSHotVideoCellModel()
                hotVideoCellInfo.className = "DSHotVideoTableViewCell"
                hotVideoCellInfo.videoUrl = aa.videoUrl
                hotVideoCellInfo.block = {[weak self] in
                    if aa.videoUrl != nil {
                        self?.judgeVideol(aa.videoUrl!, title: aa.titleName)
                    }else{
                        SMToast("暂无项目视频")
                    }
                    
                }
                let noteInfo = DSMineCollectionNoteCellModel()
                noteInfo.className = "DSMineCollectionNoteCell"
                noteInfo.noteTitle = aa.mark
                noteInfo.changeMarkBlock = {[weak self] in
                    self?.changeid = aa.id!
                    self!.addChangeMarkView()
                }
                if aa.mark?.characters.count < 40 {
                    noteInfo.markCellH = 30
                    //self.projectDelegate.noteTitle = 15
                }else{
                    noteInfo.markCellH = CGFloat(Double((aa.mark?.characters.count)!/24)*15)
                }
                arr .addObject(hotCellInfo)
                arr .addObject(hotVideoCellInfo)
                arr .addObject(noteInfo)
                self.projectDataSource .addObject(arr)
            }
        }
    }
    func judgeVideol(url:String?,title:String?){
        if url != nil {
            let urlString:String = (url!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
            //self.pushWebViewController(urlString,title: title)
            self.gotoYouKuVideoPlayView(urlString, title: title)
        }else{
            SMToast("视频地址有误！")
        }
    }
    //校验url
    func checkUrl(urlString:String) -> Bool {
        let regex = "http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?"
        let pred = NSPredicate.init(format: "SELF MATCHES %@", regex)
        return pred.evaluateWithObject(urlString)
    }
    
    func tihuanCityPhac(str1:String?,str2:String?) ->(String?)  {
        if str1 != nil && str2 != nil {
            return str1!+"／"+str2!
        }else if str1 == nil && str2 != nil {
            return str2!
        }else if str1 != nil && str2 == nil {
            return str1!
        }
        return ""
    }
     //MARK:加载投资方
    func addInvestorsPage(){
        self.investorsDelegate = DSInvesTableViewDelegate()
        self.investorsDataSource = NSMutableArray()
        registerCell(self.myTableView, cell: DSInvestorsTableViewCell.self)
        httpInvestorsData()
        self.investorsDelegate.dataSource = self.investorsDataSource
        self.myTableView.delegate = self.investorsDelegate
        self.myTableView.dataSource = self.investorsDelegate
        self.myTableView.separatorStyle = .None
    }
    
    func httpInvestorsData(){
        if self.investorsHttpArry.count == 0{
            self.myTableView.alpha = 0
        }else{
            for index in 0..<self.investorsHttpArry.count {
                let aa:DSHttpCollectionsListInfo = self.investorsHttpArry[index] as! DSHttpCollectionsListInfo
                let info = DSInvestorsCellModel()
                if index == self.investorsHttpArry.count-1 {
                    info.isAplay = true
                }
                info.className = "DSInvestorsTableViewCell"
                info.InvesId = aa.id
                info.InvesName = aa.titleName
//                info.InvesPhase = aa.favoriteNotes
//                info.Invesindustry = aa.level
                info.InvesPhase = self.replaceSpace(aa.favoriteNotes)
                info.Invesindustry = self.replaceSpace(aa.level)
                if aa.videoUrl != nil && aa.videoUrl?.characters.count != 0 {
                   info.videoUrl = self.tihuanUrl(aa.videoUrl!)
                    info.isVideo = true
                }else{
                    info.isVideo = false
                }
                if aa.iconUrl != nil {
                    info.InvesHeadImageUrl = self.tihuanUrl(aa.iconUrl!)
                }
                info.videoText = aa.videoTitle
                if aa.videoPicUrl != nil {
                    info.videoImg = self.tihuanUrl(aa.videoPicUrl!)
                }
                
                info.block = {
                    [weak self] in
                    let vc:DSPerInvesDetailsViewController=DSPerInvesDetailsViewController.createViewController(nil) as! DSPerInvesDetailsViewController
                    vc.person_id = aa.collections
                    vc.hidesBottomBarWhenPushed = true
                    self?.pushViewController(vc, animated: true)
                }
                info.videoBlock = {[weak self] in
                    if aa.videoUrl == nil {
                        SMToast("视频地址为空！")
                    }else if ((self?.isIncludeChineseIn(aa.videoUrl!)) != false){
                        SMToast("视频地址有误！")
                    }else{
                        //self!.pushWebViewController(aa.videoUrl!,title: aa.videoTitle)
                        self?.gotoYouKuVideoPlayView(aa.videoUrl!, title: aa.videoTitle)
                    }
                }
                self.investorsDataSource .addObject(info)
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
            return string as (String)
        }
        return String()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
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

class DSCollectionParkTableViewDelegate: DSLoginTableViewDelegate {
    let bizhi = Double(UIScreen.mainScreen().bounds.height)/568
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 260*CGFloat(bizhi)
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor=UIColor.clearColor()
    }
}
class DSCollectionProjectTableViewDelegate: HTBaseTableViewDelegate {
    var noteTitle = CGFloat()
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 90
        }else if indexPath.row == 1{
            return 35
        }else{
            let arr:NSMutableArray = self.dataSource[indexPath.section] as! NSMutableArray
            let info:DSMineCollectionNoteCellModel = arr[indexPath.row] as! DSMineCollectionNoteCellModel
            return info.markCellH!
        }
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) { //ios8
        
    }
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor=UIColor.clearColor()
    }
}

