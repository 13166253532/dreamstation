//
//  DSParkDetailsVC.swift
//  DreamStation
//
//  Created by xjb on 16/9/18.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit
private let DSPARKDETAILS:String="DSParkDetails"

class DSParkDetailsVC: HTBaseViewController {

    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var collectionBtn: UIButton!
    @IBOutlet var collectionMaxBtn: UIButton!
    
    @IBOutlet weak var playBtn: UIButton!
    /// 是否申请
    var isPlay = false
    /// 是否收藏
    var isCollection = false
    
    var isAn = false
    
    var details:CGFloat!
    var inCase:CGFloat!
    var shareUrl:String?
    var parkId:String!
    var cityArray = NSMutableArray()
    var detailUrl:String?
    
    var info:DSGetPersonAccountInfo!
    var isClickShare:Bool = true
    
    var delegate:DSParkDetailsTableViewDelegate!
    var dataSource = NSMutableArray()
    
    var parkLogoImage:String?
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSParkDetailsVC", bundle: nil)
        let vc:DSParkDetailsVC=storyboard.instantiateViewControllerWithIdentifier("DSParkDetailsVC")as! DSParkDetailsVC
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableview()
        self.initTableView2()
        httpGetParkDetailsRequire()
        initTitleBar()
        addParkRightBtn()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    func addParkRightBtn(){
        self.title=loadString("DSParkDetailsTitle", tableId: TITLESTRINGTABLEID)
        
        let rightBtn:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "Park_share"), style: .Plain, target: self, action: #selector(self.GoShare))
        self.navigationItem.rightBarButtonItem = rightBtn

    }
    
    //MARK:分享
    func GoShare(){
        self.detailUrl = "http://www.wingmediadream.com/wingmedia_web/share/park.html?id="+self.parkId!
//        HTShareSDKTool.sharedShareSDKTool().shareForPlatOnWechat(self.detailUrl, withImage: "share_weibo", withTitle: self.info.park?.parkName!)
        
       // if self.isClickShare == true {
            let shareAlertView:XSShareAlertView = XSShareAlertView.init(cancelBtn: { 
                print("取消")
                self.isClickShare = true
                }, withWechatBtn: { 
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
                HTShareSDKTool.sharedShareSDKTool().shareForWechat(self.info.park?.parkName, withImage: self.parkLogoImage, withUrl: self.detailUrl,withContent: self.wechatString() as String)
//            }, withTitle: self.info.park?.parkName, withTitleImage: self.parkLogoImage, withContent: self.info.park?.incubationCase)
//        self.view.window!.addSubview(wechatView)
    }
    func wechatString() -> (NSString) {
        if self.info.park?.incubationCase == nil || self.info.park?.incubationCase?.characters.count == 0 {
            return "孵化案例：无"
        }else{
            return (self.info.park?.incubationCase)! as NSString
        }
    }

    //MARK:---朋友圈分享
    func momentAlertView(){
//        let momentView:XSMomentsShareAlertView = XSMomentsShareAlertView.init(cancelBtn: {
//            print("取消")
//            }, withSureBtn: { 
                HTShareSDKTool.sharedShareSDKTool().shareForMoments(self.info.park?.parkName, withImage: self.parkLogoImage, withUrl: self.detailUrl)
//            }, withImageString: self.parkLogoImage, withTitle: self.info.park?.parkName)
//        self.view.window!.addSubview(momentView)
    }
    
    func initTableView2() {
        let arr = NSMutableArray()
        let info = DSParkDetailsCellModel()
        info.className = "DSParkHeadCell"
        info.image = ""
        self.parkLogoImage = ""
        info.title = ""
        info.subTitle = ""
        arr.addObject(info)
        let info1 = DSParkDetailsCellModel()
        info1.className = "DSParkMoneyCell"
        info1.title = self.tihuan("", str: "收费")
        info1.subTitle = self.tihuan("", str: "提供")
        arr.addObject(info1)
        self.dataSource .addObject(arr)
    }
    
    
    //MARK:创建TableView
    func initTableview(){
        self.dataSource = NSMutableArray()
        self.delegate = DSParkDetailsTableViewDelegate()
        registerCell(self.myTableView, cell:DSParkHeadCell.self)
        registerCell(self.myTableView, cell:DSParkMoneyCell.self)
        registerCell(self.myTableView, cell:DSParkDetailedAddressCell.self)
        registerCell(self.myTableView, cell:DSParkAddressConditionsCell.self)
        registerCell(self.myTableView, cell:DSParkDetailsTitleCell.self)
        registerCell(self.myTableView, cell:DSParkDetailsImageCell.self)
        registerCell(self.myTableView, cell:DSParkDetailsIntroduceCell.self)
        registerCell(self.myTableView, cell:DSParkCaseIntroduceCell.self)
        registerCell(self.myTableView, cell:DSParkApplyCollectionCell.self)
        self.delegate.dataSource = self.dataSource
        self.myTableView.delegate = self.delegate
        self.myTableView.dataSource = self.delegate
    }
    func initDataSource(){
        initFirstSection()
        initSecondSection()
        initThirdSection()
        initFourth()
    }
    func initFirstSection(){
        let arr = NSMutableArray()
        let info = DSParkDetailsCellModel()
        info.className = "DSParkHeadCell"
        info.image = self.imageTihuan(self.info.park?.parkLogo)
        self.parkLogoImage = info.image
        info.title = self.info.park?.parkName
        info.subTitle = self.info.park?.briefIntroduction
        arr.addObject(info)
        let info1 = DSParkDetailsCellModel()
        info1.className = "DSParkMoneyCell"
        info1.title = self.tihuan(self.info.park?.officeRent, str: "收费")
        info1.subTitle = self.tihuan(self.info.park?.investService, str: "提供")
        arr.addObject(info1)
        
        let info2 = DSParkDetailsCellModel()
        info2.className = "DSParkDetailedAddressCell"
        arr.addObject(info2)
        
        let list:NSMutableArray = (self.info.park?.detailAddress)!
        for index in 0..<list.count {
            let addressInfo:DSParkListDetailAddressinfo = list[index] as! DSParkListDetailAddressinfo
            let info3 = DSParkDetailsCellModel()
            info3.className = "DSParkAddressConditionsCell"
            info3.title = self.tihuanAddress(addressInfo)
            arr.addObject(info3)
        }
        self.dataSource .addObject(arr)
    }
    func tihuanAddress(info:DSParkListDetailAddressinfo) -> (String) {
        var str = String()
        if info.city != nil  {
            str = info.city!
        }else{
            str = "nil"
        }
        self.cityArray .addObject(str)
        if info.detailAddress != nil {
            str = str+" "+info.detailAddress!
        }else{
            str = str+" nil"
        }
        return str
    }
    
    
    func tihuan(httpStr:String?,str:String) -> (String) {
        if httpStr == "1" {
            return str
        }else{
            return "不"+str
        }
    }
    
    
    func initSecondSection(){
        let arr = NSMutableArray()
        self.initParkCell(arr, cell: "DSParkDetailsTitleCell", title: "介绍", subTitle: "", image: nil)
        
        var info = DSParkDetailsCellModel()
        let list:NSMutableArray = self.imageArray(self.info.park?.introducePic)!
        info.className = "DSParkDetailsImageCell"
        if list.count != 0 {
            info.image = list[0] as? String
            info.subTitle = String(list.count)+"图"
        }
        info.imageBlock = {[weak self] in
            if list.count != 0 {
                let index:NSInteger = 0
                SNPhotoBrowserTool.showPhotoBrowser(index,originData: list as NSArray as [AnyObject], containerVC: self)
            }
        }
        arr .addObject(info)
        info = DSParkDetailsCellModel()
        info.className = "DSParkDetailsIntroduceCell"
        info.title = self.info.park?.introductionText
        info.cellHeight = self.getDetailsIntroduceCellHeigt(self.info.park?.introductionText)
        info.isAn = self.isAn
        info.anBlock = { [weak self] (str:AnyObject)->()in
            self?.delegate.details = CGFloat(str as! NSNumber)
            self?.myTableView.reloadData()
        }
        arr .addObject(info)
        self.dataSource .addObject(arr)
    }
    func getDetailsIntroduceCellHeigt(str:String?)->(CGFloat){
        if str != nil && str?.characters.count != 0{
            let i = (str!.characters.count)/21+1
            if i < 4{
                return CGFloat(i*26)
            }else{
                return 148
            }
        }else{
            return 0
        }
    }
    
    func initThirdSection(){
        let arr = NSMutableArray()
        self.initParkCell(arr, cell: "DSParkDetailsTitleCell", title: "孵化案例", subTitle: "", image: nil)
        let info = DSParkDetailsCellModel()
        info.className = "DSParkCaseIntroduceCell"
        info.title = self.info.park?.incubationCase
        self.inCase = CGFloat((self.info.park?.incubationCase!.characters.count)!/24*26+26)
        self.delegate.inCase = self.inCase
        arr.addObject(info)
        self.dataSource .addObject(arr)
    }
    
    func initFourth(){
        let arr = NSMutableArray()
        self.initParkCell(arr, cell: "DSParkDetailsTitleCell", title: "入园条件", subTitle: "", image: nil)
        self.initParkCell(arr, cell: "DSParkCaseIntroduceCell", title: self.info.park?.joinCondition, subTitle: "", image: nil)
        self.dataSource .addObject(arr)
    }
    func addCollectionBtn(){
        if self.isCollection != false {
            self.collectionBtn.setBackgroundImage(UIImage.init(named: "Hot_shoucang"), forState: .Normal)
        }else{
            self.collectionBtn.setBackgroundImage(UIImage.init(named: "Hot_ weishoucang"), forState: .Normal)
        }
    }
    func addPlayBtn() {
        
        if self.isPlay == false {
            self.playBtn.setBackgroundImage(UIImage.init(named: "Hot_yuetan"), forState: .Normal)
            self.playBtn.setTitle("申请入驻", forState: .Normal)
        }else{
            self.playBtn.setBackgroundImage(UIImage.init(named: "Hot_yishenqing"), forState: .Normal)
            self.playBtn.setTitle("已申请", forState: .Normal)
            self.playBtn.adjustsImageWhenDisabled = false
            self.playBtn.userInteractionEnabled = false
        }
    }

     //MARK:实现收藏
    @IBAction func collectionBtn(sender: UIButton) {

    }
    
    @IBAction func collectionMaxAction(sender: UIButton) {
        
        switch  DSAccountInfo.sharedInstance().role {
        case nil:
            break
        //园区方
        case "PARK_ADMIN":
            SMToast(loadString("DSParkNoComplete", tableId: DSPARKDETAILS))
            break
        default:
            sender.selected = self.isCollection
            sender.selected = !sender.selected
            if sender.selected == true {
                httpParkCollectionsRequire()
            }else{
                httpParkCollectionDeleteRequire()
            }
            break
        }
        
        
    }
    
    
    
  //MARK:实现申请入驻
    @IBAction func palyBtn(sender: UIButton) {
        switch  DSAccountInfo.sharedInstance().role {
        case nil:
            break
        //项目方
        case "PROVIDER","ROLE_PROVIDER":
            if DSAccountInfo.sharedInstance().authorized == "0"{
                SMToast("请先申请认证")
            }else{
                self.play(sender)
            }
            break
        default:
            SMToast(loadString("DSParkNoComplete", tableId: DSPARKDETAILS))
            break
            
        }
    }
    func play(sender:UIButton){
        sender.selected = self.isPlay
        sender.selected = !sender.selected
        if sender.selected == true {
            addPlayView()
//            let alertController:UIAlertController = UIAlertController.init(title: nil, message: "确定要申请入驻园区吗？", preferredStyle: .ActionSheet)
//            let OKAction:UIAlertAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Default, handler: { (alertController) in
//                self.httpApplyParkRequire()
//            })
//            let cancelAction:UIAlertAction = UIAlertAction.init(title: "取消", style: .Cancel, handler: nil)
//            alertController.addAction(OKAction)
//            alertController.addAction(cancelAction)
//            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }


    func initParkCell(arr:NSMutableArray,cell:String,title:String?,subTitle:String?,image:String?){
        let info = DSParkDetailsCellModel()
        info.className = cell
        if image != nil {
            info.image = HTHttpConfig.sharedInstance().getServerAddress("").stringByAppendingFormat("/resource/view/"+image!)
        }
        info.title = title
        info.subTitle = subTitle
        arr.addObject(info)
    }
    
    func initParkDetailsIntroduceCell(arr:NSMutableArray,cell:String,title:String?,subTitle:String?,image:String?,isan:Bool,block:passParameterBlock){
        let info = DSParkDetailsCellModel()
        info.isAn = isAn
        info.className = cell
        if image != nil {
            info.image = HTHttpConfig.sharedInstance().getServerAddress("").stringByAppendingFormat("/resource/view/"+image!)
        }
        info.title = title
        info.subTitle = subTitle
        info.anBlock = block
        arr.addObject(info)
    }
    //MARK:讲图片数据拼接为图片url数组
    func imageTihuan(httpImage:String?) -> (String?) {
        if self.isIncludeChineseIn(httpImage!) != true && httpImage != nil{
            let imageUrl = HTHttpConfig.sharedInstance().getServerAddress("").stringByAppendingFormat("/resource/view/"+httpImage!)
            return imageUrl
        }else{
            return nil
        }
    }
    //MARK:是否有汉字
    func isIncludeChineseIn(string: String) -> Bool {
        for (_, value) in string.characters.enumerate() {
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }
    
    func imageArray(httpStr:String?)->(NSMutableArray?){
        let list = NSMutableArray()
        if httpStr != nil {
            if self.isIncludeChineseIn(httpStr!) != true {
                let imageArray = httpStr!.componentsSeparatedByString(";")
                for index in 0..<imageArray.count {
                    let imageUrl = HTHttpConfig.sharedInstance().getServerAddress("").stringByAppendingFormat("/resource/view/"+imageArray[index])
                    print(imageUrl)
                    list .addObject(imageUrl)
                }
                return list
            }
        }
        return list
    }


}
