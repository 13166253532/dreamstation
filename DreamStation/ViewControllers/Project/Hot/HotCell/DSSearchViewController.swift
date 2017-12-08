//
//  DSSearchViewController.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/29.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSSearchViewController: HTBaseViewController,UITextFieldDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var textField:UITextField!
    var btn:UIButton!
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSSearchViewController", bundle: nil)
        let vc:DSSearchViewController=storyboard.instantiateViewControllerWithIdentifier("DSSearchViewController")as! DSSearchViewController
        vc.createArgs=createArgs
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initTitleView()
    
    }

    func initTitleView() {

        self.navigationItem.hidesBackButton = true
        
        let nib:NSArray = NSBundle.mainBundle().loadNibNamed("DSSearchView", owner: self, options: nil)
        let view:DSSearchView = nib.lastObject as! DSSearchView
        self.navigationItem.titleView = view
        view.block = {
            let vc:DSProjectViewController = DSProjectViewController.createViewController(nil) as! DSProjectViewController
            self.hidesBottomBarWhenPushed = false
            self.pushViewController(vc, animated: true)
            
        }
        
    }
    
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
