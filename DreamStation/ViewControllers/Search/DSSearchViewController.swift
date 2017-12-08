//
//  DSSearchViewController.swift
//  DreamStation
//
//  Created by  on 16/7/29.
//  Copyright © 2016 QPP. All rights reserved.
//

import UIKit

enum DataType: Int{   //区分搜索界面历史记录
    case ProjectData = 1        //项目
    case InvestorsData = 2      //个人投资
    case ParkData = 3           //园区
    case InvestorAgencyData = 4 //投资机构
}

class DSSearchViewController: HTBaseViewController,UISearchBarDelegate {
    
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet var tableView: UITableView!
    
    var searchBar:MySearchBar!
    var delegate:DSSearchTableViewDelegate!
    var dataSource:NSMutableArray = NSMutableArray()

    var dataType:DataType = .ParkData   //莫名其妙非得给定初始值
    var projectDataList:NSMutableArray = NSMutableArray()
    var placeholderString:String!
    
    private var goBackVC:HTBaseViewController!
    private var textValue:String!
    private var keyValue:String!
    
    
    var myArray:NSArray = NSArray()
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSSearchViewController", bundle: nil)
        let vc:DSSearchViewController=storyboard.instantiateViewControllerWithIdentifier("DSSearchViewController")as! DSSearchViewController
        vc.createArgs=createArgs
        return vc
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.initHistoryData()
        self.addSearchBar()
        self.addBar()
        self.initTableView()
        self.backGroundView.hidden = true
        self.navigationController?.navigationBar.lt_reset()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    

    func initHistoryData(){
        switch self.dataType{
        case DataType.ProjectData:
            self.keyValue = "ProjectSearchHistory"
            self.placeholderString = "请输入项目名称"
            break
        case DataType.InvestorsData:
            self.keyValue = "InvestorsSearchHistory"
            self.placeholderString = "请输入投资者姓名"
            break
        case DataType.ParkData:
            self.keyValue = "ParkSearchHistory"
            self.placeholderString = "请输入园区名称"
            break
        case DataType.InvestorAgencyData:
            self.keyValue = "InvestorAgencySearchHistory"
            self.placeholderString = "请输入机构名称"
            break
        }
    }
   
    func addBar(){
        self.navigationItem.hidesBackButton = true
        self.title=""
        
    }
    func addSearchBar(){
        self.searchBar=MySearchBar.init()
        //self.searchBar.frame = CGRectMake(5, 0, SCREEN_WHIDTH()-70, 30)
        
        //self.searchBar=MySearchBar.init(frame: CGRectMake(5, 0, SCREEN_WHIDTH()-70, 30) )
        self.searchBar.setLeftPlaceholder(self.placeholderString)
        self.searchBar.delegate=self
        self.searchBar.tintColor = UIColorFromRGB(0x686868)
        self.navigationItem.titleView = searchBar
       
        let rightBar:UIBarButtonItem = UIBarButtonItem.init(title: "取消", style: .Plain, target: self, action: #selector(btnOfCancel))
        self.navigationItem.rightBarButtonItem = rightBar
        for view in  self.searchBar.subviews{
            if view.isKindOfClass(UIView)&&view.subviews.count>0{
                view.subviews[0].removeFromSuperview()
                break
            }
        }
    }
    func btnOfCancel(){
        self.hidesBottomBarWhenPushed = false
        self.navigationController?.popViewControllerAnimated(true)
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if searchBar.text?.characters.count>0 {
            ZYTokenManager.SearchText(searchBar.text, withKey: self.keyValue)
            switch self.dataType{
            case DataType.ProjectData:
                self.ProductSearch()
                break
            case DataType.InvestorsData:
                self.InvestorsSearch()
                break
            case DataType.ParkData:
               self.ParkSearch()
                break
            case DataType.InvestorAgencyData:
                self.InvestorsAgencySearch()
                break
            }
        }
    }
    //MARK:-------项目搜索
    func ProductSearch(){
        
        let vc:DSSearchResultViewController = DSSearchResultViewController.createViewController(nil) as! DSSearchResultViewController
        vc.name = searchBar.text
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:-------个人投资搜索
    func InvestorsSearch(){
        let vc:DSSearchInvestorResultVC = DSSearchInvestorResultVC.createViewController(nil) as! DSSearchInvestorResultVC
        vc.name = searchBar.text
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:-------园区搜索
    func ParkSearch(){
        let vc:DSSearchParkResultVC = DSSearchParkResultVC.createViewController(nil) as! DSSearchParkResultVC
        vc.name = searchBar.text
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:------投资机构搜索
    func InvestorsAgencySearch(){
        let vc:DSSearchAgencyResultVC = DSSearchAgencyResultVC.createViewController(nil) as! DSSearchAgencyResultVC
        vc.name = searchBar.text
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func initTableView(){
        //self.tableView.backgroundColor = UIColor.blackColor()
        self.readNSUserDefaults()
        self.initTableViewData()
        self.delegate = DSSearchTableViewDelegate()
        self.delegate.dataSource = self.dataSource
        self.delegate.array = self.myArray
        self.delegate.view = self.searchBar
        registerCell(self.tableView, cell: DSSearchHistoryCell.self)
        registerCell(self.tableView, cell: DSRemoveHistoryCell.self)
        self.tableView.delegate = self.delegate
        self.tableView.dataSource = self.delegate
        self.tableView.backgroundColor = loginBg_Color
        self.tableView.separatorStyle = .None
        setExtraCellLineHidden(self.tableView)
        self.delegate.block = {[weak self](value:AnyObject)in
            self?.searchBar.text = value as? String
            self?.searchBarSearchButtonClicked(self!.searchBar)
        }
    }
    
    func initTableViewData(){
        let list:NSMutableArray = NSMutableArray()
        if self.myArray.count > 0 {
            for index in 0 ..< self.myArray.count {
                let info:DSSearchHistoryCellModel = DSSearchHistoryCellModel()
                info.className = "DSSearchHistoryCell"
                info.labelValue = self.myArray.objectAtIndex(self.myArray.count-1-index) as! String
                list.addObject(info)
            }
            let info2:DSRemoveHistoryCellModel = DSRemoveHistoryCellModel()
            info2.className = "DSRemoveHistoryCell"
            info2.block = {[weak self] in
                ZYTokenManager.removeAllArray(self!.keyValue)
                self?.dataSource.removeAllObjects()
                self?.tableView.reloadData()
            }
            list.addObject(info2)
            self.dataSource.addObject(list)
        }
    }
    
    func readNSUserDefaults(){
        
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if userDefaults.arrayForKey(self.keyValue) != nil {
            let array:NSArray = userDefaults.arrayForKey(self.keyValue)!
            self.myArray = array
            //print(self.myArray)
            self.dataSource.removeAllObjects()
            self.tableView.reloadData()
        }
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.searchBar.removeFromSuperview()
        self.readNSUserDefaults()
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:searchBar代理方法
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        
        return true
    }
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.backGroundView.hidden = false
    }
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        self.backGroundView.hidden = true
    }
}
class DSSearchTableViewDelegate: HTBaseTableViewDelegate {
    var array:NSArray!
    var view:UISearchBar!
    var block:passParameterBlock?
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 30
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.array.count>0 {
            return self.array.count+1
        }
        return 0
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "    历史搜索"
    }
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFontOfSize(13)
        header.textLabel?.textColor = grayColor
        header.tintColor = UIColor.whiteColor()
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell:DSSearchHistoryCell = tableView.cellForRowAtIndexPath(indexPath) as! DSSearchHistoryCell
        self.view.text = cell.label.text
        self.block!(cell.label.text!)
    }
}

