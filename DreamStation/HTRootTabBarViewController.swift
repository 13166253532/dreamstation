//
//  EPRootTabBarViewController.swift
//  electricVCP
//
//  Created by QPP on 16/3/10.
//  Copyright © 2016年 qbshen. All rights reserved.
//

import UIKit


private let NAME_STORYBOARD_ACTIVITY:String="HTRootTabBarViewController"
private let IDENTIFIER_ACTIVITY:String="HTRootTabBarViewController"

class HTRootTabBarViewController: UITabBarController,UITabBarControllerDelegate {

    var markNavgation :UINavigationController!
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: NAME_STORYBOARD_ACTIVITY, bundle: nil)
        let vc:HTRootTabBarViewController=storyboard.instantiateViewControllerWithIdentifier(IDENTIFIER_ACTIVITY)as! HTRootTabBarViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadNCS()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadNCS(){
        let rootBarViewControllers:NSArray=[self.gainHomePage(),self.gainProject(),self.gainInvestors(),self.gainPark(),self.gainMine()]
        
        markNavgation = rootBarViewControllers[0] as? UINavigationController
        self.setViewControllers(rootBarViewControllers as? [UIViewController], animated: true)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:grayTabbarColor,NSFontAttributeName:UIFont.boldSystemFontOfSize(12)], forState: UIControlState.Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:greenNavigationColor,NSFontAttributeName:UIFont.boldSystemFontOfSize(12)], forState: UIControlState.Selected)
        self.tabBar.tintColor=grayTabbarColor
        let bgView:UIView=UIView.init(frame: self.tabBar.bounds)
        bgView.backgroundColor=UIColor.whiteColor()
        self.tabBar.insertSubview(bgView, atIndex: 0)
        self.delegate=self
        self.tabBar.opaque=true
    }
    func getNavigationWithVc(vc:UIViewController,title:String,img1:String,selectImg:String)->UINavigationController{
        let nav:UINavigationController=UINavigationController.init(rootViewController: vc)
        var img:UIImage=UIImage(named: img1)!
        img=img.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        var imgSelect:UIImage=UIImage(named: selectImg)!
        imgSelect=imgSelect.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        nav.tabBarItem=UITabBarItem.init(title: title, image: img, selectedImage: imgSelect)
        return nav
    }
    func gainHomePage()->UINavigationController{
       let homevc=DSHomePageViewController.createViewController(nil) as! DSHomePageViewController
        return self.getNavigationWithVc(homevc, title: "首页", img1: "tabbar_home_nor", selectImg:"tabbar_home_select")
    }
    
    func gainProject()->UINavigationController{
        let vc:DSProjectViewController=DSProjectViewController.createViewController(nil) as! DSProjectViewController
        
        return self.getNavigationWithVc(vc, title: "项目", img1: "tabbar_project_nor", selectImg:"tabbar_project_select")
    }
    
    func gainInvestors()->UINavigationController{
       let vc:DSInvestorsViewController=DSInvestorsViewController.createViewController(nil) as! DSInvestorsViewController
        
        return self.getNavigationWithVc(vc, title: "投资方", img1: "tabbar_investors_nor", selectImg:"tabbar_investors_select")
    }
    
    func gainPark()->UINavigationController{
        let vc:DSParkViewController=DSParkViewController.createViewController(nil) as! DSParkViewController
        
        return self.getNavigationWithVc(vc, title: "园区", img1: "tabbar_park_nor", selectImg:"tabbar_park_select")
    }
    
    
    func gainMine()->UINavigationController{
        let vc:DSMineViewController=DSMineViewController.createViewController(nil) as! DSMineViewController
        
        return self.getNavigationWithVc(vc, title: "我的", img1: "tabbar_mine_nor", selectImg:"tabbar_mine_select")

    }
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool{
        let nav = viewController as! UINavigationController
        if nav.viewControllers[0].isKindOfClass(DSMineViewController) {
            if DSAccountInfo.sharedInstance().personId == nil {
                let vc2:DSLoginViewController=DSLoginViewController.createViewController(nil) as! DSLoginViewController
                vc2.loginReturnType = LOGINTYPE.TABBARLOGIN
                vc2.isPresent=false
                vc2.hidesBottomBarWhenPushed = true
                markNavgation?.pushViewController(vc2, animated: true)
                return false

            }
            return true
        }
        markNavgation = viewController as!UINavigationController
        return true
        
    }

}
