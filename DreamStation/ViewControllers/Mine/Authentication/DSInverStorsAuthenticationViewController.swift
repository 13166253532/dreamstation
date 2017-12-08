//
//  DSInverStorsAuthenticationViewController.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/2.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSInverStorsAuthenticationViewController: HTBaseViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var selectBtn: UIButton!
    @IBOutlet var serviceBtn: UIButton!
    @IBOutlet var nextBtn: UIButton!
    
    @IBOutlet weak var tishiLabel: UILabel!
    var delegate:DSInverStorsAuthenticationDelegate!
    var dataSource:NSMutableArray!
    
    var type:NSInteger!
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSInverStorsAuthenticationViewController", bundle: nil)
        let vc:DSInverStorsAuthenticationViewController=storyboard.instantiateViewControllerWithIdentifier("DSInverStorsAuthenticationViewController")as! DSInverStorsAuthenticationViewController
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectBtn.selected = true
        self.selectBtn.setBackgroundImage(UIImage.init(named: "Authentication_xuanBtn"), forState: .Normal)
        self.dataSource = NSMutableArray()
        super.initTitleBar()
        
        self.title = loadString("DSChooseIdentitiesTitle", tableId: TITLESTRINGTABLEID)
        self.initTableView()
    }
    
    func initTableView(){
        self.initTableViewData()
        self.addLabel()
        self.delegate = DSInverStorsAuthenticationDelegate()
        self.delegate.dataSource = self.dataSource
        registerCell(self.tableView, cell: DSInverStorsAuthenticationCell.self)
        self.tableView.delegate = self.delegate
        self.tableView.dataSource = self.delegate
        
    }
    func addLabel() {
        let str = "已阅读并同意《服务协议》"
        let attStr:NSMutableAttributedString = NSMutableAttributedString.init(string: str)
        attStr.addAttribute(NSForegroundColorAttributeName, value: footBlueColor, range: (attStr.string as NSString).rangeOfString("《服务协议》"))
        self.tishiLabel.attributedText = attStr
    }
    
    
    
    func initTableViewData(){
    
        let list:NSMutableArray = NSMutableArray()
        
        let xinfo:DSInverStorsAuthenticationCellModel = DSInverStorsAuthenticationCellModel()
        xinfo.className = "DSInverStorsAuthenticationCell"
        xinfo.block = { [weak self] (value:AnyObject)->Void in
        
            self!.type = value as! NSInteger
        }
        
        list.addObject(xinfo)
        self.dataSource.addObject(list)
    }

    @IBAction func selectBtnOfClick(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected == true {
            sender.setBackgroundImage(UIImage.init(named: "Authentication_xuanBtn"), forState: .Normal)
            self.nextBtn.enabled = true
        }else{
            sender.setBackgroundImage(UIImage.init(named: "Authentication_weixuanBtn"), forState: .Normal)
            self.nextBtn.enabled = false
        }
    }
    
    @IBAction func serviceBtnOfClick(sender: UIButton) {
        
        let vc:DSServiceViewController = DSServiceViewController.createViewController(nil) as! DSServiceViewController
        self.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func nextBtnOfClick(sender: UIButton) {
        switch self.type {
        case 1:
            let vc:DSInvestmentAgencyVC = DSInvestmentAgencyVC.createViewController(nil) as! DSInvestmentAgencyVC
            vc.hidesBottomBarWhenPushed = true
            self.pushViewController(vc, animated: true)
            break
        case 2:
            let vc:DSPersonalInvestmentVC = DSPersonalInvestmentVC.createViewController(nil) as! DSPersonalInvestmentVC
            self.pushViewController(vc, animated: true)
            vc.hidesBottomBarWhenPushed = true
            break
        default:
            break
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
class DSInverStorsAuthenticationDelegate: HTBaseTableViewDelegate {
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 285
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
