//
//  DSSecreenNormalTableViewCell.swift
//  DreamStation
//
//  Created by xjb on 16/8/2.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSSecreenNormalTableViewCell: HTBaseTableViewCell {

    @IBOutlet weak var myCollectionView: UICollectionView!
    var optionsDataArry:NSMutableArray!
    var collectionDelegate:DSSecreenNormalCollectionDelegate!
    var dataSource:NSMutableArray!
    var normalArray = NSMutableArray()
    
    
    var arrayBlock:passParameterBlock!
    /// 是否选中
    var isSelect = false
    var updateBlock:passParameterBlock!
 
    var resetBool = true
    /// Cell宽高
    var sizeMake:CGSize!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dataSource = NSMutableArray()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    override func configurateTheCell(xinfo:HTBaseCellModel){
        let info:DSScreeningCellModel = xinfo as! DSScreeningCellModel
        self.myCollectionView.backgroundColor = UIColor.whiteColor()
        self.optionsDataArry = NSMutableArray()
        self.optionsDataArry = info.optionsDataArry
        self.normalArray = info.shaixuanArray
        info.shaixuanArray = NSMutableArray()
        self.arrayBlock = info.arrayBlock
        self.sizeMake = info.sizeMake
        if self.resetBool != info.resetBool{
           self.dataSource = NSMutableArray()
            self.resetBool = info.resetBool
        }
        initCollectionView()
    }


    func initCollectionView(){
        self.collectionDelegate = DSSecreenNormalCollectionDelegate()
        registerCollectinViewCell(self.myCollectionView, cell: DSScreeningCollectionViewCell.self)
  
        if self.dataSource.count == 0{
           initDataSource()
        }
        if self.normalArray.count != 0 {
            self.dataSource = NSMutableArray()
            initDataSource()
        }
        self.collectionDelegate.dataSource = self.dataSource
        self.collectionDelegate.sizeMake = self.sizeMake
        self.myCollectionView.delegate = self.collectionDelegate
        self.myCollectionView.dataSource = self.collectionDelegate
        self.collectionDelegate.updateBlock = {
            [weak self](str:AnyObject)->()in
            self?.myCollectionView .reloadData()
            let normalDataArry = NSMutableArray()
            for index in 0...self!.dataSource.count-1 {
                let info = self?.dataSource[index] as! DSScreenCollectionCellModel
                if info.isSelect == true {
                    normalDataArry .addObject(info.title)
                }
            }
            self?.arrayBlock(normalDataArry)
        }
        
    }
    func initDataSource(){
        for index in 0...self.optionsDataArry.count-1 {
            let info = DSScreenCollectionCellModel()
            info.className = "DSScreeningCollectionViewCell"
            info.title = self.optionsDataArry[index] as! String
             info.isSelect = self.shaixuanTihuan(info.title)
            self.dataSource .addObject(info)
        }
    }
    func shaixuanTihuan(str:String) -> (Bool) {
        var isShaixuan = Bool()
        for index in 0..<self.normalArray.count {
            let str1 = self.normalArray[index] as! String
            if str == str1 {
                return true
            }else{
                isShaixuan = false
            }
        }
        return isShaixuan
    }
}
class DSSecreenNormalCollectionDelegate: DSBaseCollectionDelegate {
    /// Cell宽高
    var sizeMake:CGSize!
     let wides = UIScreen.mainScreen().bounds.width/375
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return sizeMake
    }
    // 设置cell和视图边的间距
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(25, 15, 15, 15)
    }


}
