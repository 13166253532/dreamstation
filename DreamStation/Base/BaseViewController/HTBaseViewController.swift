//
//  HTBaseViewController.swift
//  HiTeacher
//
//  Created by QPP on 16/4/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit


class HTBaseViewController: UIViewController {

    var createArgs:AnyObject!
    var catsArray = DSCatsArray()
    var videoId:String!
    
    
    deinit{
        
        print("------------------------------")
        print(NSStringFromClass(self.classForCoder)+"释放")
        print("------------------------------")
    }
    override func viewWillAppear(animated: Bool) {
        self.setNeedsStatusBarAppearanceUpdate()
        
       self.navigationController!.navigationBar.barStyle = UIBarStyle.Black
       UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")
        UIApplication.sharedApplication().statusBarOrientation = UIInterfaceOrientation.Portrait
    }
  
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor();
        let ver:Float=(UIDevice.currentDevice().systemVersion as NSString).floatValue
        if(ver>=7.0){
            self.edgesForExtendedLayout=UIRectEdge.None
            self.automaticallyAdjustsScrollViewInsets=false
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        }
        // Do any additional setup after loading the view.
    }
 
    override func shouldAutorotate() -> Bool {
        return true
    }
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func pushViewController(viewController:UIViewController,animated:Bool){
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func initTitleBar(){
        
        self.defaultBackButtonItem()
        self.initTitleBarColor()
        self.initReturnBtn()
    }
    private func defaultBackButtonItem(){
        let barButtonItem :UIBarButtonItem=UIBarButtonItem.init(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem=barButtonItem
        self.navigationController!.navigationBar.tintColor=UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor=greenNavigationColor
        self.navigationController?.navigationBar.subviews[0].backgroundColor=greenNavigationColor
    }
    private func initTitleBarColor(){
        let dict:[String:AnyObject]=[NSForegroundColorAttributeName:UIColor.whiteColor(), NSFontAttributeName:UIFont.systemFontOfSize(17.0)]
        self.navigationController!.navigationBar.titleTextAttributes = dict
    }
    private func initReturnBtn(){
        let leftN:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "Arrow"), style: .Plain, target: self, action: #selector(arrowResponse))
        
        self.navigationItem.leftBarButtonItem = leftN
    }
    func arrowResponse(){
        self.navigationController?.popViewControllerAnimated(true)
    }
   //MARK:跳转优酷
    func gotoYouKuVideoPlayView(videoUrl:String,title:String?){
        let vc:PlayerViewController = PlayerViewController.init(vid: self.videoId, platform: "youku", quality: "fly")
        vc.islocal = false
        vc.hidesBottomBarWhenPushed=true
        if self.judgmentVideoUrl(videoUrl) == true{
          self.getVideoId(videoUrl)
        }else{
            self.videoId = ""
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //MARK:地址是否合法
    func judgmentVideoUrl(videoUrl:String) -> (Bool) {
        let string = videoUrl as NSString
        if string.containsString("id_") && string.containsString(".html") {
            return true
        }
        return false
    }
    //MARK:获取视频id
    func getVideoId(videoUrl:String){
        let string = videoUrl as NSString
        let startRange = string.rangeOfString("id_")
        let endRange = string.rangeOfString(".html")
        let range = NSMakeRange(startRange.location+startRange.length, endRange.location-startRange.location-startRange.length)
        self.videoId = string.substringWithRange(range)
    }
    
}





























