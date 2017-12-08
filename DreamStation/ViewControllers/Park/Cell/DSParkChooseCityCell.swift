//
//  DSParkChooseCityCell.swift
//  DreamStation
//
//  Created by xjb on 16/7/26.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSParkChooseCityCell: HTBaseTableViewCell {

    var goBlock:passParameterBlock!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func configurateTheCell(xinfo:HTBaseCellModel){
        let info:DSParkCellModel = xinfo as! DSParkCellModel
        self.goBlock = info.goBlock
        self.cityNameLabel.text = info.cityName
       
    }
    
    @IBAction func action(sender: AnyObject) {
        self.goBlock(sender)
        
    }
    
}
