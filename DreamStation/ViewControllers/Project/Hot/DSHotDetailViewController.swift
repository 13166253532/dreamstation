//
//  DSHotDetailViewController.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/28.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit
private let TITLESTRING_PROJECT:String = "DSProjectViewController"
class DSHotDetailViewController: HTBaseViewController ,UITextViewDelegate {

    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var collectionMaxBtn: UIButton!
    @IBOutlet weak var followBtn: UIButton!

    var listInfo:DSHttpCollectionsListInfo!
    ///是否收藏
    var isCollection = false
    ///是否约谈
    var isFollow = false

    var detailUrl:String?
    ///浏览量
    var readString:String?
    ///热度
    var hotString:String?
    
    /**收藏备注信息*/
    var collectionMessage:String?
    
    var dataSource:NSMutableArray!
    var delegate:DSHotDetailDelegate!
    var info:DSProductsDetailsInfo!
    var projectId:String!
    
    var firstCellInfo:DSFirstCellModel!
    var stageCellInfo:DSSecondCellModel=DSSecondCellModel()//融资阶段
    var placeCellInfo:DSSecondCellModel=DSSecondCellModel()//所在地区
    var moneyCellInfo:DSSecondCellModel=DSSecondCellModel()//融资金额
    var SHARECellInfo:DSSecondCellModel=DSSecondCellModel()//投后股比
    
    var perInfo:DSGetPersonAccountInfo!
    var isClickShare:Bool = true
   
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSHotDetailViewController", bundle: nil)
        let vc:DSHotDetailViewController=storyboard.instantiateViewControllerWithIdentifier("DSHotDetailViewController")as! DSHotDetailViewController
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTitleBar()
        self.projectAddRightBtn()
        self.scrollViewDidScroll(self.tableView)
        self.initTableView()
        getHttpProjectdetailsRequire()
        httpIsCollectionsRequire()
        self.initCollectionBtn()
        self.initFollowBtn()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.info = DSProductsDetailsInfo()
        self.delegate.slidingBlock = nil
        self.navigationController?.navigationBar.lt_reset()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //self.tableView.alpha = 0
    }
    func projectAddRightBtn(){
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.lt_setBackgroundColor(UIColor.clearColor())
        let rightBtn:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "homePage_fenxiang"), style: .Plain, target: self, action: #selector(shareOfClick))
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    //MARK:--------分享
    func shareOfClick(){
        self.detailUrl = "http://www.wingmediadream.com/wingmedia_web/share/project.html?id="+self.projectId!
//        HTShareSDKTool.sharedShareSDKTool().shareForPlatOnWechat(self.detailUrl, withImage: "share_weibo", withTitle: self.info.brief!)
        
        if self.isClickShare == true {
            let shareAlertView:XSShareAlertView = XSShareAlertView.init(cancelBtn: {
                    [weak self] in
                    print("取消")
                    self!.isClickShare = true
                }, withWechatBtn: {
                    [weak self] in
                    self!.wechatAlertView()
                    self!.isClickShare = true
                }, withMomentsBtn: {
                    [weak self] in
                    self!.momentAlertView()
                    self!.isClickShare = true
            })
            self.view.window!.addSubview(shareAlertView)
            //self.isClickShare = false
        }
        
    }
    
    //MARK:---微信分享
    func wechatAlertView(){
        
//        let wechatView:XSWechatShareAlertView = XSWechatShareAlertView.init(cancelBtn: { 
//            print("取消")
//            }, withSureBtn: { (value:String?) in
        
        HTShareSDKTool.sharedShareSDKTool().shareForWechat(self.info.brief, withImage: nil, withUrl: self.detailUrl, withContent: self.webchatString() as String)
       // HTShareSDKTool.sharedShareSDKTool().shareForWechat(self.info.brief, withImage: "homePage_share", withUrl: self.detailUrl, withContent: self.info.highLight)
//            }, withTitle: self.info.brief, withTitleImage: "homePage_share", withContent: self.info.highLight)
//        self.view.window!.addSubview(wechatView)
        
    }
    func webchatString()->(NSString){
        if self.info.highLight == nil || self.info.highLight?.characters.count == 0 {
            return "投资亮点：无"
        }else{
            return self.info.highLight! as NSString
        }
    }
    
    //MARK:---朋友圈分享
    func momentAlertView(){
//        let momentView:XSMomentsShareAlertView = XSMomentsShareAlertView.init(cancelBtn: { 
//            print("取消")
//            }, withSureBtn: { 
        HTShareSDKTool.sharedShareSDKTool().shareForMoments(self.info.brief, withImage: nil, withUrl: self.detailUrl)
//            }, withImageString: "homePage_share", withTitle: self.info.brief)
//        self.view.window!.addSubview(momentView)
    }
    
    func initTableView()  {
        self.dataSource = NSMutableArray()
        self.delegate = DSHotDetailDelegate()
        self.delegate.slidingBlock = {[weak self] in
            self?.initTitleBar()
            self?.projectAddRightBtn()
            self?.scrollViewDidScroll((self?.tableView)!)
        }
        self.dataSourceInit()
        registerCell(self.tableView, cell: DSFirstTableViewCell.self)
        registerCell(self.tableView, cell: DSSecondTableViewCell.self)
        registerCell(self.tableView, cell: DSThirdTableViewCell.self)
        registerCell(self.tableView, cell: DSFourthTableViewCell.self)
        registerCell(self.tableView, cell: DSFifthTableViewCell.self)
        registerCell(self.tableView, cell: DSFourthTitleTableViewCell.self)
        self.delegate.dataSource = self.dataSource
        self.tableView.delegate = self.delegate
        self.tableView.dataSource = self.delegate
        self.tableView.backgroundColor = loginBg_Color

    }
    
    func dataSourceInit(){
        let firstList:NSMutableArray = NSMutableArray()
        firstCellInfo = DSFirstCellModel()
        firstCellInfo.className = "DSFirstTableViewCell"
        firstCellInfo.titleValue = ""
        firstCellInfo.detailValue = ""
        firstCellInfo.readValue = ""
        firstCellInfo.hotValue = ""
        
        firstList.addObject(firstCellInfo)
        
        stageCellInfo=categoriesCellInit(firstList, title: "融资阶段", detailList: "", index: 0)
        firstList.addObject(stageCellInfo)
        placeCellInfo=categoriesCellInit(firstList, title: "所在地区", detailList: "", index: 1)
        firstList.addObject(placeCellInfo)
        moneyCellInfo=categoriesCellInit(firstList, title: "融资金额", detailList: "", index: 2)
        moneyCellInfo.currency = ""
        firstList.addObject(moneyCellInfo)
        SHARECellInfo=categoriesCellInit(firstList, title: "投后股比", detailList: "", index: 3)
        firstList.addObject(SHARECellInfo)
        
        self.dataSource.addObject(firstList)
    }
    
    //MARK:---------------加载界面------------------
    func updateTabeView(){
        self.initfirstSectionTableViewData()
        self.initSecondSectionTableViewData()
        self.initThirdSectionTableViewData()
    }
    
    func updateReadString(){
        firstCellInfo.readValue = self.tihuanNil(self.readString)
        tableView.reloadData()
    }
    
    func initfirstSectionTableViewData(){
        firstCellInfo.titleValue = self.tihuanNil(self.info.brief)
        firstCellInfo.detailValue = self.tihuanNil(self.info.industry)
        firstCellInfo.readValue = self.tihuanNil(self.readString)
        firstCellInfo.hotValue = self.tihuanHot(self.info.interviewNum) 
        stageCellInfo.detailValue = self.info.amountPhase
        placeCellInfo.detailValue = self.info.Inthearea
        moneyCellInfo.detailValue = self.info.amount
        moneyCellInfo.currency = self.info.currency
        SHARECellInfo.detailValue = self.info.ratio
        if self.info.depthRecommend == "是"||self.info.hasShow == "是" {
            let firstList=self.dataSource[0] as! NSMutableArray
            let thirdCellInfo = DSThirdCellModel()
            thirdCellInfo.className = "DSThirdTableViewCell"
            thirdCellInfo.IsDeep = self.info.depthRecommend
            thirdCellInfo.isShow = self.info.hasShow
            firstList.addObject(thirdCellInfo)
        }
    }
    func tihuanNil(str:String?) -> (String?) {
        if str == nil {
           return ""
        }else{
            return str
        }
    }
    
    func tihuanHot(str:String?) -> (String?) {
        if str == nil {
            return "0"
        }else{
            return str
        }
    }
    func tihuanMoney(str:String?) -> (String?) {
        if str == nil {
            return "nil万"
        }else{
            return str!+"万"
        }
    }
    func categoriesCellInit(arr:NSMutableArray,title:String?,detailList:String?,index:NSInteger)->DSSecondCellModel{
        let secondCellInfo = DSSecondCellModel()
        secondCellInfo.className = "DSSecondTableViewCell"
        secondCellInfo.titleValue = title
        secondCellInfo.detailValue = detailList
        secondCellInfo.num = index
        return secondCellInfo
    }
    func initSecondSectionTableViewData(){
        if self.info.highLight != nil && self.info.highLight?.characters.count != 0 {
            self.addSecondSectionTableViewCell("投资亮点", detailList: self.info.highLight, index: 0)
        }
        if self.info.market != nil && self.info.market?.characters.count != 0{
            self.addSecondSectionTableViewCell("行业及市场", detailList: self.info.market, index: 1)
        }
        if self.info.businessMode != nil && self.info.businessMode?.characters.count != 0{
            self.addSecondSectionTableViewCell("商业模式", detailList: self.info.businessMode, index: 2)
        }
        if self.info.advantages != nil && self.info.advantages?.characters.count != 0{
            self.addSecondSectionTableViewCell("产品或服务优势", detailList: self.info.advantages, index: 3)
        }
    }
    
    func addSecondSectionTableViewCell(title:String?,detailList:String?,index:NSInteger){
        let secondList:NSMutableArray = NSMutableArray()
        
        let fourthTitleInfo=DSFourthFirstCellModel()
        fourthTitleInfo.className="DSFourthTitleTableViewCell"
        fourthTitleInfo.titleValue = title
        
        let fourthCellInfo = DSFourthCellModel()
        fourthCellInfo.className = "DSFourthTableViewCell"
        fourthCellInfo.detailValue = detailList

        fourthCellInfo.block = {
            [weak self](value:AnyObject)->Void in
            self!.tableView.reloadData()
        }
        secondList.addObject(fourthTitleInfo)
        secondList.addObject(fourthCellInfo)
        self.dataSource.addObject(secondList)
    }
    func getCellHeight(str:String?) -> CGFloat {
        let i = (str!.characters.count)/21*26
        if i < 4{
            return CGFloat(i*26+100)
        }else{
            return 200
        }
    }
    func initThirdSectionTableViewData(){
        if self.info.businessPlan != nil && self.info.businessPlan?.characters.count != 0 {
            let thirdList:NSMutableArray = NSMutableArray()
            let fifthCellInfo = DSFifthTableViewCelModel()
            fifthCellInfo.className = "DSFifthTableViewCell"
            fifthCellInfo.block = {
                [weak self]in
                //print("商业计划书")
                let urlStr:String = HTHttpConfig.sharedInstance().getServerAddress("").stringByAppendingFormat("/resource/view/"+self!.info.businessPlan!)
                let url = NSURL(string: urlStr)
                UIApplication.sharedApplication().openURL(url!)
            }
            thirdList.addObject(fifthCellInfo)
            self.dataSource.addObject(thirdList)
        }
    }
    func initCollectionBtn(){
        if !self.isCollection {
            self.collectionMaxBtn.setImage(UIImage.init(named: "Hot_ weishoucang"), forState: .Normal)
        }else{
            self.collectionMaxBtn.setImage(UIImage.init(named: "Hot_shoucang"), forState: .Normal)
        }
    }
    func initFollowBtn(){
        if !self.isFollow {
            self.followBtn.setBackgroundImage(UIImage.init(named: "Hot_yuetan"), forState: .Normal)
            self.followBtn.setTitle("约谈", forState: .Normal)
        }else{
            
            //self.followBtn.adjustsImageWhenHighlighted = false
            self.followBtn.setBackgroundImage(UIImage.init(named: "Hot_yishenqing"), forState: .Normal)
            self.followBtn.setTitle("已申请", forState: .Normal)
            //self.followBtn.adjustsImageWhenDisabled = false
            self.followBtn.userInteractionEnabled = false
        }
    }
    //MARK:------实现收藏------
    @IBAction func collectionAction(sender: UIButton) {

    }
    
    @IBAction func collectionMaxAction(sender: UIButton) {
        
        switch  DSAccountInfo.sharedInstance().role {
        case nil:
            break
        //项目方，园区方
        case "PROVIDER","ROLE_PROVIDER":
            SMToast(loadString("DSProjectNoComplete", tableId: TITLESTRING_PROJECT))
            break
        default:
            sender.selected = self.isCollection
            sender.selected = !sender.selected
            if sender.selected == true {
                
                if (listInfo.msg != nil) {
                    var str = MDFStringHandle.stringTakeOutSpecialCharacter(listInfo.msg) as String!
                    let str2 = "已经收藏该项目\n您还要继续收藏吗？"
                    str = str + str2
//                    SMAlertView.showAlert(str, title: "", cancleTitle: "取消", okTitle: "继续", delegate: self)
                    showAlert(str, message: "", titleCancelBtn: "取消", titleSecondBtn: "确定", blockOtherBtn: { [weak self]in
                        self!.collectionViewShow()
                    })
                    
                }else{
                    self.collectionViewShow()
                }
            }else{
                self.collectionMaxBtn.setImage(UIImage.init(named: "Hot_ weishoucang"), forState: .Normal)
                httpCollectionDeleteRequire()
            }
            break
        }
    }
    //MARK:------实现约谈------
    @IBAction func chatAction(sender: UIButton) {
        
        switch  DSAccountInfo.sharedInstance().role {
        case nil:
            break
        //项目方，园区方
        case "PROVIDER","ROLE_PROVIDER","PARK_ADMIN":
            SMToast(loadString("DSProjectNoComplete", tableId: TITLESTRING_PROJECT))
            break
        default:
            sender.selected = self.isFollow
            sender.selected = !sender.selected
            if sender.selected == true {
                addFollowView()
                //self.tanchuYueTan()
            }
            break
        }
    }
    func tanchuYueTan(){
        let alertController:UIAlertController = UIAlertController.init(title: nil, message: "确定要发起约谈吗？", preferredStyle: .ActionSheet)
        let OKAction:UIAlertAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Default, handler: { (alertController) in
            self.httpPersonAccountRequire()
            
        })
        let cancelAction:UIAlertAction = UIAlertAction.init(title: "取消", style: .Cancel, handler: nil)
        alertController.addAction(OKAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
        
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY : CGFloat = scrollView.contentOffset.y
        if offsetY > 100{
            let alpha = min(1, 1 - ((100 + 64 - offsetY) / 64));
            self.navigationController!.navigationBar.lt_setBackgroundColor(greenNavigationColor.colorWithAlphaComponent(alpha))
        }else {
            self.navigationController!.navigationBar.lt_setBackgroundColor(greenNavigationColor.colorWithAlphaComponent(0))
        }
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class DSHotDetailDelegate: HTBaseTableViewDelegate{
    var slidingBlock:selectBlock!
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.slidingBlock()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section==0&&indexPath.row==0{
            return 210
        }else{
            if indexPath.section>0&&indexPath.row>0{
                let ary =  self.dataSource[indexPath.section] as!NSMutableArray
                
                let info = ary.objectAtIndex(indexPath.row) as! DSFourthCellModel
                
                let rect=getSizeFromString(info.detailValue)
                
                if info.isOpen==true{
                    return rect.height+40+1//大于四行
                }else{
                    
                    if rect.height<94{
                        return rect.height+20+1//四行以内
                    }else{
                        return 94+40+1//最多四行
                    }
                }

            }else{
                return 44
            }
        }
    }
    
    override  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section==0){
            return 0
        }
        return 0
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == self.dataSource.count {
            return 15
        }
        return 10
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
          tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    private func getSizeFromString(str:String)->CGRect{
        let par = NSMutableParagraphStyle.init()
        par.lineSpacing = 9
        
        let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(14),NSParagraphStyleAttributeName:par]
        
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        
        let rect:CGRect = str.boundingRectWithSize(CGSizeMake(SCREEN_WHIDTH()-30, 1000), options: option, attributes: attributes, context: nil)
        return rect
    }
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor=UIColor.clearColor()
    }

}

