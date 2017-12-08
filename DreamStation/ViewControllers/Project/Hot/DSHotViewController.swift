//
//  DSHotViewController.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/28.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit
enum ProjectPageType: Int{
    case HeatPage = 1
    case TimePage = 2
}
class DSHotViewController: HTBaseViewController {

    var delegate:DSHotTableViewDelegate!
    var dataSource:NSMutableArray = NSMutableArray()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var attImage: UIImageView!
    @IBOutlet var attLabel: UILabel!
    
    
    
    var projectPageType:ProjectPageType = ProjectPageType.HeatPage
    
    var dict:NSMutableDictionary!
    var arr = NSMutableArray()
    var city:String?
    var phease:String?   //阶段
    var industry:String? //行业
    var money:String?    //币种
    var page = 0
    var productsSX:String?
    
    //顶部刷新
    var header = MJRefreshNormalHeader()
    //底部刷新
    var footer = MJRefreshAutoNormalFooter()
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSHotViewController", bundle: nil)
        let vc:DSHotViewController=storyboard.instantiateViewControllerWithIdentifier("DSHotViewController")as! DSHotViewController
        vc.createArgs=createArgs
        return vc
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.productsSX != DSAccountInfo.sharedInstance().productsSX {
            self.productsSX = DSAccountInfo.sharedInstance().productsSX
            self.attImage.hidden = true
            self.attLabel.hidden = true
            self.page = 0
            self.initHotViewData()
        }
        self.navigationController?.navigationBar.lt_reset()
        self.initTitleBar()        
        //if self.sxArrayCount != self.arr.count {
            //self.attImage.hidden = true
            //self.attLabel.hidden = true
            //self.sxArrayCount = self.arr.count
            //self.page = 0
            //self.initHotViewData()
        //}
        //self.initHotViewData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.page = 0
        self.attImage.hidden = true
        self.attLabel.hidden = true
        self.initHotViewData()
        self.initTableView()
       
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController!.tabBar.transform = CGAffineTransformMakeTranslation(0, 0)
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func initTableView(){
        //self.dataSource = NSMutableArray()
        self.addHeaderFooter()
        self.delegate = DSHotTableViewDelegate()
        self.delegate.dataSource = self.dataSource
        registerCell(self.tableView, cell: DSHotTableViewCell.self)
        registerCell(self.tableView, cell: DSHotVideoTableViewCell.self)
        self.tableView.delegate = self.delegate
        self.tableView.dataSource = self.delegate
    }
    //MARK:添加上拉加载 下拉刷新
    func addHeaderFooter(){
        self.header.setRefreshingTarget(self, refreshingAction: #selector(DSHotViewController.upPullLoadData))
        self.header.lastUpdatedTimeLabel.hidden = true
        self.header.stateLabel.hidden = true
        self.footer.setRefreshingTarget(self, refreshingAction: #selector(DSHotViewController.downPlullLoadData))
        self.footer.stateLabel.hidden = true
        self.footer.refreshingTitleHidden = true
        self.tableView.mj_header = self.header
        self.tableView.mj_footer = self.footer
    }
    
    //MARK:下拉刷新
    func upPullLoadData(){
        self.page = 0
        self.initHotViewData()
        self.tableView.reloadData()
//        self.tableView.mj_footer.endRefreshing()
//        self.tableView.mj_header.endRefreshing()
    }
    //MARK:上拉加载
    func downPlullLoadData(){
        self.httpHotListRequire()
        self.tableView.reloadData()
    }
    
    
    func initHotViewData(){
        self.dataSource = NSMutableArray()
        self.httpHotListRequire()
    }
}

extension DSHotViewController{

    func httpHotListRequire(){
    
        let cmd:HttpCommand = DSHttpProductsCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {
            (result:RequestResult!,useInfo:AnyObject!)->() in
            self.httpHotListResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
         let dic:NSMutableDictionary = NSMutableDictionary()
        if self.arr.count != 0 {
            self.dict = NSMutableDictionary()
            self.dict = self.arr.lastObject as! NSMutableDictionary
            let list:NSMutableArray = NSMutableArray()
            let normalArray = self.dict["类型"] as! NSMutableArray
            if normalArray.count != 0 {
                for index in 0..<normalArray.count {
                    if normalArray[index] as! String == "深度推荐" {
                        let dic1:NSMutableDictionary = NSMutableDictionary()
                        dic1[kHttpParamKey_products_Name] = "深度推荐"
                        dic1[kHttpParamKey_products_description] = "是"
                        list .addObject(dic1)
                    }
                    if normalArray[index] as! String == "有商业计划书" {
                        let dic1:NSMutableDictionary = NSMutableDictionary()
                        dic1[kHttpParamKey_products_Name] = "有商业计划书"
                        dic1[kHttpParamKey_products_description] = "是"
                        list .addObject(dic1)
                    }
                    if normalArray[index] as! String == "上过节目" {
                        let dic1:NSMutableDictionary = NSMutableDictionary()
                        dic1[kHttpParamKey_products_Name] = "上过节目"
                        dic1[kHttpParamKey_products_description] = "是"
                        list .addObject(dic1)
                    }
                }
            }
            let currencyArray = self.dict["投资币种"] as! NSMutableArray
            if currencyArray.count != 0{
                for index in 0..<currencyArray.count{
                    let dic1:NSMutableDictionary = NSMutableDictionary()
                    dic1[kHttpParamKey_products_Name] = "投资币种"
                    dic1[kHttpParamKey_products_description] = currencyArray[index]
                    list .addObject(dic1)
                }
            }
            let industryArray = self.dict["关注领域"] as! NSMutableArray
            if industryArray.count != 0 {
                for index in 0..<industryArray.count {
                    let dic1:NSMutableDictionary = NSMutableDictionary()
                    dic1[kHttpParamKey_products_Name] = "所属行业"
                    dic1[kHttpParamKey_products_description] = industryArray[index]
                    list .addObject(dic1)
                }
            }
            let phaseArray = self.dict["融资阶段"] as! NSMutableArray
            if phaseArray.count != 0 {
                for index in 0..<phaseArray.count {
                    let dic1:NSMutableDictionary = NSMutableDictionary()
                    dic1[kHttpParamKey_products_Name] = "融资阶段"
                    dic1[kHttpParamKey_products_description] = phaseArray[index]
                    list .addObject(dic1)
                }
            }
            let cityArray = self.dict["投资地域"] as! NSMutableArray
            if cityArray.count != 0 {
                for index in 0..<cityArray.count {
                    let dic1:NSMutableDictionary = NSMutableDictionary()
                    dic1[kHttpParamKey_products_Name] = "所在地区"
                    dic1[kHttpParamKey_products_description] = cityArray[index]
                    list .addObject(dic1)
                }
            }
            let jsonData = try! NSJSONSerialization.dataWithJSONObject(list, options: NSJSONWritingOptions.PrettyPrinted)
            let jsonString:String = String(data: jsonData,encoding: NSUTF8StringEncoding)!
            if self.dict["最小金额"] != nil {
                dic[kHttpParamKey_products_amountMin] = self.dict["最小金额"] as! String
                dic[kHttpParamKey_products_amountMax] = self.dict["最大金额"] as! String
            }
            dic[kHttpParamKey_products_query] = jsonString
        }
        dic[kHttpParamKey_products_sortType] = "DESC"
        dic[kHttpParamKey_products_sortItem] = self.tihuanTime()
        dic[kHttpParamKey_products_page] = String(self.page)
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    func tihuanTime() -> (String) {
        if self.projectPageType == .HeatPage {
            return "interviewCount"
        }else{
            return "createTime"
        }
    }
    
    
    func httpHotListResponse(result:RequestResult){
        let r:DSHttpProductsResult = result as! DSHttpProductsResult
        if r.isOk() {
            if r.getAllContent().count == 0 {
                if self.dataSource.count == 0 {
                    self.attImage.hidden = false
                    self.attLabel.hidden = false
                }
            }else{
                self.page = self.page + 1
                self.attImage.hidden = true
                self.attLabel.hidden = true
                let arr = r.getAllContent()
                self.getHttpData(arr)
//                if self.projectPageType == .HeatPage {
//                    self.sequenceHeat(arr)
//                }else{
//                    self.sequenceTime(arr)
//                }
            }
            self.initTableView()
            self.tableView.reloadData()
        }else{
            SMToast("请查看当前网络状态！")
        }
        self.tableView.mj_footer.endRefreshing()
        self.tableView.mj_header.endRefreshing()
    }
//    func sequenceTime(arr:NSMutableArray){
//       let list = arr.sortedArrayUsingComparator { (info1, info2) -> NSComparisonResult in
//            let info3 = info1 as! DSProductsInfo
//            let info4 = info2 as! DSProductsInfo
//            let createTime3 : Int? = Int(info3.createTime!)
//            let createTime4 : Int? = Int(info4.createTime!)
//            if createTime3 < createTime4{
//                return NSComparisonResult.OrderedDescending
//            }else if createTime3 > createTime4{
//                return NSComparisonResult.OrderedAscending
//            }else{
//                return NSComparisonResult.OrderedSame
//            }
//        }
//        let array=list as NSArray
//        self.getHttpData(array)
//    }
//    func sequenceHeat(arr:NSMutableArray){
//        
//        let list = arr.sortedArrayUsingComparator { (info1, info2) -> NSComparisonResult in
//            let info3 = info1 as! DSProductsInfo
//            let info4 = info2 as! DSProductsInfo
//            
//            let interviewNum3 : Int? = Int(info3.interviewNum!)
//            let interviewNum4 : Int? = Int(info4.interviewNum!)
//            if interviewNum3 < interviewNum4{
//                return NSComparisonResult.OrderedDescending
//            }else if interviewNum3 > interviewNum4{
//                return NSComparisonResult.OrderedAscending
//            }else{
//                return NSComparisonResult.OrderedSame
//            }
//        }
//        
//        let array=list as NSArray
//        self.getHttpData(array)
//    }
    func getHttpData(data:NSArray){
        for index in 0..<data.count {
            self.city = nil
            self.phease = nil
            let list:NSMutableArray = NSMutableArray()
            let hotCellInfo = DSHotCellModel()
            let httpInfo = data[index] as! DSProductsInfo
            hotCellInfo.className = "DSHotTableViewCell"
            hotCellInfo.titleValue = httpInfo.brief
            for index in 0..<httpInfo.categoriesList.count {
                let categories = httpInfo.categoriesList[index] as! DSProductsCategoriesInfo
                if categories.name == "所在地区" {
                    self.city = self.catTihuan(self.city, httpStr: categories.descriptio)
                }else if categories.name == "所属行业"{
                    hotCellInfo.categories .addObject(categories.descriptio!)
                }else if categories.name == "融资阶段" {
                   self.phease = self.catTihuan(self.phease, httpStr: categories.descriptio)
                }
            }
            hotCellInfo.detailValue = self.detailValueTihuan(self.city, phease: self.phease)
            hotCellInfo.block = {[weak self] in
                if DSAccountInfo.sharedInstance().personId != nil {
                    if self!.limitsStatus() == true {
                        self?.canEnterPerDetail(httpInfo.id)
                    }else{
                        SMToast("由于您的身份限制，暂时无法查看")
                    }
                }else{
                    self!.gotoLoginVC()
                }
            }
            let hotVideoCellInfo = DSHotVideoCellModel()
            hotVideoCellInfo.className = "DSHotVideoTableViewCell"
            hotVideoCellInfo.videoUrl = httpInfo.videoUrl
            hotVideoCellInfo.block = {[weak self] in
                if DSAccountInfo.sharedInstance().personId != nil {
                    if self?.limitsStatus() == true && self?.roleJudge(httpInfo.id!) == true{
                        self?.judgeVideol(httpInfo.videoUrl, title: httpInfo.brief)
                    }else{
                        SMToast("由于您的身份限制，暂时无法查看")
                    }
                }else{
                    self!.gotoLoginVC()
                }
            }
            list.addObject(hotCellInfo)
            list.addObject(hotVideoCellInfo)
            self.dataSource.addObject(list)
        }
        self.tableView.reloadData()
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
    
    func gotoLoginVC(){
        let vc:DSLoginViewController = DSLoginViewController.createViewController(nil) as! DSLoginViewController
        vc.loginReturnType = LOGINTYPE.TABBARLOGIN
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(vc, animated: true)
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
    func roleJudge(id:String)->(Bool){
        if DSAccountInfo.sharedInstance().role == "PROVIDER" || DSAccountInfo.sharedInstance().role == "ROLE_PROVIDER"{
            if DSAccountInfo.sharedInstance().productsId == id {
                return true
            }else{
              return false
            }
        }
        return true
    }
    func canEnterPerDetail(id:String?){
        switch DSAccountInfo.sharedInstance().role {
        case "PROVIDER","ROLE_PROVIDER":
            if DSAccountInfo.sharedInstance().productsId == id {
                let vc:DSHotDetailViewController = DSHotDetailViewController.createViewController(nil) as! DSHotDetailViewController
                vc.projectId = id
                vc.hidesBottomBarWhenPushed = true
                self.pushViewController(vc, animated: true)
            }else{
                SMToast("由于您的身份限制，暂时无法查看")
            }
            break
        default:
            let vc:DSHotDetailViewController = DSHotDetailViewController.createViewController(nil) as! DSHotDetailViewController
            vc.projectId = id
            vc.hidesBottomBarWhenPushed = true
            self.pushViewController(vc, animated: true)
            break
        }
    }
    
    func limitsStatus()->(Bool){
        if DSAccountInfo.sharedInstance().authorized == "1"{
            return true
        }
        return false
    }
    
    
//    func pushWebViewController(urlstr:String,title:String?) {
//        let URL:NSURL? = NSURL.init(string: urlstr)!
//        let webViewController:STKWebKitViewController = STKWebKitViewController.init(URL: URL)
//        webViewController.hidesBottomBarWhenPushed=true;
//        if title != nil {
//            webViewController.title = title
//        }
//        self.navigationController?.pushViewController(webViewController, animated: true)
//    }
    
}

class DSHotTableViewDelegate: HTBaseTableViewDelegate {
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 90
        }else{
            return 35
        }
    }
    override  func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       
        return 10
    }
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) { //ios8
        
    }
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.backgroundColor = UIColor.clearColor()
    }
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor=UIColor.clearColor()
    }
}
