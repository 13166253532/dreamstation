//
//  DSMineProjectViewController.swift
//  DreamStation
//
//  Created by xjb on 2016/12/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit
private let STRING_MINE = "DSMineStrings"
class DSMineProjectViewController: HTBaseViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource {

    @IBOutlet weak var segment: HMSegmentedControl!
    
    @IBOutlet weak var backgroundView: UIView!
    var block:selectBlock!
    var proveVC:DSMineMyProjectViewController!
    var noProveVC:DSMineMyProjectViewController!
    var pages:NSMutableArray!
    var pageViewController:UIPageViewController!
    var currentPage:UInt = 0
    
    var page:MineMyProjectPageType = MineMyProjectPageType.ProvePage
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSMineProjectViewController", bundle: nil)
        let vc:DSMineProjectViewController=storyboard.instantiateViewControllerWithIdentifier("DSMineProjectViewController")as! DSMineProjectViewController
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title=loadString("MineChooseProject", tableId: STRING_MINE)
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
    func initSegment(){
        
        self.segment.sectionTitles = ["已认证","未认证"]
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
        self.proveVC = self.createHotPageViewControllerWithTitle("园区",type: .ProvePage)
        self.noProveVC = self.createHotPageViewControllerWithTitle("项目",type: .NoProvePage)
        pages.addObject(self.proveVC)
        pages.addObject(self.noProveVC)
        self.pages = pages
    }
    func createHotPageViewControllerWithTitle(title:String,type:MineMyProjectPageType) -> DSMineMyProjectViewController{
        let vc:DSMineMyProjectViewController = DSMineMyProjectViewController.createViewController(nil) as! DSMineMyProjectViewController
        vc.pagrType = type
        vc.block = self.block
        return vc
    }

    @IBAction func action(sender: UIButton) {
        let vc:DSProjectAuthenticationVC = DSProjectAuthenticationVC.createViewController(nil) as! DSProjectAuthenticationVC
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(vc, animated: true)
        
    }

   
}
