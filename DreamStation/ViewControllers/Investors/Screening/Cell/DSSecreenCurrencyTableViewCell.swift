//
//  DSSecreenCurrencyTableViewCell.swift
//  DreamStation
//
//  Created by xjb on 16/8/3.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSSecreenCurrencyTableViewCell: HTBaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
  
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var optionsDataArry:NSMutableArray!
    var collectionDelegate:DSSecreenCurrencyCollectionDelegate!
    var dataSource = NSMutableArray()
    var currencyDataArry = NSMutableArray()
    var arrayBlock:passParameterBlock!
    var resetBool = true
    /// Cell宽高
    var sizeMake:CGSize!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    override func configurateTheCell(xinfo:HTBaseCellModel){
        let info:DSScreeningCellModel = xinfo as! DSScreeningCellModel
        self.titleLabel.text = info.title
        self.sizeMake = info.sizeMake
        self.myCollectionView.backgroundColor = UIColor.whiteColor()
        self.optionsDataArry = NSMutableArray()
        self.currencyDataArry = info.shaixuanArray
        info.shaixuanArray = NSMutableArray()
        
        self.optionsDataArry = info.optionsDataArry
        self.arrayBlock = info.arrayBlock
        if self.resetBool != info.resetBool{
            self.dataSource = NSMutableArray()
            self.resetBool = info.resetBool
        }
        initCollectionView()
    }

    func initCollectionView(){
        self.collectionDelegate = DSSecreenCurrencyCollectionDelegate()
        registerCollectinViewCell(self.myCollectionView, cell: DSScreeningCollectionViewCell.self)

        if self.dataSource.count == 0  {
            initDataSource()
        }
        if self.currencyDataArry.count != 0 {
            print(self.currencyDataArry[0] as! String)
            self.dataSource = NSMutableArray()
            initDataSource()
        }else{
            
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
        for index in 0..<self.currencyDataArry.count {
            let str1 = self.currencyDataArry[index] as! String
            if str == str1 {
                return true
            }else{
                isShaixuan = false
            }
        }
        return isShaixuan
    }
    
    
}
class DSSecreenCurrencyCollectionDelegate: DSBaseCollectionDelegate {
    /// Cell宽高
    var sizeMake:CGSize!
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return sizeMake
    }
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(15, 15, 15, 15)
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let info:DSScreenCollectionCellModel=self.dataSource.objectAtIndex(indexPath.row) as! DSScreenCollectionCellModel
        info.isSelect = !info.isSelect
        if indexPath.row != 0{
            let info:DSScreenCollectionCellModel=self.dataSource.objectAtIndex(0) as! DSScreenCollectionCellModel
            info.isSelect = false
        }else{
            for index in 0...self.dataSource.count-1 {
                let info:DSScreenCollectionCellModel=self.dataSource.objectAtIndex(index) as! DSScreenCollectionCellModel
                info.isSelect = false
                let infoOne:DSScreenCollectionCellModel=self.dataSource.objectAtIndex(0) as! DSScreenCollectionCellModel
                infoOne.isSelect = true
            }
        }
        self.updateBlock(info.title)
    }

}
