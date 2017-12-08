//
//  DSFeedBackViewController.swift
//  DreamStation
//
//  Created by xjb on 16/7/22.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSFeedBackViewController: HTBaseViewController,UITextViewDelegate {

    @IBOutlet weak var myTableView: UITableView!

    let tvInfo = HISTextViewCellInfo()
    var delegate:DSFeedBackDelegate!
    var dataSource = NSMutableArray()
    var sectionInfo = HISTextViewCellInfo()
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSFeedBackViewController", bundle: nil)
        let vc:DSFeedBackViewController=storyboard.instantiateViewControllerWithIdentifier("DSFeedBackViewController")as! DSFeedBackViewController
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = loginBg_Color
        initTitleBar()
        initTableView()
  
    }
    override func initTitleBar() {
        super.initTitleBar()
        self.title=loadString("DSFeedBackTitle", tableId: TITLESTRINGTABLEID)
    }
 
    func initTableView(){
        self.delegate = DSFeedBackDelegate()
        updateData()
        registerCell(self.myTableView, cell: DSFeedBackTableViewCell.self)
        self.myTableView.delegate = self.delegate
        self.myTableView.dataSource = self.delegate
        self.myTableView.scrollEnabled = false
        self.delegate.dataSource = self.dataSource
    }
    func updateData() {
        self.dataSource = NSMutableArray()
        initFirstSection()
        
    }
    func initFirstSection(){
        self.sectionInfo.className = "DSFeedBackTableViewCell"
        self.sectionInfo.placeholder = "请输入反馈意见，我们会及时改进"
        self.dataSource.addObject(self.sectionInfo)
    }
    

    
    @IBAction func action(sender: AnyObject) {
        
//        print(self.sectionInfo.tv?.text)
        if self.sectionInfo.tv?.text == nil || self.sectionInfo.tv!.text.characters.count == 0 {
            SMToast("请输入反馈意见！")
        }else{
            self.httpFeedBackRequire()
        }
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    class DSFeedBackDelegate: DSLoginTableViewDelegate {
        override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return CGRectGetHeight(tableView.bounds)
        }
        override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 0
        }
        override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 0
        }
    }
}

extension DSFeedBackViewController{
    
    func httpFeedBackRequire(){
        
        let cmd:DSHttpFeedBackCmd = DSHttpFeedBackCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpFeedBackCmd
        let block:httpBlock = {[weak self](result:RequestResult!,useInfo:AnyObject!)->()in
            self?.httpFeedBackResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete = SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_FeedBack_fromId] = DSAccountInfo.sharedInstance().personId
        dic[kHttpParamKey_FeedBack_fromName] = DSAccountInfo.sharedInstance().phoneNum
        dic[kHttpParamKey_FeedBack_message] = self.sectionInfo.tv!.text
        
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
    }
    
    func httpFeedBackResponse(result:RequestResult){
        
        let r:DSHttpFeedBackResult = result as! DSHttpFeedBackResult
        if r.isOk() {
           SMToast("意见反馈成功！")
            self.navigationController?.popViewControllerAnimated(true)
        }else{
            print("failed")
        }
    }
}
