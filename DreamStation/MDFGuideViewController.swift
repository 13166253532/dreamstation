//
//  MDFGuideViewController.swift
//  MDF
//
//  Created by K.E. on 16/9/22.
//  Copyright © 2016年 smilingmobile. All rights reserved.
//

import UIKit

class MDFGuideViewController: UIViewController ,UIScrollViewDelegate
{
    //页面数量
    var numOfPages = 3

    override func viewDidLoad()
    {
        self.prefersStatusBarHidden()
        if #available(iOS 9.0, *) {
            self.setNeedsFocusUpdate()
        } else {
            // Fallback on earlier versions
        }
        let frame = self.view.bounds
        let scrollView = UIScrollView()
        scrollView.frame = CGRectMake(0, 0, SCREEN_WHIDTH(), SCREEN_HEIGHT())
        scrollView.contentSize = CGSizeMake(SCREEN_WHIDTH() * CGFloat(numOfPages), SCREEN_HEIGHT())
        scrollView.delegate = self
        scrollView.pagingEnabled = true
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        for i in 0..<numOfPages{
            let imgfile = "load-\(Int(i+1)).png"
            print(imgfile)
            let image = UIImage(named:"\(imgfile)")
            let imgView = UIImageView(image: image)
            imgView.frame = CGRectMake(frame.size.width*CGFloat(i),CGFloat(0),
                                       frame.size.width,frame.size.height)
            scrollView.addSubview(imgView)
            if i == 2 {
                
                let button = UIButton(frame:CGRect(x:(scrollView.frame.width-180)/2+scrollView.frame.width*2, y:scrollView.frame.height-80, width:180, height:40))
                //设置按钮文字
                //button.setTitle("Experience now", forState: UIControlState.Normal)
                button.addTarget(self, action:#selector(btnClick), forControlEvents: .TouchUpInside)
//                button.titleLabel?.font =  UIFont.systemFontOfSize(14)
                
                button.setBackgroundImage(UIImage(named:"guide_btn"), forState:.Normal)
                scrollView.addSubview(button)
//                guide_btn
            }
        }
        scrollView.contentOffset = CGPointZero
        self.view.addSubview(scrollView)
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    func btnClick() {
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //MDFAccount.sharedInstance.firstLoad = "true"
        appdelegate.gotoRootVC()
    }
    
    //scrollview滚动的时候就会调用
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
//        print("scrolled:\(scrollView.contentOffset)")
//        let twidth = CGFloat(numOfPages-1) * self.view.bounds.size.width
//        //如果在最后一个页面继续滑动的话就会跳转到主页面
//        if(scrollView.contentOffset.x > twidth)
//        {
//            let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//            appdelegate.gotoLogin()
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
