//
//  DSViewControlllerTableViewCell.swift
//  DreamStation
//
//  Created by QPP on 16/7/4.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSViewControlllerTableViewCell: HTBaseTableViewCell {

    
    var  info:viewControllerData!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if(selected==true){
            self.info.cellBlock()
        }
    }
    override func configurateTheCell(xinfo:HTBaseCellModel){
        self.info=xinfo as! viewControllerData
        
        
        
        self.textLabel?.text=self.info.title
    }
}
class  viewControllerData: HTBaseCellModel {
    var title:String?
    var cellBlock:selectBlock!

}
