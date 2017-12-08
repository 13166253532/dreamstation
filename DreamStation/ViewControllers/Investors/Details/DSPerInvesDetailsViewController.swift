//
//  DSPerInvesDetailsViewController.swift
//  DreamStation
//
//  Created by xjb on 16/8/29.
//  Copyright © 2016 QPP. All rights reserved.
//

import UIKit
private let DSINVESTORS:String = "DSInvestors"
class DSPerInvesDetailsViewController: HTBaseViewController,SGActionSheetDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    var delegate:DSInvesDetailsTableViewDelegate!
    var dataSource:NSMutableArray!
    /// 是否展开
    var isAn = false
    /// 是否收藏
    var isCollection = false
    /// 是否关注

    @IBOutlet var collectionMaxBtn: UIButton!

    @IBOutlet weak var followBtn: UIButton!
    
    var isFollow = false
    
    var invesPageType:InvesPageType = .PersonPage
    
    var infoData = DSInvestorsCellModel()
    var info:DSGetPersonAccountInfo!
    var person_id:String?
    var followNum:String?
    
    var isClickShare:Bool = true
    var pageUrl:String?
    var shareImageString:String?
    var shareTitleString:String?
    var withContent:String?
    
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSPerInvesDetailsViewController", bundle: nil)
        let vc:DSPerInvesDetailsViewController=storyboard.instantiateViewControllerWithIdentifier("DSPerInvesDetailsViewController")as! DSPerInvesDetailsViewController
        vc.createArgs=createArgs
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.initTitleBar()
        self.addRightBtn()
        self.initTableView()
        self.initFistCell()
        self.scrollViewDidScroll(self.myTableView)
        
        self.httpGetPersonAccountRequire()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //self.myTableView.alpha = 0
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.delegate.slidingBlock = nil
        self.navigationController?.navigationBar.lt_reset()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func addRightBtn(){
        self.navigationController?.navigationBar.lt_setBackgroundColor(UIColor.clearColor())
        
        let rightBtn:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "homePage_fenxiang"), style: .Plain, target: self, action: #selector(gotoShare))
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    
    //MARK:分享
    func gotoShare(){
        if self.info.role == "INSTITUTION" || self.info.role == "ROLE_INDIVIDUAL" {
            self.pageUrl = "http://www.wingmediadream.com/wingmedia_web/share/institutions.html?id="+self.info.id!
        }else{
            self.pageUrl = "http://www.wingmediadream.com/wingmedia_web/share/individuals.html?id="+self.info.id!
        }
//        switch self.invesPageType {
//        case .PersonPage:
//            self.pageUrl = "http://www.wingmediadream.com/wingmedia_web/share/individuals.html?id="+self.info.id!
//            break
//        case .InstituPage:
//            self.pageUrl = "http://www.wingmediadream.com/wingmedia_web/share/institutions.html?id="+self.info.id!
//            break
//        }
        
//        HTShareSDKTool.sharedShareSDKTool().shareForPlatOnWechat(self.pageUrl, withImage: "share_weibo", withTitle: "正在通过极客出发接收创业项目，快来提交吧！")
        
        self.shareTitleString = self.infoData.InvesName?.stringByAppendingString("正在通过极客出发接收创业项目，快来提交吧！")
        
        //if self.isClickShare == true {
            let shareAlertView:XSShareAlertView = XSShareAlertView.init(cancelBtn: { 
                print("取消")
                self.isClickShare = true
                }, withWechatBtn: {
                    self.isWithContent()
                    self.wechatAlertView()
                    self.isClickShare = true
                }, withMomentsBtn: {
                    self.momentAlertView()
                    self.isClickShare = true
            })
            self.view.window!.addSubview(shareAlertView)
            self.isClickShare = false
        //}
    }
    
    //MARK:---微信分享
    func wechatAlertView(){
//        let wechatView:XSWechatShareAlertView = XSWechatShareAlertView.init(cancelBtn: { 
//            print("取消")
//            }, withSureBtn: { (value:String?) in
                HTShareSDKTool.sharedShareSDKTool().shareForWechat(self.shareTitleString, withImage: self.shareImageString, withUrl: self.pageUrl, withContent:self.withContent)
//            }, withTitle: self.shareTitleString, withTitleImage: self.shareImageString, withContent: self.infoData.introduction)
//        self.view.window!.addSubview(wechatView)
    }
    func isWithContent(){
        if self.withContent == nil || self.withContent?.characters.count == 0 {
            self.withContent = "简介：无"
        }
    }
    //MARK:---朋友圈分享
    func momentAlertView(){
//        let momentView:XSMomentsShareAlertView = XSMomentsShareAlertView.init(cancelBtn: { 
//            print("取消")
//            }, withSureBtn: { 
                HTShareSDKTool.sharedShareSDKTool().shareForMoments(self.shareTitleString, withImage: self.shareImageString, withUrl: self.pageUrl)
//            }, withImageString: self.shareImageString, withTitle: self.shareTitleString)
//        self.view.window!.addSubview(momentView)
    }
    //MARK:---------------加载界面----------------
    func initTableView(){
        self.delegate = DSInvesDetailsTableViewDelegate()
        self.delegate.slidingBlock = {[weak self] in
            self?.initTitleBar()
            self?.addRightBtn()
            self?.scrollViewDidScroll((self?.myTableView)!)
        }
        self.dataSource = NSMutableArray()
        registerCell(self.myTableView, cell: DSInvesDetailsHeadCell.self)
        registerCell(self.myTableView, cell: DSInvesDetailsTitleCell.self)
        registerCell(self.myTableView, cell: DSInvesDetailsIntroduceCell.self)
        registerCell(self.myTableView, cell: DSInvesDetailsRelatedCell.self)
        registerCell(self.myTableView, cell: DSInvesDetailsCaseCell.self)
        registerCell(self.myTableView, cell: DSInvesCollectionFocusCell.self)
        registerCell(self.myTableView, cell: DSInvesDetailsPartnerCell.self)
        self.delegate.dataSource = self.dataSource
        self.myTableView.delegate = delegate
        self.myTableView.dataSource = delegate
        self.myTableView.backgroundColor = loginBg_Color
    }
    
    func initDataSource(){
        self.delegate.invesPageType = self.invesPageType
        initFirstSection()
        initSecondSection()
        initThirdSection()
        initFourthSection()
        if self.info.role != "INDIVIDUAL" || self.info.role != nil {
           initPartnerSection()
            self.delegate.invesPageType = InvesPageType.InstituPage
        }
        addFollowBtn()
        addCollectionBtn()
    }
    func initFistCell(){
        let arr = NSMutableArray()
        self.initFirstCell(arr, browseNum: "", InvesName: "", invesType: "", invesHeadImageUrl: "", heatNum: self.tihuanHot(self.followNum))
        self.dataSource .addObject(arr)
    }
    
    func initFirstSection(){
        let arr = NSMutableArray()
        if self.info.role != "INDIVIDUAL" {
             self.initFirstCell(arr, browseNum: self.infoData.InvesBrowse, InvesName: self.infoData.InvesName, invesType: "", invesHeadImageUrl: self.infoData.InvesHeadImageUrl, heatNum: self.tihuanHot(self.followNum))
        }else{
             self.initFirstCell(arr, browseNum: self.infoData.InvesBrowse, InvesName: self.infoData.InvesName, invesType: "个人投资者", invesHeadImageUrl: self.infoData.InvesHeadImageUrl, heatNum: self.tihuanHot(self.followNum))
        }
        self.dataSource .addObject(arr)
    }
    func tihuanHot(str:String?) -> (String?) {
        if str == nil {
            return "0"
        }else{
            return str
        }
    }
    func initFirstCell(arr:NSMutableArray,browseNum:String?,InvesName:String?,invesType:String?,invesHeadImageUrl:String?,heatNum:String?){
        let info = DSInvesDetailsHeadCellModel()
        info.className = "DSInvesDetailsHeadCell"
        info.BrowseNum = browseNum
        info.InvesName = InvesName
        info.InvesType = invesType
        if invesHeadImageUrl != nil {
            info.InvesHeadImageUrl = HTHttpConfig.sharedInstance().getServerAddress("").stringByAppendingFormat("/resource/view/"+invesHeadImageUrl!)
            self.shareImageString = info.InvesHeadImageUrl
        }
        info.HeatNum = heatNum
        arr .addObject(info)
    }
    func initSecondSection(){
        let arr = NSMutableArray()
        var info = DSInvesDetailsHeadCellModel()
        info.className = "DSInvesDetailsTitleCell"
        info.title = "简介"
        arr.addObject(info)
        info = DSInvesDetailsHeadCellModel()
        info.className = "DSInvesDetailsIntroduceCell"
        info.title = self.infoData.introduction
        info.isAn = self.isAn
        info.cellHeight = self.tihuanCellHeight(self.infoData.introduction)
        self.delegate.cellHeight = info.cellHeight
        info.guanBlock = { [weak self] (sender: AnyObject) in
            self!.isAn = true
            self!.delegate.introd = CGFloat(sender as! NSNumber)
            self!.myTableView .reloadData()
        }
        arr.addObject(info)
        self.dataSource.addObject(arr)
    }
    func tihuanCellHeight(str:String?) -> CGFloat{
        if str != nil && str?.characters.count != 0{
            let i = (str!.characters.count)/21+1
            if i < 4{
                return CGFloat(i*26)
            }else{
                return 125
            }
        }else{
            return 0
        }
    }
    
    func initThirdSection(){
        let arr = NSMutableArray()
        self.initCell(arr, cell: "DSInvesDetailsRelatedCell", title: self.infoData.Invesindustry, subTitle: "关注领域")
        self.initCell(arr, cell: "DSInvesDetailsRelatedCell", title: self.infoData.InvesPhase, subTitle: "投资阶段")
        self.initCell(arr, cell: "DSInvesDetailsRelatedCell", title: self.infoData.InvesLocation, subTitle: "投资地域")
        self.initCell(arr, cell: "DSInvesDetailsRelatedCell", title: self.infoData.InvesCurrency, subTitle: "投资币种")
        if self.infoData.investMax != nil && self.infoData.investMin != nil{
            self.infoData.InvesLines = self.infoData.investMin!+"万"+"-"+self.infoData.investMax!+"万"
        }
        self.initCell(arr, cell: "DSInvesDetailsRelatedCell", title: infoData.InvesLines, subTitle: "单笔可投")
        self.dataSource .addObject(arr)
    }
    func initFourthSection(){
        let arr = NSMutableArray()
        self.initCell(arr, cell: "DSInvesDetailsTitleCell", title: "过往案例", subTitle: "")
        if self.infoData.cases != nil {
            self.initCell(arr, cell: "DSInvesDetailsCaseCell", title: self.infoData.cases, subTitle: "")
            self.delegate.inCase = self.getInCase()
        }else{
            self.delegate.inCase = 0
        }
        self.dataSource .addObject(arr)
    }
    func getInCase() -> (CGFloat) {
        if self.infoData.cases!.characters.count == 0 {
            return 0
        }else{
            return CGFloat((self.infoData.cases!.characters.count)/21*26+26)
        }
    }
    
    func initPartnerSection(){
        let arr = NSMutableArray()
        let info = DSInvesDetailsHeadCellModel()
        info.className = "DSInvesDetailsTitleCell"
        info.title = "公司合伙人介绍"
        arr.addObject(info)
        if self.info.institution?.partners?.count != 0{
            for index in 0...(self.info.institution?.partners?.count)!-1 {
                let partners:DSGetPersonAccountPartnersInfo = self.info.institution?.partners![index] as! DSGetPersonAccountPartnersInfo
                //print(partners.name!)
                self.initPartnerCell(arr, cell: "DSInvesDetailsPartnerCell", headImage: partners.avatar, name: partners.name!, position: partners.position!, subTitle: partners.descriptions)
            }
            self.delegate.partner = 44
        }else{
            self.delegate.partner = 0
        }
        
        self.dataSource .addObject(arr)
    }
    
    
    func addCollectionBtn(){
        if self.isCollection != false {
            self.collectionMaxBtn.setImage(UIImage.init(named: "Hot_shoucang"), forState: .Normal)
        }else{
            self.collectionMaxBtn.setImage(UIImage.init(named: "Hot_ weishoucang"), forState: .Normal)
        }
    }
    func addFollowBtn() {
        if self.isFollow == false {
            self.followBtn.setBackgroundImage(UIImage.init(named: "Hot_yuetan"), forState: .Normal)
            self.followBtn.setTitle("求关注", forState: .Normal)
        }else{
            self.followBtn.setBackgroundImage(UIImage.init(named: "Hot_yishenqing"), forState: .Normal)
            self.followBtn.setTitle("已申请", forState: .Normal)
            self.followBtn.userInteractionEnabled = false
        }
    }
    
    //MARK:收藏方法
    @IBAction func collectionMaxAction(sender: UIButton) {
        
        switch  DSAccountInfo.sharedInstance().role {
        case nil:
            break
        //项目方，园区方
        case "PROVIDER","ROLE_PROVIDER","PARK_ADMIN":
            sender.selected = self.isCollection
            sender.selected = !sender.selected
            if sender.selected == true {
                httpCollectionsRequire()
            }else{
                httpCollectionDeleteRequire()
            }
            break
        default:
            SMToast(loadString("DSInvesNoComplete", tableId: DSINVESTORS))
            break
        }
        
    }
    
    
    //MARK:关注方法
    @IBAction func followBtn(sender: UIButton) {
        switch  DSAccountInfo.sharedInstance().role {
        case nil:
            break
        //项目方
        case "PROVIDER","ROLE_PROVIDER":
            if DSAccountInfo.sharedInstance().authorized == "0"{
                SMToast("请先申请认证")
            }else{
                self.guanzhu(sender)
            }
            break
        default:
            SMToast(loadString("DSInvesNoComplete", tableId: DSINVESTORS))
            break
        }
    }
    func guanzhu(sender:UIButton){
        sender.selected = self.isFollow
        sender.selected = !sender.selected
        if sender.selected == true {
            self.showSheet()
//            let alertController:UIAlertController = UIAlertController.init(title: nil, message: "确定要请求关注吗？\n注意：为了减少平台重复信息量，您每天只能发送10次请求，在10天内不能再对同一投资人发送", preferredStyle: .ActionSheet)
//            let OKAction:UIAlertAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Default, handler: { (alertController) in
//                self.httpRequestFollowRequire()
//            })
//            let cancelAction:UIAlertAction = UIAlertAction.init(title: "取消", style: .Cancel, handler: nil)
//            alertController.addAction(OKAction)
//            alertController.addAction(cancelAction)
//            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func showSheet(){
        let aa=SGActionSheet.init(title: "确定请求投资方关注？", content: "注意：为了减少平台重复信息量，您每天只能发送10次请求，在10天内不能再对同一投资人发送。", delegate: self, cancelButtonTitle: "取消", otherButtonTitleArray: ["确定"])
        aa.otherTitleColor=greenNavigationColor
        aa.otherTitleFont=UIFont.systemFontOfSize(17)
        aa.cancelButtonTitleFont=UIFont.systemFontOfSize(17)
        aa.cancelButtonTitleColor=UIColorFromRGB(0x666666)
        aa.show()
    }
   
    func SGActionSheetdidSelectRowAtIndexPath( indexPath: Int) {
          self.httpRequestFollowRequire()
    }

    
    
}
