//
//  DSVideoPlayerViewController.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/22.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit



class DSVideoPlayerViewController: HTBaseViewController {
    
    @IBOutlet var videoTableView: UITableView!
    
    var delegate:DSVideoPlayerDelegate!
    var secondDataSource:NSMutableArray!
    
    var dataSource:NSMutableArray!
    var textContent:NSArray!
    
    var page1 = 0
    var page2 = 0
    //顶部刷新
    var header = MJRefreshNormalHeader()
    //底部刷新
    var footer = MJRefreshAutoNormalFooter()
    
     
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSVideoPlayerViewController", bundle: nil)
        let vc:DSVideoPlayerViewController=storyboard.instantiateViewControllerWithIdentifier("DSVideoPlayerViewController")as! DSVideoPlayerViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTitleBar()
        self.textContent = ["极客出发 第200期","极客出发 第201期","极客出发 第202期"]
        self.initTableViewData()
        self.initTableView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //self.dataSource = NSMutableArray()
        //self.httpFirstCellRequire()
        
    }
    
    override func initTitleBar() {
        super.initTitleBar()
         self.title = loadString("DSVideoPlayerTitle", tableId: TITLESTRINGTABLEID)
    }
    
    func initTableView(){
        self.addHeaderFooter()
        self.delegate = DSVideoPlayerDelegate()
        self.delegate.dataSource = self.dataSource
        registerCell(self.videoTableView, cell: DSHomePageVideoPlayerCell.self)
        registerCell(self.videoTableView, cell: DSVideoPlayerTitleCell.self)
        self.videoTableView.delegate = self.delegate
        self.videoTableView.dataSource = self.delegate
        self.videoTableView.backgroundColor = loginBg_Color
    }

    func initTableViewData(){
        self.dataSource = NSMutableArray()
        self.initFirstCell()
    }
    
    //MARK:添加上拉加载 下拉刷新
    func addHeaderFooter(){
        
        self.header.lastUpdatedTimeLabel.hidden = true
        self.header.stateLabel.hidden = true
        self.footer.stateLabel.hidden = true
        self.footer.refreshingTitleHidden = true
        self.videoTableView.mj_header = self.header
        self.videoTableView.mj_footer = self.footer
        self.header.setRefreshingTarget(self, refreshingAction: #selector(DSVideoPlayerViewController.upPullLoadData))
        
        
//        self.footer.setRefreshingTarget(self, refreshingAction: #selector(DSVideoPlayerViewController.downPlullLoadData))
        
        self.videoTableView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            self.downPlullLoadData()
        })
        
    }
    
    //MARK:下拉刷新
    func upPullLoadData(){
        self.page1 = 0
        self.page2 = 0
        self.dataSource = NSMutableArray()
        self.initFirstCell()
    }
    //MARK:上拉加载
    func downPlullLoadData(){
        //self.initFirstCell()
        self.videoTableView.reloadData()
        self.videoTableView.mj_footer.endRefreshing()
        self.videoTableView.mj_header.endRefreshing()
    }

    func initFirstCell(){
        self.httpFirstCellRequire()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DSVideoPlayerViewController{

    func httpFirstCellRequire(){
        let cmd:HttpCommand = DSHttpProgramsListCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {
            (result:RequestResult!,useInfo:AnyObject!)->() in
            self.httpfirstCellResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_ProgramsList_type] = "EXAMPLE"
        dic[kHttpParamKey_ProgramsList_showOnlyPublish] = true
        dic[kHttpParamKey_ProgramsList_page] = String(self.page1)
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpfirstCellResponse(result:RequestResult){
    
        let r:DSHttpProgramsListResult = result as! DSHttpProgramsListResult
        if r.isOk() {
            let arr:NSMutableArray = r.getAllContent()
            if arr.count != 0 {
                self.page1 = self.page1 + 1
                self.getHttpData(r.getAllContent(),istitle: false)
            }else{
                self.dataSource .addObject(self.firstPlayVideoCell())
            }
        }
        self.httpSecondCellRequire()
    }
    
    func httpSecondCellRequire(){
    
        let cmd:HttpCommand = DSHttpProgramsListCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {
             (result:RequestResult!,useInfo:AnyObject!)->() in
             self.httpSecondCellResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_ProgramsList_type] = "OTHER"
        dic[kHttpParamKey_ProgramsList_showOnlyPublish] = "true"
        dic[kHttpParamKey_ProgramsList_page] = String(self.page2)
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpSecondCellResponse(result:RequestResult){
        let r:DSHttpProgramsListResult = result as! DSHttpProgramsListResult
        if r.isOk() {
            let arr:NSMutableArray = r.getAllContent()
            if arr.count != 0 {
                self.page2 = self.page2 + 1
            }
            self.getHttpData(r.getAllContent(),istitle: true)
            
        }
        self.videoTableView.mj_footer.endRefreshing()
        self.videoTableView.mj_header.endRefreshing()
    }
    
    func getHttpData(data:NSMutableArray,istitle:Bool){
        let firstDataSource = NSMutableArray()
        if istitle == true {
            let titleCell = DSSetingCellModel()
            titleCell.className = "DSVideoPlayerTitleCell"
            firstDataSource .addObject(titleCell)
        }
        for index in 0..<data.count {
            let httpInfo = data[index] as! DSProgramsListInfo
            let videoCellInfo = DSHomePageCellModel()
            videoCellInfo.className = "DSHomePageVideoPlayerCell"
            videoCellInfo.labelText = httpInfo.text
            
//            let imageUrl:String = "http://192.168.1.70/wingmedia/v1/resource/view/" .stringByAppendingString(httpInfo.image!)
            let imageUrl:String = HTHttpConfig.sharedInstance().getServerAddress("").stringByAppendingFormat("/resource/view/"+httpInfo.image!)
            videoCellInfo.imageText = imageUrl
            
            videoCellInfo.block = {
                [weak self] in
                //self?.pushWebViewController(httpInfo.video!,title: httpInfo.text!)
                self!.gotoYouKuVideoPlayView(httpInfo.video!, title: httpInfo.text!)
            }
            firstDataSource.addObject(videoCellInfo)
        }
        self.dataSource.addObject(firstDataSource)
        self.initTableView()
        self.videoTableView.reloadData()
}
    func firstPlayVideoCell()->(NSMutableArray){
        let firstDataSource = NSMutableArray()
        let firstCell = DSHomePageCellModel()
        firstCell.className = "DSHomePageVideoPlayerCell"
        firstCell.labelText = nil
        firstCell.imageText = nil
        firstCell.block = {
        }
        firstDataSource .addObject(firstCell)
        return firstDataSource
    }
}

class DSVideoPlayerDelegate: HTBaseTableViewDelegate {
    let bizhi = Double(UIScreen.mainScreen().bounds.height)/736
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 0 {
            return 40
        }
        return (UIScreen.mainScreen().bounds.width-20)/(710/350)+10
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0000000000000000000000001
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        print("2222")
        print(section)
        return 0.0000000000000000000000001
    }
    
}
