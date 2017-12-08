//
//  DSMessageDetailsViewController.swift
//  DreamStation
//
//  Created by xjb on 16/9/27.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit
private let DSMESSAGESTRINGS:String = "DSTitleStrings"
class DSMessageDetailsViewController: HTBaseViewController {
    @IBOutlet weak var detailsLabel: UILabel!
    var details:String?
    var height = UIScreen.mainScreen().bounds.height
   
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSMessageDetailsViewController", bundle: nil)
        let vc:DSMessageDetailsViewController=storyboard.instantiateViewControllerWithIdentifier("DSMessageDetailsViewController")as! DSMessageDetailsViewController
        vc.createArgs=createArgs
        return vc
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTitleBar()
       self.addLabel()
    }
    override func initTitleBar() {
        super.initTitleBar()
        self.title = loadString("DSMessageDetailsTitle", tableId: DSMESSAGESTRINGS)
    }
    func addLabel(){
       // self.layoutConstraint.constant = self.height - CGFloat((self.details?.characters.count)!/21*17)
        //self.detailsLabel.bounds.height = self.details!.characters.count/21*17
        self.detailsLabel.text = self.details
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
