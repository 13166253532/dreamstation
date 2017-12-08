
//
//  DSMineMyCollectionViewController.swift
//  DreamStation
//
//  Created by xjb on 16/8/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit
private let STRING_MINE = "DSMineStrings"
class DSMineMyCollectionViewController: HTBaseViewController ,UIPageViewControllerDelegate,UIPageViewControllerDataSource{

    @IBOutlet weak var segment: HMSegmentedControl!
    
    @IBOutlet weak var backgroundView: UIView!
    
    var status:MineStatus = .MineProject_login_authentication
    var collectionPageType:CollectionPageType = .ParkPage
    
    var parkVC:DSCollectionViewController!
    var projectVC:DSCollectionViewController!
    var investorsVC:DSCollectionViewController!
    
    var pages:NSMutableArray!
    var pageViewController:UIPageViewController!
    var currentPage:UInt = 0
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSMineMyCollectionViewController", bundle: nil)
        let vc:DSMineMyCollectionViewController=storyboard.instantiateViewControllerWithIdentifier("DSMineMyCollectionViewController")as! DSMineMyCollectionViewController
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = loginBg_Color
        self.edgesForExtendedLayout=UIRectEdge.All
        self.automaticallyAdjustsScrollViewInsets=true

        initTitleBar()
        initSegment()
        setPageViewController()
        setPage()
        initPageController()
        setCurrentPage()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func initTitleBar() {
        super.initTitleBar()
        self.title=loadString("MineCollection", tableId: STRING_MINE)
    }


    func initSegment(){
        
        switch self.status {
        case .MineInvestors_login_authentication_father:
            self.segment.sectionTitles = ["项目","园区"]
            break
        case .MineInvestors_login_authentication_child:
            self.segment.sectionTitles = ["项目","园区"]
            break
        case .MineProject_login_authentication:
            self.segment.sectionTitles = ["投资方","园区"]
            break
        case .MinePark_login_authentication:
            self.segment.sectionTitles = ["项目","投资方"]
            break
        default:
            break
        }
        self.segment.selectionIndicatorColor = greenNavigationColor
        
        self.segment.selectionStyle = HMSegmentedControlSelectionStyle.FullWidthStripe
        self.segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.Down
        self.segment.titleTextAttributes = [NSFontAttributeName:UIFont.systemFontOfSize(14),NSForegroundColorAttributeName:grayColor]
        self.segment.selectedTitleTextAttributes = [NSFontAttributeName:UIFont.systemFontOfSize(14),NSForegroundColorAttributeName:greenNavigationColor]
        self.segment.selectionIndicatorHeight = 3.0
        self.segment.borderType = .Bottom
        self.segment.borderColor = greyLineColor
        self.segment.indexChangeBlock = {
            [weak self](indext:NSInteger)->() in
            let index = self?.pages.indexOfObject((self?.pageViewController.viewControllers?.last)!)
            let direction:UIPageViewControllerNavigationDirection = self?.segment.selectedSegmentIndex > index ? .Forward:.Reverse
            self?.pageViewController.setViewControllers([self!.selectedController()], direction: direction, animated: true, completion: nil)
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
        self.segment.setSelectedSegmentIndex(index, animated: true)
    }
    func setPage(){
        let pages = NSMutableArray()
        self.parkVC = self.createHotPageViewControllerWithTitle("园区",pageType: .ParkPage)
        self.projectVC = self.createHotPageViewControllerWithTitle("项目",pageType: .ProjectPage)
        self.investorsVC = self.createHotPageViewControllerWithTitle("投资方",pageType: .InvestorsPage)
        switch self.status {
        case .MineInvestors_login_authentication_father:
            pages.addObject(self.projectVC)
            pages.addObject(self.parkVC)
            break
        case .MineInvestors_login_authentication_child:
            pages.addObject(self.projectVC)
            pages.addObject(self.parkVC)
            break
        case .MineProject_login_authentication:
             pages.addObject(self.investorsVC)
             pages.addObject(self.parkVC)
            break
        case .MinePark_login_authentication:
            pages.addObject(self.projectVC)
            pages.addObject(self.investorsVC)
            break
        default:
            break
        }
        self.pages = pages
        
    }
    func createHotPageViewControllerWithTitle(title:String,pageType:CollectionPageType) -> DSCollectionViewController{
        let vc:DSCollectionViewController = DSCollectionViewController.createViewController(nil) as! DSCollectionViewController
        vc.collectionPageType = pageType
        vc.view.backgroundColor = loginBg_Color
        return vc
    }



}
