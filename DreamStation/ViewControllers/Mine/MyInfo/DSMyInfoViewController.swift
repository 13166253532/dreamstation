//
//  DSMyInfoViewController.swift
//  DreamStation
//
//  Created by QPP on 16/8/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

enum InfoImageType:Int {
    case AVATAR = 1
    case BUSINESSCARD = 2
    case LICENSE = 3
    case BUSINESSCARD2 = 4
    case BUSINESSCARD3 = 5
}

class DSMyInfoViewController: HTBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var delegate:DSMyInfoDelegate!
    var status:MineStatus = .MineInvestors_login_unauthentication
    var dataSource:NSMutableArray=NSMutableArray()
    var catsData:NSMutableArray=NSMutableArray()
    var personChangeCats:NSMutableArray = NSMutableArray()
    var httpInfo:DSGetPersonAccountInfo!
    var productInfo:DSProductsDetailsInfo!
    var parkInfo:DSGetPersonAccountParkInfo!
    var picker:pickView = pickView()
    var imageBlock:passParameterBlock!
    var passBlock:passParameterBlock!
    var normalBlock:passParameterBlock!
    var cardImageBlock:passParameterBlock!
    var avatarValue:String?
    var businessCardValue:String?
    var licenseValue:String?
    var infoImageType:InfoImageType = .AVATAR
    
    var followArea:String?
    var InvestmentStage:String?
    var investArea:String?
    var mainMoney:String?
    var minValue:String?
    var maxValue:String?
    var followValue:String?
    var stageValue:String?
    var areaValue:String?
    var moneyValue:String?
    var catList:NSMutableArray = NSMutableArray()
    var projectID:String?
    var didShow:Bool?

    var removeIndex:String?

    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSMyInfoViewController", bundle: nil)
        let vc:DSMyInfoViewController=storyboard.instantiateViewControllerWithIdentifier("DSMyInfoViewController")as! DSMyInfoViewController
        vc.createArgs=createArgs
        return vc
    }
    override func viewWillAppear(animated: Bool) {
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTitleBar()
        self.initDataWithStatus()
        self.initTableView()
    }
    
    func initDataWithStatus(){
        switch self.status {
        case .MineInvestors_login_unauthentication:
            self.initTheFirstStatus()
            break
        case .MineInvestors_login_authentication_father:    //已认证个人投资方
            self.httpGetPersonAccountRequire(.MineInvestors_login_authentication_father)
            self.initNavigationController()
            break
        case .MineInvestors_login_authentication_child:     //已认证机构投资
            self.httpGetPersonAccountRequire(.MineInvestors_login_authentication_child)
            self.initNavigationController()
            break
        case .MineProject_login_unauthentication:
            self.initTheFirstStatus()
            break
        case .MineProject_login_authentication:     //已认证项目方
            self.initNavigationController()
            self.httpGetProductAccountRequire()
            break
        case .MinePark_login_authentication:
            self.httpGetPersonAccountRequire(.MinePark_login_authentication)
            self.initNavigationController()
            break
        }
    }
    
    override func initTitleBar() {
        super.initTitleBar()
        self.view.backgroundColor=grayBgColor
        
        self.title=loadString("DSMyInfomationTitle", tableId: TITLESTRINGTABLEID)
    }
    
    func initNavigationController(){
        let leftItem = UIBarButtonItem.init(title: "保存", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(DSMyInfoViewController.clickSave))
        self.navigationItem.rightBarButtonItem = leftItem
    }
    
    func clickSave(){

        self.showAttention()
    }
    
    func initTableView(){
        self.delegate=DSMyInfoDelegate()
        self.delegate.dataSource=self.dataSource
        self.tableView.delegate=self.delegate
        self.tableView.dataSource=self.delegate
        setExtraCellLineHidden(self.tableView)
        registerCell(self.tableView, cell: DSAgencyFirstCell.self)
        registerCell(self.tableView, cell: DSAgencySeventhCell.self)
        registerCell(self.tableView, cell: DSAgencyThirdCell.self)
        registerCell(self.tableView, cell: DSAgencySecondCell.self)
        registerCell(self.tableView, cell: DSAgencyFourthCell.self)
        registerCell(self.tableView, cell: DSAgencySixthCell.self)
        registerCell(self.tableView, cell: DSProjectEighthCell.self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

class DSMyInfoDelegate:HTBaseTableViewDelegate{
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let arr=self.dataSource[indexPath.section] as! NSMutableArray
        let info:HTBaseCellModel=arr.objectAtIndex(indexPath.row) as! HTBaseCellModel
        if info.className=="DSAgencySeventhCell" || info.className=="DSAgencySecondCell"{
             return 80
        }else if info.className=="DSAgencyFourthCell"{
            return 150
        }else{
            return 44
        }
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == self.dataSource.count-1{
            return 15
        }
        return 0
    }
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.backgroundColor = UIColor.clearColor()
    }
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor=UIColor.clearColor()
    }
}

