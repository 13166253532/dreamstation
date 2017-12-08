//
//  DSSecondTableViewCell.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/29.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSSecondTableViewCell: HTBaseTableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    
    var xinfo:DSSecondCellModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configurateTheCell(xinfo: HTBaseCellModel) {
        
        let xinfo:DSSecondCellModel = xinfo as! DSSecondCellModel
        self.xinfo = xinfo
        
        self.titleLabel.text = xinfo.titleValue
        self.detailLabel.text = xinfo.detailValue
        if self.xinfo.num == 2||self.xinfo.num==3{
            self.detailLabel.textColor = UIColor.redColor()
        }
        if self.xinfo.num == 2{
            if let money=self.xinfo.detailValue{
                self.detailLabel.text = String(money+"万"+self.tihuanNil(self.xinfo.currency!)! )
            }else{
                self.detailLabel.text = String("0万"+self.tihuanNil(self.xinfo.currency!)!)
            }
            
        }else if self.xinfo.num == 3{
            if let scale=self.xinfo.detailValue{
                self.detailLabel.text = String(scale+"%")
            }else{
                self.detailLabel.text = String("0%")
            }
        }
    }
    func tihuanNil(str:String?) -> (String?) {
        if str == nil {
            return ""
        }else{
            return str
        }
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

class DSSecondCellModel: HTBaseCellModel {
    var titleValue:String?
    var detailValue:String?
    var num:NSInteger!
    var currency:String?
}
