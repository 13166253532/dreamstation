//
//  DSServiceViewController.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/2.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSServiceViewController: HTBaseViewController,UIScrollViewDelegate {

    @IBOutlet var scrollView: UIScrollView!

    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSServiceViewController", bundle: nil)
        let vc:DSServiceViewController=storyboard.instantiateViewControllerWithIdentifier("DSServiceViewController")as! DSServiceViewController
        vc.createArgs=createArgs
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTitleBar()

        self.initScrollView()
    }
    
    override func initTitleBar() {
        super.initTitleBar()

        self.title = loadString("DSServiceTitle", tableId:TITLESTRINGTABLEID)
    }
    
    func initScrollView(){
        
        let label:UILabel = UILabel.init(frame: CGRectMake(15, 15,SCREEN_WHIDTH()-30, SCREEN_HEIGHT()-15))
        label.text = "支持的版本r1.2.5 以后。功能说明只有在前端运行的时候才能收到自定义消息的推送。从jpush服务器获取用户推送的自定义消息内容和标题以及附加字段等。实现方法获取iOS的推送内容需要在delegate类中注册通知并实现回调方法。"
     
        let attributedString:NSMutableAttributedString = NSMutableAttributedString.init(string: label.text!)
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = 9
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0,label.text!.characters.count))
        label.attributedText = attributedString
        
        label.numberOfLines = 0
        label.font = UIFont.systemFontOfSize(14)
        label.sizeToFit()
        
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSizeMake(0,label.frame.size.height+15)
        self.scrollView.addSubview(label)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
