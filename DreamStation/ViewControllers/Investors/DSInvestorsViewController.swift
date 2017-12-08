//
//  DSInvestorsViewController.swift
//  DreamStation
//
//  Created by QPP on 16/7/19.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

private let DSINVESTORS:String = "DSInvestors"

class DSInvestorsViewController: HTBaseViewController ,UIPageViewControllerDelegate,UIPageViewControllerDataSource{
    
   
    @IBOutlet weak var filterBtn: UIButton!
    //@IBOutlet weak var segment: HMSegmentedControl!
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var belowLayoutConstraint: NSLayoutConstraint!
    
    var segment = HMSegmentedControl()
    
    var groupArray:NSMutableArray!
    var peopleArray:NSMutableArray!
    
    var idSegment:DSIdSegmentControl!
    var invesPageType:InvesPageType = .PersonPage
    
    var screenVC:DSScreeningViewController!
    var timeVC:DSInvesCellViewController!
    var heatVC:DSInvesCellViewController!
    var screenDateArray:NSMutableArray!
    var timeDateArray:NSMutableArray!
    var heatDateArray:NSMutableArray!

    var pages:NSMutableArray!
    var pageViewController:UIPageViewController!
    var currentPage:UInt = 0
    var index = 0
    var arr = NSMutableArray()
    
    var timeHotPage = NSInteger()
    var messageBtn:UIButton!
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSInvestorsViewController", bundle: nil)
        let vc:DSInvestorsViewController=storyboard.instantiateViewControllerWithIdentifier("DSInvestorsViewController")as! DSInvestorsViewController
        vc.createArgs=createArgs
        return vc
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.lt_reset()
        self.messageBtnImage()
        initIdSegment()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTitleBar()
        //self.tabBarController!.tabBar.transform = CGAffineTransformMakeTranslation(0, 0)
        self.pages = NSMutableArray()
        self.edgesForExtendedLayout=UIRectEdge.All
        self.automaticallyAdjustsScrollViewInsets=true
       
        
        initType(0)

    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
//        self.timeVC.arr = NSMutableArray()
//        self.heatVC.arr = NSMutableArray()
//        self.screenVC.chongzhi()
//        DSAccountInfo.sharedInstance().institutionSX = self.dataTihuan(DSAccountInfo.sharedInstance().institutionSX )
    }
    func dataTihuan(str:String?) -> (String?) {
        if str == nil {
            return "0"
        }else{
            return str
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func initTitleBar() {
        super.initTitleBar()
        let leftBtn:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "Project_search"), style: .Plain, target: self, action: #selector(clickSearch))
        self.navigationItem.leftBarButtonItem = leftBtn
        let rightBtn1:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "homePage_activity"), style: .Plain, target: self, action: #selector(DSInvestorsViewController.clickActivity))
        self.messageBtn = UIButton.init(type: .Custom)
        self.messageBtn.frame = CGRectMake(0, 0, 23, 23)
        self.messageBtnImage()
        self.messageBtn.addTarget(self, action: #selector(clickMessage), forControlEvents: .TouchUpInside)
        let messageItem:UIBarButtonItem = UIBarButtonItem.init(customView: self.messageBtn)
        
        let list:NSArray = [messageItem,rightBtn1]
        
        self.navigationItem.rightBarButtonItems = list as? [UIBarButtonItem]
        
    }
    
    //改变消息按钮背景图片
    func messageBtnImage(){
        self.messageBtn.enabled = true
        if DSAccountInfo.sharedInstance().isRead == nil||DSAccountInfo.sharedInstance().isRead == "1" {
            self.messageBtn.setBackgroundImage(UIImage.init(named: "homePage_message"), forState: .Normal)
        }else{
            self.messageBtn.setBackgroundImage(UIImage.init(named: "homePage_messageNoRead"), forState: .Normal)
        }
    }
    
    //MARK:搜索
    func clickSearch(){
        
        let vc:DSSearchViewController = DSSearchViewController.createViewController(nil) as! DSSearchViewController
        
        if self.invesPageType == .InstituPage {
            vc.dataType = .InvestorAgencyData
        }else{
            vc.dataType = .InvestorsData
        }
        
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(vc, animated: true)

    }
    //MARK:活动
    func clickActivity(){
        let vc:DSActivityViewController = DSActivityViewController.createViewController(nil) as! DSActivityViewController
        vc.hidesBottomBarWhenPushed = true
        vc.isMyActivity = false
        self.pushViewController(vc, animated: true)
    }
    //MARK:消息
    func clickMessage(){
        self.messageBtn.enabled = false
        if DSAccountInfo.sharedInstance().personId != nil {
            let vc:DSMessageVC = DSMessageVC.createViewController(nil) as! DSMessageVC
            vc.hidesBottomBarWhenPushed = true
            self.pushViewController(vc, animated: true)
        }else{
            SMToast("请先登录")
            let vc:DSLoginViewController = DSLoginViewController.createViewController(nil) as! DSLoginViewController
            vc.loginReturnType = LOGINTYPE.TABBARLOGIN
            vc.hidesBottomBarWhenPushed = true
            self.pushViewController(vc, animated: true)
        }
    }
    
    //MAKE:-------------------
    func initIdSegment(){
        let nib:NSArray = NSBundle.mainBundle().loadNibNamed("DSIdSegmentControl", owner: self, options: nil)!
        self.idSegment = nib.lastObject as? DSIdSegmentControl
        
        self.idSegment.index = self.index
        self.idSegment.getgai()
        self.idSegment.block = {[weak self]
           (sender: AnyObject) in
            self!.initType(sender)
            self!.setFilterUnselect()
        }
        self.navigationItem.titleView = self.idSegment
    }
    
    func initType(inde:AnyObject){
        self.tabBarController?.tabBar.hidden=false
        if inde as! NSObject == 0 {
            self.index = 0
           self.invesPageType = InvesPageType.InstituPage
        }else{
            self.index = 1
           self.invesPageType = InvesPageType.PersonPage
        }
        initSegment()
        setPageViewController()
        setPage()
        initPageController()
        setCurrentPage()
    }
    
    func initSegment(){
        self.segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.None
        self.segment.selectionStyle = HMSegmentedControlSelectionStyle.TextWidthStripe
        self.segment.sectionTitles = [loadString("DSInvestorsHeat", tableId: DSINVESTORS),loadString("DSInvestorsTime", tableId: DSINVESTORS),loadString("DSInvestorsScreen", tableId: DSINVESTORS)]
        self.segment.selectionIndicatorColor = greenNavigationColor
        self.segment.selectionStyle = HMSegmentedControlSelectionStyle.FullWidthStripe
        self.segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.Down
        self.segment.titleTextAttributes = [NSFontAttributeName:UIFont.systemFontOfSize(14),NSForegroundColorAttributeName:grayColor]
        self.segment.selectedTitleTextAttributes = [NSFontAttributeName:UIFont.systemFontOfSize(14),NSForegroundColorAttributeName:greenNavigationColor]
        self.segment.selectionIndicatorHeight = 3.0
        
        self.segment.type = .Text
        
        self.segment.indexChangeBlock={
            [weak self] (index:NSInteger)->() in
            self!.setFilterUnselect()
            let index=self!.pages.indexOfObject((self!.pageViewController.viewControllers?.last)!)
            let direction:UIPageViewControllerNavigationDirection = self!.segment.selectedSegmentIndex > index ? .Forward:.Reverse
            self!.pageViewController.setViewControllers([self!.selectedController()], direction: direction, animated: true, completion: nil)
            self?.timeHotPage = index
        }
    }
    func selectedController() -> UIViewController {
        return self.pages[self.segment.selectedSegmentIndex] as! UIViewController
    }
    
    func setCurrentPage(){
        self.segment.setSelectedSegmentIndex(self.currentPage, animated: false)
        let index=self.pages.indexOfObject((self.pageViewController.viewControllers?.last)!)
        let direction:UIPageViewControllerNavigationDirection = self.segment.selectedSegmentIndex > index ? .Forward:.Reverse
        self.pageViewController.setViewControllers([self.selectedController()], direction: direction, animated: false, completion: nil)
   
    }
    func setPageViewController(){
        self.pageViewController = UIPageViewController.init(transitionStyle: .Scroll,navigationOrientation: .Horizontal,options: nil)
        self.pageViewController.view.frame = CGRectMake(0, 0, self.backgroundView.frame.size.width, self.backgroundView.frame.size.height)
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        self.pageViewController.view.autoresizingMask = [.FlexibleWidth,.FlexibleHeight]
        self.addChildViewController(self.pageViewController)
        self.backgroundView .addSubview(self.pageViewController.view)
        
    }

    func initPageController(){
        if self.pages.count > 0{
            self.pageViewController.setViewControllers([self.pages[0] as! UIViewController ], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        }
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.pages.indexOfObject(viewController)
        if index == NSNotFound||index+1>=self.pages.count {
            self.timeHotPage=index-1
            return nil
        }
        index += 1
        return self.pages[index] as? UIViewController
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.pages.indexOfObject(viewController)
        
        if index == NSNotFound||index == 0 {
            return nil
        }
        index -= 1
        return self.pages[index] as? UIViewController
    }
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed {
            return
        }
        let index:UInt = UInt(self.pages.indexOfObject((pageViewController.viewControllers?.last)!))
        if index==2{
            self.setFilterSelected()
        }else{
            self.segment.setSelectedSegmentIndex(index, animated: true)
            self.setFilterUnselect()
        }

    }
    func setPage(){
        let pages = NSMutableArray()
        self.heatVC = self.createHotPageViewControllerWithTitle("热度",sequenPageType: SequenPageType.HeatPage)
        self.timeVC = self.createHotPageViewControllerWithTitle("发布时间",sequenPageType: SequenPageType.TimePage)
        self.screenVC = self.createDSScreeningViewControllerWithTitle("筛选")
        pages.addObject(self.heatVC)
        pages.addObject(self.timeVC)
        pages.addObject(self.screenVC)
        self.pages = pages
        
    }
    func createHotPageViewControllerWithTitle(title:String,sequenPageType:SequenPageType) -> DSInvesCellViewController{
        let vc:DSInvesCellViewController = DSInvesCellViewController.createViewController(nil) as! DSInvesCellViewController
        vc.invesPageType = self.invesPageType
        vc.sequenPageType = sequenPageType
        vc.view.backgroundColor = loginBg_Color
        return vc
    }
    func createDSScreeningViewControllerWithTitle(title:String) -> DSScreeningViewController{
        let vc:DSScreeningViewController = DSScreeningViewController.createViewController(nil) as! DSScreeningViewController
        vc.pageType = .InvestorsPage
        vc.block = {[weak self] (sender: AnyObject)in
            self!.setFilterUnselect()
            let inde = sender as! NSInteger
            self!.investorsTheData()
            self!.idSegment.idSegment.selectedSegmentIndex = inde
            let index = self?.pages.indexOfObject((self?.pageViewController.viewControllers?.last)!)
            self?.segment.selectedSegmentIndex=(self?.timeHotPage)!
            let direction:UIPageViewControllerNavigationDirection = self?.segment.selectedSegmentIndex > index ? .Forward:.Reverse
            self?.pageViewController.setViewControllers([self!.selectedController()], direction: direction, animated: true, completion: nil)
        }
        vc.parameterBlock = {[weak self] (sender: AnyObject)in
            let arr1 = sender as! NSMutableArray
            self?.arr = arr1
            self!.investorsTheData()
        }
        vc.invesPageType = self.invesPageType
        self.belowLayoutConstraint.constant = 0
        vc.view.backgroundColor = loginBg_Color
        vc.hidesBottomBarWhenPushed = true
        return vc
    }
    
    func investorsTheData(){
        if self.arr.count != 0 {
            self.heatVC.arr = (self.arr)
            self.timeVC.arr = (self.arr)
        }else{
            self.heatVC.arr = NSMutableArray()
            self.timeVC.arr = NSMutableArray()
        }

    }
    
    
    @IBAction func clickFilterBtn(sender: AnyObject) {
        
        self.setFilterSelected()

    }
    
    func setFilterSelected(){
        self.filterBtn.setImage(UIImage(named: "Project_greenArrow_icon"), forState: UIControlState.Normal)
        self.filterBtn.setTitleColor(greenNavigationColor, forState: UIControlState.Normal)
        self.gotoFilterPage()
    }

    
    func gotoFilterPage(){
        self.segment.setSelectedSegmentIndex(2, animated: false)
        let index=self.pages.indexOfObject((self.pageViewController.viewControllers?.last)!)
        let direction:UIPageViewControllerNavigationDirection = self.segment.selectedSegmentIndex > index ? .Forward:.Reverse
        
        let vc=self.pages[2] as! UIViewController
        self.pageViewController.setViewControllers([vc], direction: direction, animated: true, completion: nil)
        if index != 2{
           self.timeHotPage = index
        }
        
    }
    
    
    
    
    func setFilterUnselect(){
        self.filterBtn.setImage(UIImage(named: "Project_arrow_icon"), forState: UIControlState.Normal)
        self.filterBtn.setTitleColor(grayColor, forState: UIControlState.Normal)
        
    }


}
