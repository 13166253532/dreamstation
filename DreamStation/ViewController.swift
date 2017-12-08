//
//  ViewController.swift
//  DreamStation
//
//  Created by QPP on 16/6/15.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class ViewController: HTBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var data=NSMutableArray()
    var delegate:ViewControllerDelegate!
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vc:ViewController=storyboard.instantiateViewControllerWithIdentifier("ViewController")as! ViewController
        vc.createArgs=createArgs
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.initTitleBar()
//        self.initTableData()
//        self.initTableView()
    }
    override func initTitleBar() {
        super.initTitleBar()
        self.title=loadString("DSTitle", tableId: TITLESTRINGTABLEID)
    }
    func initTableData(){
        let sectionArr=NSMutableArray()
        self.initTheVC(sectionArr, title: "登录") {
            [weak self] in
            let vc:DSLoginViewController=DSLoginViewController.createViewController(nil) as! DSLoginViewController
            self!.pushViewController(vc, animated: true)
        }
        self.initTheVC(sectionArr, title: "首页") {
            [weak self] in
            let vc:DSHomePageViewController=DSHomePageViewController.createViewController(nil) as! DSHomePageViewController
            self!.pushViewController(vc, animated: true)
        }
        
        self.initTheVC(sectionArr, title: "投资方") {
            [weak self] in
            let vc:DSInvestorsViewController=DSInvestorsViewController.createViewController(nil) as! DSInvestorsViewController
            self!.pushViewController(vc, animated: true)
        }
        
        self.initTheVC(sectionArr, title: "我的") {
            [weak self] in
            let vc:DSMineViewController=DSMineViewController.createViewController(nil) as! DSMineViewController
            self!.pushViewController(vc, animated: true)
        }
        
        self.initTheVC(sectionArr, title: "园区") {
            [weak self] in
            let vc:DSParkViewController=DSParkViewController.createViewController(nil) as! DSParkViewController
            self!.pushViewController(vc, animated: true)
        }
        
        self.initTheVC(sectionArr, title: "项目") {
            [weak self] in
            let vc:DSProjectViewController=DSProjectViewController.createViewController(nil) as! DSProjectViewController
            self!.pushViewController(vc, animated: true)
        }

        self.initTheVC(sectionArr, title: "申请发布园区信息") {
            [weak self] in
            let vc:DSParkMessageViewController=DSParkMessageViewController.createViewController(nil) as! DSParkMessageViewController
            self!.pushViewController(vc, animated: true)
        }
        
        self.initTheVC(sectionArr, title: "选择城市") {
            [weak self] in
            let vc:DSChooseCityViewController=DSChooseCityViewController.createViewController(nil) as! DSChooseCityViewController
            self!.pushViewController(vc, animated: true)
        }
        
        self.data.addObject(sectionArr)
        
    }
    
    func initTheVC(data:NSMutableArray,title:String,block:selectBlock){
        let info=viewControllerData()
        info.className="DSViewControlllerTableViewCell"
        info.title=title
        info.cellBlock=block
        data.addObject(info)
    }
    

    func initTableView(){
        self.delegate=ViewControllerDelegate()
        self.delegate.dataSource=self.data
        self.tableView.delegate=self.delegate
        self.tableView.dataSource=self.delegate
        registerCell(self.tableView, cell: DSViewControlllerTableViewCell.self)
    }

    func pushWebViewController(){
        let url=NSURL(string: "http://v.youku.com/v_show/id_XMTU1ODk4MDYyNA==.html")
        let webViewController=STKWebKitViewController(URL: url)
        webViewController.modalPresentationStyle = .FormSheet
        self.presentViewController(webViewController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

