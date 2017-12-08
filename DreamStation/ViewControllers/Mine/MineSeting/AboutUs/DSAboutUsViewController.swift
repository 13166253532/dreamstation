//
//  DSAboutUsViewController.swift
//  DreamStation
//
//  Created by xjb on 16/7/22.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSAboutUsViewController: HTBaseViewController {

    @IBOutlet weak var myText: UILabel!
    
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSAboutUsViewController", bundle: nil)
        let vc:DSAboutUsViewController=storyboard.instantiateViewControllerWithIdentifier("DSAboutUsViewController")as! DSAboutUsViewController
        vc.createArgs=createArgs
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTitleBar()
        self.updateTheText()
        
       
    }
    
    func updateTheText(){
        
        let str="Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda"
        
        
        let paragraphStyle:NSMutableParagraphStyle=NSMutableParagraphStyle()
        paragraphStyle.lineSpacing=9
        
        var myMutableString = NSMutableAttributedString()
        
        myMutableString = NSMutableAttributedString(string: str, attributes: [NSParagraphStyleAttributeName:paragraphStyle])
        
        
        
        self.myText.attributedText = myMutableString

    }
    
    
    

    override func initTitleBar() {
        super.initTitleBar()
        self.title=loadString("DSAboutUsTitle", tableId: TITLESTRINGTABLEID)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
    }
    



}
