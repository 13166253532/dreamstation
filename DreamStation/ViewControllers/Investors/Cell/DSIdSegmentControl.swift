//
//  DSIdSegmentControl.swift
//  DreamStation
//
//  Created by xjb on 16/7/29.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSIdSegmentControl: UIControl {

    @IBOutlet weak var idSegment: UISegmentedControl!
    
    var block:passParameterBlock!
    
    @IBOutlet weak var investorsImage: UIImageView!
    
    @IBOutlet weak var perImage: UIImageView!
    var index = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clearColor()
        //self.backgroundColor = UIColor.whiteColor()
        self.idSegment.tintColor = UIColor.clearColor()
        self.idSegment.setTitleTextAttributes(DSSegmentedDic.getSelectedDic(UIColorFromRGB(0xd2eeee)), forState: .Selected)
        self.idSegment.setTitleTextAttributes(DSSegmentedDic.getNormalDic(UIColorFromRGB(0xdaf0f0)), forState: .Normal)
        self.investorsImage.hidden = false
        self.perImage.hidden = true
    }
    func getgai(){
        if self.index == 0 {
            self.idSegment.selectedSegmentIndex = 0
            self.investorsImage.hidden = false
            self.perImage.hidden = true
        }else if self.index == 1{
            self.idSegment.selectedSegmentIndex = 1
            self.investorsImage.hidden = true
            self.perImage.hidden = false
        }
        
    }
    @IBAction func action(sender: UISegmentedControl) {
       // print(sender.selectedSegmentIndex)
        self.block(sender.selectedSegmentIndex)
        self.gen(sender)
    }
    func gen(sender: UISegmentedControl)  {
        if sender.selectedSegmentIndex == 0 {
            self.investorsImage.hidden = false
            self.perImage.hidden = true
        }else{
            self.investorsImage.hidden = true
            self.perImage.hidden = false
        }
    }
    
    
}
