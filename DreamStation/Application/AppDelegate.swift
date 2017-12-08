//
//  AppDelegate.swift
//  DreamStation
//
//  Created by QPP on 16/6/15.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabBarVC=HTRootTabBarViewController()
    var allowRotation = false
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        HTHttpConfig.sharedInstance().isout=false//内网
        //HTHttpConfig.sharedInstance().isout=true//外网
        
//        let runningTests=NSClassFromString("XCTest") != nil
//        if (runningTests==true){
//            self.initHttpConfig()
//            
//        }else{
//            HTShareSDKTool.sharedShareSDKTool().registerApp()
//            self.initRootViewController()
//            self.initHttpConfig()
//            resetDefaultData()
//        }
//        
//        self.registerJPush(launchOptions)
//        //MARK:------JPushTest
//        
//        self.messageIsRead()
        //增加标识，用于判断是否是第一次启动应用...
        if (!(NSUserDefaults.standardUserDefaults().boolForKey("everLaunched"))) {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey:"everLaunched")
            let guideViewController = MDFGuideViewController()
            self.window!.rootViewController=guideViewController;
            print("guideview launched!")
        }else{
            gotoRootVC()
        }
        self.registerJPush(launchOptions)
        
        return true
    }
    func gotoRootVC(){
        let runningTests=NSClassFromString("XCTest") != nil
        if (runningTests==true){
            self.initHttpConfig()
        }else{
            HTShareSDKTool.sharedShareSDKTool().registerApp()
            self.initRootViewController()
            self.initHttpConfig()
            resetDefaultData()
        }
        //MARK:------JPushTest
        self.messageIsRead()
    }
    func messageIsRead(){
        if DSAccountInfo.sharedInstance().personId != nil {
            let array = FGDBHelper.sharedInstance().queryAllMessage(DSAccountInfo.sharedInstance().personId) as NSMutableArray
            if array.count != 0 {
                self.isReadResult(array)
            }
        }
    }
    
    func isReadResult(list:NSMutableArray){
        for index in 0..<list.count {
            let model:HTMessageInfo = list[index] as! HTMessageInfo
            
            if model.isRead == "0" {
                DSAccountInfo.sharedInstance().isRead = "0"
                break
            }else{
                DSAccountInfo.sharedInstance().isRead = "1"
            }
        }
    }
    
    private func initHttpConfig(){
        ProjectConfigGroup.initHttpConfig()
    }
    
    
    func initTabbarVC(){
        tabBarVC=HTRootTabBarViewController()
        
    }
    func initRootViewController(){
//        if (DSAccountInfo.sharedInstance().personId != nil){
//            self.window?.rootViewController=tabBarVC
//        }else{
//            let vc2:DSLoginViewController=DSLoginViewController.createViewController(nil) as! DSLoginViewController
//            vc2.isPresent=false
//            let nav=UINavigationController(rootViewController: vc2 )
//            self.window?.rootViewController=nav
//            //self.window?.rootViewController!.presentViewController(nav, animated: true, completion: nil)
//        }

        self.window?.rootViewController=tabBarVC
        self.window?.backgroundColor=greenNavigationColor
        
       
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.smilingmobile.DreamStation" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("DreamStation", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            //dict[NSUnderlyingErrorKey] = error as! NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}

//MARK:--------JPush

extension AppDelegate{
    
    func registerJPush(launchOptions:[NSObject: AnyObject]?){
        
        JPUSHService.registerForRemoteNotificationTypes(UIUserNotificationType.Badge.rawValue | UIUserNotificationType.Sound.rawValue | UIUserNotificationType.Alert.rawValue , categories: nil)
        JPUSHService.setupWithOption(launchOptions, appKey: "4118254569e312719ebb7db4", channel: "App Store", apsForProduction: false)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.networkDidReceiveMessage(_:)), name: kJPFNetworkDidReceiveMessageNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DSLoginViewController.panduan), name: "AuthorizedResult", object: nil)
        
        //当用户点击通知消息进入应用时  cywu
        let remoteNotification = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey]
        if remoteNotification != nil {
            if remoteNotification!.allKeys.count != 0 {
    NSNotificationCenter.defaultCenter().postNotificationName("ReceiveNotification", object: remoteNotification)
            }
        }
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        /// Required - 注册 DeviceToken
        JPUSHService .registerDeviceToken(deviceToken)
        if DSAccountInfo.sharedInstance().personId == nil {
            UIApplication.sharedApplication().unregisterForRemoteNotifications()
        }
        
        //设置别名  cywu
        JPUSHService.setTags(nil, alias: DSAccountInfo.sharedInstance().personId, fetchCompletionHandle: { (code, tags, alias) in
            NSLog("code : %d", code)
        })
    }
    
    //---处理接受的信息
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        NSNotificationCenter.defaultCenter().postNotificationName("AuthorizedResult", object: nil, userInfo: nil)
        JPUSHService.handleRemoteNotification(userInfo)
        //cywu
        self.receiveNotification(userInfo)
    }
    
    func receiveNotification(userInfo: [NSObject : AnyObject]){
        //取得APNS信息内容
        NSLog("userInfo : %@", userInfo)
        let aps = userInfo["aps"] as! [NSObject : AnyObject]
        let content = aps["alert"] as! String //推送显示内容
        //        let badge = aps["badge"] as! int //推送显示内容
        NSLog("content : %@",content)
        JPUSHService.setBadge(0)
        
        //取得Extras字段内容
        //        self.setHome(2)
        
        pushMessageAnalysis(userInfo)
    }

    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(.NewData)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        NSLog("fail to register for remote notifications with error :%@", error)
    }
    
    func pushMessageAnalysis(userInfo:[NSObject : AnyObject]!){
        let content = userInfo!["content"]as! String //获取推送内容
//        print(info.title) 
        let info:HTMessageInfo=HTMessageInfo()
        if let aa=userInfo!["extras"]{
            let extras =  aa as! NSDictionary  //获取用户自定义参数
            let helper = FGDBHelper.sharedInstance()
            info.time=self.getDate()
            info.content=content
            //            info.isRead=false
            
            if let orderNo=extras["id"]{
                info.id=orderNo as! String
            }
            if let type=extras["type"]{
                info.type=type as! String
            }
            if let title=extras["title"]{
                info.title=title as! String
            }
            if let reason=extras["reason"]{
                info.reason=reason as! String
                if info.reason == nil || info.reason.characters.count == 0 {
                    info.reason = info.title
                }
            }
            info.isRead = "0"//isRead
            if DSAccountInfo.sharedInstance().personId != nil {
                info.accountId=DSAccountInfo.sharedInstance().personId
            }else{
                info.accountId = "0987654321123456789"
            }
            info.mId=info.time+info.content
            helper.saveMessage(info) { (isSuccess:Bool) in
                self.updateMessage(info)
            }
    }
        if info.type == JPUSHTYPE.AUTHENTICATION_ACCEPTED.rawValue {
            //JPUSHTYPE.UPDATE_PERSON_ACCEPTED.rawValue
            //JPUSHTYPE.AUTHENTICATION_REFUSED.rawValue
            self.logOut()
        }
        if info.type == JPUSHTYPE.ATTENTION.rawValue{
           DSAccountInfo.sharedInstance().PleaseFocusIsRead = "1"
        }
        if info.type == JPUSHTYPE.UPDATE_PROJECT_ACCEPTED.rawValue {
            DSAccountInfo.sharedInstance().productStatus = "ACCEPTED"
        }else if info.type == JPUSHTYPE.UPDATE_PROJECT_REFUSED.rawValue{
            DSAccountInfo.sharedInstance().productStatus = "REFUSED"
        }
        if DSAccountInfo.sharedInstance().personId != nil {
            showAlert("您有一条新消息", message: content, titleCancelBtn: "稍等", titleSecondBtn: "查看") {
                if info.type != JPUSHTYPE.AUTHENTICATION_ACCEPTED.rawValue {
                    self.gotoMessageVC()
                }
                JPUSHService.setBadge(0)
            }
            DSAccountInfo.sharedInstance().isRead = "0"
        }
}
    func gotoMessageVC(){
        if DSAccountInfo.sharedInstance().isOpenMessageVC == nil {
            self.goMessageView()
        }
        
    }
    
    
    //MARK:退出登录
    func logOut(){
        DSAccountInfo.sharedInstance().clearAccount()
        let vc:DSLoginViewController=DSLoginViewController.createViewController(nil) as! DSLoginViewController
        vc.loginReturnType = .OTHERLOGIN
        vc.hidesBottomBarWhenPushed=true
        let nav=self.tabBarVC.viewControllers![self.tabBarVC.selectedIndex]
        nav.childViewControllers.last!.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    func goMessageView(){
        let vc:DSMessageVC=DSMessageVC.createViewController(nil) as! DSMessageVC
        vc.hidesBottomBarWhenPushed=true
        let nav=self.tabBarVC.viewControllers![self.tabBarVC.selectedIndex]
        nav.childViewControllers.last!.navigationController?.pushViewController(vc, animated: true)
    }
    //MARK: - 自定义消息回调
    func networkDidReceiveMessage(notification:NSNotification){
        let userInfo = notification.userInfo
        pushMessageAnalysis(userInfo)
//        NSLog("content :%@", content)
    }
    func updateMessage(info:HTMessageInfo){
        print(info.title)
    }
//    func checkoutOrderStatus(status:String){
//        let account = DSAccountInfo.sharedInstance().personId
//        
//        if (status == HTOrderStatusStr.PENDING_CONFIRMATION.rawValue){
//            account.hasUncomfirmedOrder=true//待确认
//            account.unconfirmedNum=account.unconfirmedNum+1
//            self.updateHomePage()
//            tabBarVC.tabBar.showBadgeNumOnItemIndex(0, num: Int32(account.unconfirmedNum))
//        }else if (status == HTOrderStatusStr.FINISHED.rawValue){
//            account.hasCompletedOrder=true//已完成
//        }else if (status == HTOrderStatusStr.WAIT_FOR_COMPLETION.rawValue){
//            account.hasAcceptedOrder=true//待完成
//        }
//        
//        
//    }
    
//    func updateHomePage(){
//        let controllers=self.tabBarVC.viewControllers
//        
//        let navigationController=controllers![0] as! UINavigationController
//        let vcs=navigationController.viewControllers
////        for vc in vcs{
//        
////            if (vc.isKindOfClass(HTHomePageViewController)){
////                (vc as! HTHomePageViewController).httpOrderListRequire()
//            
////            }
////        }
//    }
//    
//    func updateMessage(){
//        let controllers=self.tabBarVC.viewControllers
//        let navigationController=controllers![2] as! UINavigationController
//        let vcs=navigationController.viewControllers
//        for vc in vcs{
//
//            if (vc.isKindOfClass(HTMessageViewController)){
//                let messageVC=vc as! HTMessageViewController
//                if (messageVC.isShowed==true){
//                    messageVC.updateView()
//                }
//            }
//        }
//    }
    
    
    private func getDate()->String{
        let dfmatter = NSDateFormatter()
        dfmatter.dateFormat="YYYY.MM.dd HH:mm"
        return dfmatter.stringFromDate(NSDate())
    }
    

}



