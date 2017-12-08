//
//  DSMineMyProjectViewController.swift
//  DreamStation
//
//  Created by xjb on 16/8/23.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

enum MineMyProjectPageType: Int{
    /// 园区界面
    case ProvePage = 1
    /// 投资方界面
    case NoProvePage = 2
}

private let STRING_MINE = "DSMineStrings"
class DSMineMyProjectViewController: HTBaseViewController {

    @IBOutlet weak var myTabelView: UITableView!
    var dataSource:NSMutableArray!
    var delegate:DSMyProjectTableViewDelegate!
    var block:selectBlock!
    var pagrType:MineMyProjectPageType = MineMyProjectPageType.ProvePage
    
    @IBOutlet weak var tishiImage: UIImageView!
    
    @IBOutlet weak var tishiLabel: UILabel!
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSMineMyProjectViewController", bundle: nil)
        let vc:DSMineMyProjectViewController=storyboard.instantiateViewControllerWithIdentifier("DSMineMyProjectViewController")as! DSMineMyProjectViewController
        vc.createArgs=createArgs
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tishiImage.hidden = true
        self.tishiLabel.hidden = true
        self.view.backgroundColor = UIColor.whiteColor()
        self.myTabelView.backgroundColor = loginBg_Color
        setExtraCellLineHidden(self.myTabelView)
        self.initTitleBar()
        httpPerProgramsRequire()
    }

    override func initTitleBar() {
        super.initTitleBar()
        self.title=loadString("MineChooseProject", tableId: STRING_MINE)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addtableView(){
        self.delegate = DSMyProjectTableViewDelegate()
        registerCell(self.myTabelView, cell: DSMineMyProjectCell.self)
        self.delegate.dataSource = self.dataSource
        self.myTabelView.delegate = self.delegate
        self.myTabelView.dataSource = self.delegate
    }
    
    @IBAction func addAction(sender: AnyObject) {
        let vc:DSProjectAuthenticationVC = DSProjectAuthenticationVC.createViewController(nil) as! DSProjectAuthenticationVC
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(vc, animated: true)
    }
}
class DSMyProjectTableViewDelegate: DSLoginTableViewDelegate {
    var Shutdown = false
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 67
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.backgroundColor = UIColor.clearColor()
    }
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor=UIColor.clearColor()
    }

}

