//
//  DSParkDetailsVC+play.swift
//  DreamStation
//
//  Created by xjb on 2017/1/17.
//  Copyright © 2017年 QPP. All rights reserved.
//

import UIKit

extension DSParkDetailsVC {

    func addPlayView(){
        let nib:NSArray = NSBundle.mainBundle().loadNibNamed("DSAddFollowView", owner: self, options: nil)!
        let playView = nib.lastObject as? DSAddFollowView
        playView!.frame = CGRectMake(0, 0, SCREEN_WHIDTH(), SCREEN_HEIGHT())
        playView!.show()
        playView!.getData("确认要申请入驻该园区吗？", conBlock: { [weak self] in
            self!.httpApplyParkRequire()
            playView!.removeFromSuperview()
        }) { [weak self] in
            playView!.removeFromSuperview()
        }
    }
    
}
