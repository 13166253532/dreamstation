//
//  DSProjectViewController.swift
//  DreamStation
//
//  Created by QPP on 16/7/19.
//  Copyright © 2016 QPP. All rights reserved.
//

import UIKit

private let TITLESTRING_PROJECT:String = "DSProjectViewController"

class DSProjectViewController: HTBaseViewController ,UIPageViewControllerDelegate,UIPageViewControllerDataSource {

    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet var contentContainer: UIView!
    
    @IBOutlet var segment: HMSegmentedControl!
  
    var city:String?
    var phease:String?
    var hotViewController:DSHotViewController!
    var timeViewController:DSHotViewController!
    var chooseViewControlelr:DSScreeningViewController!
    
    var pages:NSMutableArray!
    var pageViewController:UIPageViewController!
    var currentPage:UInt=0
    
    var arr:NSMutableArray!
    
    var timeHotPage:Int=0
    var messageBtn:UIButton!
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSProjectViewController", bundle: nil)
        let vc:DSProjectViewController=storyboard.instantiateViewControllerWithIdentifier("DSProjectViewController")as! DSProjectViewController
        vc.createArgs=createArgs
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pages = NSMutableArray()
        self.edgesForExtendedLayout=UIRectEdge.All
        self.automaticallyAdjustsScrollViewInsets=true
        self.initTitleBar()
        self.initSegment()
        self.setPageViewController()
        self.setPages()
        self.initPageController()
        self.setCurrentPage()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.hidesBottomBarWhenPushed = false
        self.navigationController?.navigationBar.lt_reset()
        
        self.messageBtnImage()
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    func dataTihuan(str:String?) -> (String?) {
        if str == nil {
            return "0"
        }else{
            let a = NSInteger(str!)
            return String(a!+1)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func initTitleBar() {
        super.initTitleBar()
        self.title=loadString("DSProjectTitle", tableId: TITLESTRINGTABLEID)
        
        let leftBtn:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "Project_search"), style: .Plain, target: self, action: #selector(searchOfClick))
        self.navigationItem.leftBarButtonItem = leftBtn
        
        let rightBtn1:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "homePage_activity"), style: .Plain, target: self, action: #selector(activityOfClick))
        
        self.messageBtn = UIButton.init(type: .Custom)
        self.messageBtn.frame = CGRectMake(0, 0, 23, 23)
        self.messageBtnImage()
//        self.messageBtn.addTarget(self, action:#selector(messageOfClick()), forControlEvents: .TouchUpInside)
        self.messageBtn.addTarget(self, action: #selector(messageOfClick), forControlEvents: .TouchUpInside)
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
    
    func initSegment(){
        self.segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.None
        self.segment.selectionStyle = HMSegmentedControlSelectionStyle.TextWidthStripe
        self.segment.sectionTitles = [loadString("DSProjectHot", tableId: TITLESTRING_PROJECT),loadString("DSProjectTime", tableId: TITLESTRING_PROJECT),loadString("DSProjectChoose", tableId: TITLESTRING_PROJECT)]
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
    func selectedController()->UIViewController{
        return self.pages[self.segment.selectedSegmentIndex] as! UIViewController
    }
    
    func setCurrentPage(){
        self.segment.setSelectedSegmentIndex(self.currentPage, animated: false)
        let index=self.pages.indexOfObject((self.pageViewController.viewControllers?.last)!)
        let direction:UIPageViewControllerNavigationDirection = self.segment.selectedSegmentIndex > index ? .Forward:.Reverse
        self.pageViewController.setViewControllers([self.selectedController()], direction: direction, animated: false, completion: nil)
    }
    func setPageViewController(){
        self.pageViewController = UIPageViewController.init(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.pageViewController.view.frame = CGRectMake(0, 0, self.contentContainer.frame.size.width, self.contentContainer.frame.size.height)
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        self.pageViewController.view.autoresizingMask = [.FlexibleWidth,.FlexibleHeight]
        self.addChildViewController(self.pageViewController)
        self.contentContainer.addSubview(self.pageViewController.view)
    }
    
    func initPageController(){
        if self.pages.count>0{
            self.pageViewController.setViewControllers([self.pages[0] as! UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
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
    func setPages(){
        let pages = NSMutableArray()
        self.hotViewController = self.createHotPageViewControllerWithTitle("热度")
        self.timeViewController = self.createTimePageViewControllerWithTitle("发布时间")
        self.chooseViewControlelr = self.createDSScreeningViewControllerWithTitle("筛选")
        pages.addObject(self.hotViewController)
        pages.addObject(self.timeViewController)
        pages.addObject(self.chooseViewControlelr)
        self.pages = pages
    }
    func createHotPageViewControllerWithTitle(title:String) -> DSHotViewController{
        let vc:DSHotViewController = DSHotViewController.createViewController(nil) as! DSHotViewController
        vc.projectPageType = .HeatPage
        vc.view.backgroundColor = grayBgColor
        return vc
    }
    func createTimePageViewControllerWithTitle(title:String) -> DSHotViewController{
        let vc:DSHotViewController = DSHotViewController.createViewController(nil) as! DSHotViewController
        vc.projectPageType = .TimePage
        vc.view.backgroundColor = loginBg_Color
        return vc
    }

    
    func createDSScreeningViewControllerWithTitle(title:String) -> DSScreeningViewController{
        let vc:DSScreeningViewController = DSScreeningViewController.createViewController(nil) as! DSScreeningViewController
        vc.block = {[weak self] (sender: AnyObject)in
            self!.setFilterUnselect()
            self!.projectTheData()
            let index=self!.pages.indexOfObject((self!.pageViewController.viewControllers?.last)!)
            self?.segment.selectedSegmentIndex=(self?.timeHotPage)!
            let direction:UIPageViewControllerNavigationDirection = self!.segment.selectedSegmentIndex > index ? .Forward:.Reverse
           self!.pageViewController.setViewControllers([self!.selectedController()], direction: direction, animated: true, completion: nil)
        }
        vc.parameterBlock = {[weak self] (sender: AnyObject)in
            let arr1 = sender as! NSMutableArray
            self?.arr = NSMutableArray()
            self?.arr = arr1
            self!.projectTheData()
            //print(self?.arr.count)
        }
        vc.view.backgroundColor = loginBg_Color
        vc.hidesBottomBarWhenPushed = true
        vc.pageType = .ProjectPage
        return vc
    }
    func projectTheData(){
        if self.arr.count != 0 {
            self.hotViewController.arr = (self.arr)!
            self.timeViewController.arr = (self.arr)!
        }else{
            self.hotViewController.arr = NSMutableArray()
            self.timeViewController.arr = NSMutableArray()
        }
    }
    //MARK:搜索
    func searchOfClick(){
        let vc:DSSearchViewController = DSSearchViewController.createViewController(nil) as! DSSearchViewController
        vc.hidesBottomBarWhenPushed = true
        vc.dataType = .ProjectData
        self.pushViewController(vc, animated: true)
    }
    //MARK:活动
    func activityOfClick(){
        let vc:DSActivityViewController = DSActivityViewController.createViewController(nil) as! DSActivityViewController
        vc.hidesBottomBarWhenPushed = true
        vc.isMyActivity = false
        self.pushViewController(vc, animated: true)
    }
    //MARK:信息
    func messageOfClick(){
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
//        self.timeHotPage = 2
        if index != 2{
            self.timeHotPage = index
        }
        

    }
    
    func setFilterUnselect(){
        self.filterBtn.setImage(UIImage(named: "Project_arrow_icon"), forState: UIControlState.Normal)
        self.filterBtn.setTitleColor(grayColor, forState: UIControlState.Normal)
    }
}

