//
//  DSScreeningViewController.swift
//  DreamStation
//
//  Created by xjb on 16/8/2.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit
/**
 区分界面
 
 - ProjectPage:   项目
 - InvestorsPage: 投资方
 */
enum PageType: Int{
    case ProjectPage = 1
    case InvestorsPage = 2
}


class DSScreeningViewController: HTBaseViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var resetBtn: UIButton!
    
    let wide = UIScreen.mainScreen().bounds.width-30
    var delegate:DSScreeningTableViewDelegate!
    var dataSource:NSMutableArray!
    var isProject:Bool!
    
    var pageType:PageType = PageType.ProjectPage
    var invesPageType:InvesPageType = .PersonPage
    
    var returnBtn:DSSecreenReturnBtn!
    var returnBlock:selectBlock!
    
    var moneyMin:String?
    var moneyMax:String?
    
    var newMoneyMin:String?
    var newMoneyMax:String?
    
    var isAn = true
    
    
    //
    var moneyMinTosee:String?
    var moneyMaxTosee:String?
    
    var normalArray = NSMutableArray()
    var currencyArray = NSMutableArray()
    var moneyArray = NSMutableArray()
    var industryArray = NSMutableArray()
    var phaseArray = NSMutableArray()
    var cityArray = NSMutableArray()
    
    var newNormalArray = NSMutableArray()
    var newCurrencyArray = NSMutableArray()
    var newMoneyArray = NSMutableArray()
    var newIndustryArray = NSMutableArray()
    var newPhaseArray = NSMutableArray()
    var newCityArray = NSMutableArray()
    
    var resetBool:Bool!
    var parameterBlock:passParameterBlock!
    var block:passParameterBlock!
    var shaixuanBlock:selectBlock!
    //是否点击了重置按钮
    var isResetBool:Bool!
    
    
    var cityInfo:DSScreeningCellModel!
    var shaixuanArray = NSMutableArray()
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSScreeningViewController", bundle: nil)
        let vc:DSScreeningViewController=storyboard.instantiateViewControllerWithIdentifier("DSScreeningViewController")as! DSScreeningViewController
        vc.createArgs=createArgs
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.resetBool = false
        self.isResetBool = false
        self.resetBtn.layer.borderWidth=1
        self.resetBtn.layer.borderColor=UIColorFromRGB(0xe3e5e9).CGColor
        self.initTableView()
        
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
        self.isAn = false
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //self.tabBarController!.tabBar.transform = CGAffineTransformMakeTranslation(0, 49)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.isAn = false
        cityInfo.needUpdate=true
        if self.isResetBool == true {
            self.isResetBool = false
            self.newOldArray()
            self.saveTheCities(self.cityArray)
        }
        //离开界面，再返回时保存确定时的 筛选
        self.initTableView()
        //self.myTableView.reloadData()
        self.tabBarController?.tabBar.hidden=false
       // self.tabBarController!.tabBar.transform = CGAffineTransformMakeTranslation(0, 0)
       // self.returnBlock()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   

 
    func initTableView(){
        self.delegate = DSScreeningTableViewDelegate()
        self.dataSource=NSMutableArray()
        initDataSource()
        self.delegate.dataSource = self.dataSource
        self.myTableView.delegate = self.delegate
        self.myTableView.dataSource = self.delegate
        self.isAn = true
        registerCell(self.myTableView, cell: DSScreeningPartialCell.self)
        registerCell(self.myTableView, cell: DSSecreenNormalTableViewCell.self)
        registerCell(self.myTableView, cell: DSSecreenCurrencyTableViewCell.self)
        registerCell(self.myTableView, cell: DSSecreenIndustryTableViewCell.self)
        registerCell(self.myTableView, cell: DSSecreenPhaseTableViewCell.self)
        registerCell(self.myTableView, cell: DSSecreenMoneyTableViewCell.self)
        registerCell(self.myTableView, cell: DSSecreenCityTableViewCell.self)
    }
    //MARK:---------获取投资方投资偏好-------
    func httpGetPersonAccountRequire(){
        let cmd:HttpCommand=DSHttpGetPersonAccountCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock={[weak self](result:RequestResult!,useInfo:AnyObject!)->() in
            self?.httpGetPersonAccountResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        //if DSAccountInfo.sharedInstance().role == "INSTITUTIONER" {
            //dic[kHttpParamKey_GetPersonAccount_person_id] = DSAccountInfo.sharedInstance().institutionId
        //}else{
            dic[kHttpParamKey_GetPersonAccount_person_id] = DSAccountInfo.sharedInstance().personId
        //}
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    func httpGetPersonAccountResponse(result:RequestResult){
        let r:DSHttpGetPersonAccountResult = result as! DSHttpGetPersonAccountResult
        if result.isOk() {
            self.getGetPersonAccountData(r.getAllData())
        }
    }
    func getGetPersonAccountData(arr:NSMutableArray){
         let info = arr.lastObject as! DSGetPersonAccountInfo
        var list:NSMutableArray?
        if info.role == "INSTITUTION" {
            list = info.institution!.cats!
            self.moneyMaxTosee = info.institution?.investMax
            self.moneyMinTosee = info.institution?.investMin
        }else if info.role == "INSTITUTIONER"{
            list = info.institutioner?.cats!
            self.moneyMaxTosee = info.institutioner?.investorMax
            self.moneyMinTosee = info.institutioner?.investorMin
        }else{
            list = info.individual!.cats!
            self.moneyMinTosee = info.individual?.investMin
            self.moneyMaxTosee = info.individual?.investMax
        }
        
        let indeustry = NSMutableArray()
        let city = NSMutableArray()
        let currency = NSMutableArray()
        let phase = NSMutableArray()
        let normal = NSMutableArray()
        let money = NSMutableArray()
        for index in 0..<list!.count {
            let cats:DSGetPersonAccountCatsInfo = list![index] as! DSGetPersonAccountCatsInfo
            if cats.catName == "关注领域" {
               indeustry .addObject(cats.descriptions!)
            }else if cats.catName == "投资阶段" {
               phase .addObject(cats.descriptions!)
            }else if cats.catName == "投资地域"{
               city .addObject(cats.descriptions!)
            }else if cats.catName == "主投币种"{
               //self.currencyArray .addObject(cats.descriptions!)
                currency .addObject(cats.descriptions!)
            }
        }
        let dic = NSMutableDictionary()
        dic["类型"]=normal
        dic["关注领域"]=indeustry
        dic["投资地域"]=city
        dic["投资币种"]=currency
        dic["融资金额"]=money
        dic["融资阶段"]=phase
        dic["最小金额"]=self.moneyMinTosee
        dic["最大金额"]=self.moneyMaxTosee
        
        self.shaixuanBlock = {[weak self] in
            self?.industryArray = indeustry
            self?.phaseArray = phase
            self?.cityArray = city
            self?.currencyArray = currency
            self?.normalArray = normal
            self?.moneyMax = self?.moneyMaxTosee
            self?.moneyMin = self?.moneyMinTosee
        }
        
        if normal.count != 0 || indeustry.count != 0 || city.count != 0 || currency.count != 0 || self.moneyMinTosee != nil || phase.count != 0 {
           self.shaixuanArray .addObject(dic)
        }
    }
    func initDataSource(){
        switch self.pageType {
            case .ProjectPage:
                self.delegate.pageType = .ProjectPage
                self.shaixuanProject()
                break
            case .InvestorsPage:
                self.delegate.pageType = .InvestorsPage
                break
        }
        self.initCurrencyRow()
        self.initMoneyRow()
        self.initIndustryRow()
        self.initStageRow()
        self.initCityRow()
        self.myTableView.alpha = 1
    }
    func shaixuanProject(){
        if DSAccountInfo.sharedInstance().authorized == "1" {
           self.shanixuanRol()
        }else{
            self.delegate.firstHeigh = 0
        }
        self.initFirstRow()
        self.initSecondRow()
    }
    func shanixuanRol(){
        switch DSAccountInfo.sharedInstance().role  {
        case "PROVIDER","ROLE_PROVIDER","PARK_ADMIN":
            self.delegate.firstHeigh = 0
            break
        default:
            self.httpGetPersonAccountRequire()
            self.delegate.firstHeigh = 30
            break
        }
    }
    func initFirstRow(){
        let info = DSScreeningCellModel()
        info.className = "DSScreeningPartialCell"
        info.blocks = {[weak self] in
         self?.DataStorage()
         self?.initNewArray()
         self?.initOldArray()
         self?.shaixuanBlock()
         self!.parameterBlock((self?.shaixuanArray)!)
         self!.chuanzhi()
        }
       self.dataSource .addObject(info)
    }
    func initSecondRow(){
        let info = DSScreeningCellModel()
        info.optionsDataArry = NSMutableArray()
        info.shaixuanArray = self.normalArray
        info.optionsDataArry = ["深度推荐","有商业计划书","上过节目"]
        //print(self.tiHaun(self.normalArray).count)
        
        info.sizeMake = CGSizeMake((self.wide-30)/3, 30)
        info.resetBool = self.resetBool
        info.arrayBlock = {[weak self](str:AnyObject)->()in
            self?.newNormalArray = NSMutableArray()
            self?.newNormalArray = str as! NSMutableArray
        }
        info.className = "DSSecreenNormalTableViewCell"
        self.dataSource .addObject(info)
    }
    func initCurrencyRow(){
        let info = DSScreeningCellModel()
        info.optionsDataArry = NSMutableArray()
        info.shaixuanArray = self.currencyArray
        if self.pageType == .InvestorsPage {
            info.title = "主投币种"
        }else{
            info.title = "币种"
        }
        info.isAn = self.isAn
        info.resetBool = self.resetBool
        info.sizeMake = CGSizeMake((self.wide-30)/3, 30)
        info.arrayBlock = {[weak self](str:AnyObject)->()in
//            self?.currencyArray = NSMutableArray()
//            self?.currencyArray = str as! NSMutableArray
            self?.newCurrencyArray = NSMutableArray()
            self?.newCurrencyArray = str as! NSMutableArray
        }
        info.optionsDataArry = ["人民币","美元"]
        info.className = "DSSecreenCurrencyTableViewCell"
        self.dataSource .addObject(info)
    }
    func initMoneyRow(){
        let info = DSScreeningCellModel()
        info.optionsDataArry = NSMutableArray()
        info.title = self.moneyTitle()
        info.smallTitle = self.tihuanMoney(self.moneyMin)
        info.bigTitle = self.tihuanMoney(self.moneyMax)
        info.blocks = { [weak self] in
//            if self!.currencyArray.count == 0 {
//                SMToast("先选择币种！")
//            }else{x
                let pick:CCPPickerViewTwo = CCPPickerViewTwo.init(pickerViewWithCenterTitle: self!.moneyTitle(), andCancel: "取消", andSure: "确定")
                pick .pickerVIewClickCancelBtnBlock({
                    }, sureBtClcik: {[weak self](firstString, secondString, statusString) in
                        info.smallTitle = firstString
                        info.bigTitle = secondString
                        self?.newMoneyMin = firstString
                        self?.newMoneyMax = secondString
                        self?.newMoneyArray = NSMutableArray()
                        self?.newMoneyArray .addObject(firstString)
                        self?.newMoneyArray .addObject(secondString)
                        self!.myTableView.reloadData()
                    })
            }
//            }
        info.className = "DSSecreenMoneyTableViewCell"
        self.dataSource .addObject(info)
    }
    func moneyTitle() -> (String) {
        if self.pageType == .InvestorsPage {
            return "单笔可投额度（万）"
        }else{
            return "融资金额（万）"
        }
    }
    func tihuanMoney(str:String?) -> (String?) {
        if str != nil {
            return str
        }else{
            return nil
        }
    }
    func initIndustryRow(){
        let info = DSScreeningCellModel()
        info.optionsDataArry = NSMutableArray()
        info.shaixuanArray = self.industryArray
        if self.pageType == .InvestorsPage {
            info.title = "关注领域"
        }else{
            info.title = "所属行业"
        }
        info.isAn = self.isAn
        info.resetBool = self.resetBool
        info.sizeMake = CGSizeMake((self.wide-45)/4, 30)
        info.arrayBlock = {[weak self](str:AnyObject)->()in
            self?.newIndustryArray = NSMutableArray()
            self?.newIndustryArray = str as! NSMutableArray
        }
        info.isAnBlock = {
            [weak self](str:AnyObject)->()in
            self?.delegate.industryHeigh = CGFloat(str as! NSNumber)
            self?.myTableView .reloadData()
        }
        let list:NSMutableArray = self.inPlistData("DSScreeningIndustry.plist")
        info.optionsDataArry = list
        info.className = "DSSecreenIndustryTableViewCell"
        self.dataSource .addObject(info)
    }
    func initStageRow(){
        let info = DSScreeningCellModel()
        info.optionsDataArry = NSMutableArray()
        info.shaixuanArray = self.phaseArray
        if self.pageType == .InvestorsPage {
            info.title = "投资阶段"
        }else{
            info.title = "融资阶段"
        }
        info.isAn = self.isAn
        info.resetBool = self.resetBool
        info.sizeMake = CGSizeMake((self.wide-30)/3, 40)
        info.arrayBlock = {[weak self](str:AnyObject)->()in
            self?.newPhaseArray = NSMutableArray()
            self?.newPhaseArray = str as! NSMutableArray
        }
        info.isAnBlock = {
            [weak self](str:AnyObject)->()in
            self?.delegate.stageHeigh = CGFloat(str as! NSNumber)
            self?.myTableView .reloadData()
        }
        let list:NSMutableArray = self.inPlistData("DSScreeningPhase.plist")
        info.optionsDataArry = list
        info.className = "DSSecreenPhaseTableViewCell"
        self.dataSource .addObject(info)
    }
    func initCityRow(){
        cityInfo = DSScreeningCellModel()
        if self.pageType == .InvestorsPage {
            cityInfo.title = "投资地域"
            cityInfo.defaultKey=DEFAULTPROJECTCITYARRAYKEY
        }else{
            cityInfo.title = "所在地区"
            cityInfo.defaultKey=DEFAULTCITYARRAYKEY
        }
        cityInfo.sizeMake = CGSizeMake((self.wide-45)/4, 29)
        cityInfo.arrayBlock = {[weak self](str:AnyObject)->()in
            self?.newCityArray = NSMutableArray()
            self?.newCityArray = str as! NSMutableArray
        }
        cityInfo.isAnBlock = {
            [weak self](str:AnyObject)->()in
            self?.delegate.cityHeigh = CGFloat(str as! NSNumber)
            self?.myTableView .reloadData()
        }
        cityInfo.className = "DSSecreenCityTableViewCell"
        cityInfo.needUpdate=true
        self.dataSource .addObject(cityInfo)
    }
    func tiHaun(arr1:NSMutableArray) ->(NSMutableArray){
        if arr1.count == 0 {
            let arr = NSMutableArray()
            return arr
        }else{
            return arr1
        }
    }
    func inPlistData(plistString:String)->(NSMutableArray){
        let string:String = NSBundle.mainBundle().pathForResource(plistString, ofType: nil)!
        let plistArray:NSMutableArray = NSMutableArray.init(contentsOfFile: string)!
        return plistArray
    }
    @IBAction func resetAction(sender: AnyObject) {
        //self.parameterBlock(NSMutableArray())
        self.isResetBool = true
        self.resetTableView()
    }
    func resetTableView() {
        self.oldNewArray()
        self.initOldArray()
        self.betweenResetDefaultData()
        self.resetBool = !self.resetBool
        self.cityInfo.needUpdate=true
        self.isAn = false
        self.initTableView()
        self.myTableView.reloadData()
    }
    @IBAction func determineAction(sender: AnyObject) {
        if self.isResetBool == true {
            self.isResetBool = false
            self.initNewArray()
            self.initOldArray()
        }
        self.goScreening()
    }
    //MARK:实现筛选
    func goScreening(){
        self.DataStorage()
        self.newOldArray()
        if judgeCurrencyArray() == false {
            return
        }
        self.saveTheCities(self.cityArray)
        self.checkoutArray()
        let arr = NSMutableArray()
        if self.normalArray.count != 0 || self.industryArray.count != 0 || self.cityArray.count != 0 || self.currencyArray.count != 0 || self.moneyArray.count != 0 || self.phaseArray.count != 0 {
            let dic = NSMutableDictionary()
            dic["类型"]=self.normalArray
            dic["关注领域"]=self.industryArray
            dic["投资地域"]=self.cityArray
            dic["投资币种"]=self.currencyArray
            dic["融资金额"]=self.moneyArray
            dic["融资阶段"]=self.phaseArray
            dic["最小金额"]=self.moneyMin
            dic["最大金额"]=self.moneyMax
            arr.addObject(dic)
            self.parameterBlock(arr)
        }else{
            self.parameterBlock(arr)
        }
        self.chuanzhi()
    }
    
    func checkoutArray(){
        if self.cityArray.containsObject("全部"){
            self.cityArray.removeAllObjects()
        }
    }
    func saveTheCities(cityList:NSMutableArray){
        let prefs=NSUserDefaults.standardUserDefaults()
        let mutabeArryCopy=cityList.mutableCopy()
        if self.pageType == .ProjectPage{
            prefs.setObject(mutabeArryCopy, forKey: DEFAULTCITYARRAYKEY)
        }else if self.pageType == .InvestorsPage{
            prefs.setObject(mutabeArryCopy, forKey: DEFAULTPROJECTCITYARRAYKEY)
        }
    }
    //MARK:将当前新数据 保存起来
    func newOldArray(){
        self.currencyArray = self.newCurrencyArray
        self.normalArray = self.newNormalArray
        self.industryArray = self.newIndustryArray
        self.cityArray = self.newCityArray
        self.moneyArray = self.newMoneyArray
        self.phaseArray = self.newPhaseArray
        self.moneyMax = self.newMoneyMax
        self.moneyMin = self.newMoneyMin
    }
    //MARK:将筛选数据 保存起来
    func oldNewArray(){
        self.newCurrencyArray = self.currencyArray
        self.newNormalArray = self.normalArray
        self.newIndustryArray = self.industryArray
        self.newCityArray = self.cityArray
        self.newMoneyArray = self.moneyArray
        self.newPhaseArray = self.phaseArray
        self.newMoneyMax = self.moneyMax
        self.newMoneyMin = self.moneyMin
    }
    //MARK:初始化新数组
    func initNewArray(){
        
        self.newNormalArray = NSMutableArray()
        self.newIndustryArray = NSMutableArray()
        self.newCurrencyArray = NSMutableArray()
        self.newMoneyArray = NSMutableArray()
        self.newPhaseArray = NSMutableArray()
        self.newCityArray = NSMutableArray()
        self.newMoneyMax = nil
        self.newMoneyMin = nil
    }
    //MARK:初始化筛选数组
    func initOldArray(){
        self.normalArray = NSMutableArray()
        self.industryArray = NSMutableArray()
        self.currencyArray = NSMutableArray()
        self.moneyArray = NSMutableArray()
        self.phaseArray = NSMutableArray()
        self.cityArray = NSMutableArray()
        self.moneyMin = nil
        self.moneyMax = nil
    }
    
    //判断币种是否为空
    func judgeCurrencyArray()->Bool {
        if  self.newCurrencyArray.count == 0{
            if self.moneyMin != nil && self.moneyMax != nil{
                SMToast("请选择币种")
                return false
            }
            return true
        }
        return true
    }
    func chuanzhi(){
        if self.invesPageType == .PersonPage {
            self.block(1)
        }else{
            self.block(0)
        }
    }
    func DataStorage() {
        if self.pageType == .ProjectPage {
            DSAccountInfo.sharedInstance().productsSX = self.dataTihuan(DSAccountInfo.sharedInstance().productsSX )
        }else{
            DSAccountInfo.sharedInstance().institutionSX = self.dataTihuan(DSAccountInfo.sharedInstance().institutionSX )
        }
    }
    func dataTihuan(str:String?) -> (String?) {
        if str == nil {
            return "0"
        }else{
            let a = NSInteger(str!)
            return String(a!+1)
        }
    }
    func betweenResetDefaultData(){
        let prefs=NSUserDefaults.standardUserDefaults()
        let mutabeArryCopy=NSMutableArray()
        if self.pageType == .ProjectPage{
            prefs.setObject(mutabeArryCopy, forKey: DEFAULTCITYARRAYKEY)
            
        }else{
            prefs.setObject(mutabeArryCopy, forKey: DEFAULTPROJECTCITYARRAYKEY)
        }
    }
}
func resetDefaultData(){
    let prefs=NSUserDefaults.standardUserDefaults()
    let mutabeArryCopy=NSMutableArray()
    prefs.setObject(mutabeArryCopy, forKey: DEFAULTCITYARRAYKEY)
    prefs.setObject(mutabeArryCopy, forKey: DEFAULTPROJECTCITYARRAYKEY)
  
}



