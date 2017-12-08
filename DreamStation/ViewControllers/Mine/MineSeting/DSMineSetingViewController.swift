//
//  DSMineSetingViewController.swift
//  DreamStation
//
//  Created by xjb on 16/7/21.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSMineSetingViewController: HTBaseViewController{

    
    @IBOutlet weak var myTableView: UITableView!
    
    var dataSource:NSMutableArray!
    
    var delegate:MineSettingDelegate!
    
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSMineSetingViewController", bundle: nil)
        let vc:DSMineSetingViewController=storyboard.instantiateViewControllerWithIdentifier("DSMineSetingViewController")as! DSMineSetingViewController
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTitleBar()
        self.initTableView()
        
        
    }
    override func initTitleBar() {
     
        super.initTitleBar()
        self.title=loadString("DSSettingTitle", tableId: TITLESTRINGTABLEID)
        
        
    }

    //MARK:-----------TableView加载----------
    func initTableView() {
        self.initDataSource()
        registerCell(self.myTableView, cell: DSMineSetingNormalCell.self)
        registerCell(self.myTableView, cell: DSMineSetingOneCell.self)
        registerCell(self.myTableView, cell: DSMineSetingTwoCell.self)
       //setDeletableForTableView(self.myTableView, delegate: tableDelegate)
        self.delegate=MineSettingDelegate()
        self.delegate.dataSource=self.dataSource
        
        self.myTableView.delegate = self.delegate
        self.myTableView.dataSource = self.delegate
        self.myTableView.backgroundColor=grayBgColor
        setExtraCellLineHidden(self.myTableView)
   
    }

    func initDataSource(){
        self.dataSource = NSMutableArray()
        
        initFirstSection()
        initTwoSection()
        initThirdSection()
    }
    
    
    func initFirstSection(){
        let arr = NSMutableArray()
        self.initTheCell(arr, cell: "DSMineSetingNormalCell", title: "修改密码", subTitle: "") {
            [weak self]in
            let vc:DSMineChangePassVC=DSMineChangePassVC.createViewController(nil) as! DSMineChangePassVC
            self!.pushViewController(vc, animated: true)
        }
        self.dataSource.addObject(arr)
    }
    
    func initTwoSection(){
        
        let arr = NSMutableArray()
        self.initTheCell(arr, cell: "DSMineSetingNormalCell", title: "反馈建议", subTitle: "") {
            [weak self]in
            let vc:DSFeedBackViewController=DSFeedBackViewController.createViewController(nil) as! DSFeedBackViewController
            self!.pushViewController(vc, animated: true)
        }
        self.initTheCell(arr, cell: "DSMineSetingNormalCell", title: "关于我们", subTitle: "") {
            [weak self]in
            let vc:DSAboutUsViewController=DSAboutUsViewController.createViewController(nil) as! DSAboutUsViewController
            self!.pushViewController(vc, animated: true)
        }
        self.initTheCell(arr, cell: "DSMineSetingOneCell", title: "当前版本", subTitle: "版本 1.0.0") {
            
        }
        self.dataSource.addObject(arr)
        
    }
    func initThirdSection(){
        let arr = NSMutableArray()
        self.initTheCell(arr, cell: "DSMineSetingTwoCell", title: "退出登录", subTitle: "") {
            
            [weak self] in
            showAlert("确定退出登录？", message: "", titleCancelBtn: "取消", titleSecondBtn: "确认", blockOtherBtn: {
                [weak self]in
                
                DSAccountInfo.sharedInstance().clearAccount()
                let vc2:DSLoginViewController=DSLoginViewController.createViewController(nil) as! DSLoginViewController
                vc2.loginReturnType = LOGINTYPE.OTHERLOGIN
                vc2.hidesBottomBarWhenPushed = true
                self!.pushViewController(vc2, animated: true)
            })
        }
        self.dataSource.addObject(arr)
    }
    
    func initTheCell(arr:NSMutableArray, cell:String,title:String,subTitle:String,block:selectBlock){
        let info:DSSetingCellModel = DSSetingCellModel()
        info.className = cell
        info.title = title
        info.subTitle = subTitle
        info.block = block
        arr.addObject(info)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //MARK:- tableView delegate datasource
    
   



}

class  MineSettingDelegate: HTBaseTableViewDelegate {
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return 15
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
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




