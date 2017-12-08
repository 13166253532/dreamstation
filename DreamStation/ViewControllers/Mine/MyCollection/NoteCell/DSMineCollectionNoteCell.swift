//
//  DSMineCollectionNoteCell.swift
//  DreamStation
//
//  Created by xjb on 16/8/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSMineCollectionNoteCell: HTBaseTableViewCell {

    @IBOutlet weak var noteLabel: UILabel!
    var changeMarkBlock:selectBlock!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func configurateTheCell(info: HTBaseCellModel) {
        let xinfo: DSMineCollectionNoteCellModel = info as! DSMineCollectionNoteCellModel
        self.changeMarkBlock = xinfo.changeMarkBlock
        if xinfo.noteTitle == nil || xinfo.noteTitle?.characters.count == 0 {
            self.noteLabel.text = "无"
        }else{
            self.noteLabel.text = xinfo.noteTitle
        }
    }
    
    @IBAction func changeMark(sender: UIButton) {
        self.changeMarkBlock()
    }
    
    
}
class DSMineCollectionNoteCellModel: HTBaseCellModel {
    var noteTitle:String?
    var markCellH:CGFloat?
    var changeMarkBlock:selectBlock!
    
}
