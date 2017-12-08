//
//  DSHotDetailViewController+followView.swift
//  DreamStation
//
//  Created by xjb on 2017/1/12.
//  Copyright © 2017年 QPP. All rights reserved.
//

import UIKit

extension DSHotDetailViewController {
    func addFollowView(){
        let nib:NSArray = NSBundle.mainBundle().loadNibNamed("DSAddFollowView", owner: self, options: nil)!
        let followView = nib.lastObject as? DSAddFollowView
        followView!.frame = CGRectMake(0, 0, SCREEN_WHIDTH(), SCREEN_HEIGHT())
        followView!.show()
        followView!.getData("确认要发起约谈吗？", conBlock: { [weak self] in
                self!.httpPersonAccountRequire()
                followView!.removeFromSuperview()
            }) { [weak self] in
                followView!.removeFromSuperview()
        }
    }
}
