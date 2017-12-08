//
//  DSSearchResultViewController.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/7.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

// ------------项目搜索-----------

class DSSearchResultViewController: HTBaseViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var attImage: UIImageView!
    @IBOutlet var attLabel: UILabel!

    var delegate:DSSearchProjectTableViewDelegate!
    var dataSource:NSMutableArray = NSMutableArray()
    
    var city:String?
    var phease:String?   //阶段
    var industry:String? //行业
    var money:String?    //币种
    
    var name:String!
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSSearchResultViewController", bundle: nil)
        let vc:DSSearchResultViewController=storyboard.instantiateViewControllerWithIdentifier("DSSearchResultViewController")as! DSSearchResultViewController
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.attImage.hidden = true
        self.attLabel.hidden = true
        self.initTitleBar()
        self.initTableView()
    }
    
    override func initTitleBar() {
        super.initTitleBar()
        self.title=self.name
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.lt_reset()
        self.initTitleBar()
    }
    
    func initTableView(){
        self.initHotViewData()
        self.delegate = DSSearchProjectTableViewDelegate()
        self.delegate.dataSource = self.dataSource
        registerCell(self.tableView, cell: DSHotTableViewCell.self)
        registerCell(self.tableView, cell: DSHotVideoTableViewCell.self)
        self.tableView.delegate = self.delegate
        self.tableView.dataSource = self.delegate
        self.tableView.backgroundColor = loginBg_Color
        setExtraCellLineHidden(self.tableView)
    }
    
    func initHotViewData(){
        self.httpSearchProjectRequire(self.name)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

class DSSearchProjectTableViewDelegate: HTBaseTableViewDelegate {
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 90
        }else{
            return 35
        }
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
