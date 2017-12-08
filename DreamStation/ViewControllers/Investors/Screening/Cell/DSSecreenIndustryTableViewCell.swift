//
//  DSSecreenIndustryTableViewCell.swift
//  DreamStation
//
//  Created by xjb on 16/8/3.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSSecreenIndustryTableViewCell: HTBaseTableViewCell {


    @IBOutlet weak var myCollectionView: UICollectionView!

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var isAnButton: UIButton!
  
 
    
    @IBOutlet weak var isAnImage: UIImageView!
 
    
    
    var isAnBlock:passParameterBlock!
    var heigh:CGFloat!
    var sizeMake:CGSize!
    
    var optionsDataArry:NSMutableArray!
    var collectionDelegate:DSSecreenIndustryCollectionDelegate!
    var dataSource = NSMutableArray()
    var industryDataArry = NSMutableArray()
     var arrayBlock:passParameterBlock!
    var resetBool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    override func configurateTheCell(xinfo:HTBaseCellModel){
        let info:DSScreeningCellModel = xinfo as! DSScreeningCellModel
        self.titleLabel.text = info.title
        self.myCollectionView.backgroundColor = UIColor.whiteColor()
        self.optionsDataArry = NSMutableArray()
        self.industryDataArry = info.shaixuanArray
        info.shaixuanArray = NSMutableArray()
        self.optionsDataArry = info.optionsDataArry
        if !info.isAn {
            self.isAnButton.selected = info.isAn
            info.isAn = true
        }
        self.addIsAnImageButn()
        self.isAnBlock = info.isAnBlock
        self.sizeMake = info.sizeMake
        self.addIsAnImageButn()
        
        self.arrayBlock = info.arrayBlock
        if self.resetBool != info.resetBool{
            self.dataSource = NSMutableArray()
            self.resetBool = info.resetBool
        }
        initCollectionView()
    }
    func addIsAnImageButn(){
        if !self.isAnButton.selected {
            self.isAnImage.image = UIImage.init(named: "Inves_down")
        }else{
            self.isAnImage.image = UIImage.init(named: "Inves_upward")
        }
    }
    @IBAction func action(sender: UIButton) {
        self.addIsAnImageButn()
        sender.selected = !sender.selected
        if !sender.selected {
            self.heigh = 0
        }else{
            let index = (UIScreen.mainScreen().bounds.width-30)/self.sizeMake.width
            self.heigh = CGFloat(self.optionsDataArry.count)*(self.sizeMake.height+15)/index
        }
        
        self.myCollectionView.reloadData()
        self.isAnBlock(self.heigh)
    }
    
    
    func initCollectionView(){
        self.collectionDelegate = DSSecreenIndustryCollectionDelegate()
        registerCollectinViewCell(self.myCollectionView, cell: DSScreeningCollectionViewCell.self)
        if self.dataSource.count == 0{
            initDataSource()
        }
        if self.industryDataArry.count != 0 {
            self.dataSource = NSMutableArray()
            initDataSource()
        }
        self.collectionDelegate.dataSource = self.dataSource
        self.collectionDelegate.sizeMake = self.sizeMake
        self.myCollectionView.delegate = self.collectionDelegate
        self.myCollectionView.dataSource = self.collectionDelegate
        self.myCollectionView.scrollEnabled = false
        self.collectionDelegate.updateBlock = {
            [weak self](str:AnyObject)->()in
            self?.myCollectionView .reloadData()
            let normalDataArry = NSMutableArray()
            for index in 0...self!.dataSource.count-1 {
                let info = self?.dataSource[index] as! DSScreenCollectionCellModel
                if info.isSelect == true && info.title != "全部"{
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
        for index in 0..<self.industryDataArry.count {
            let str1 = self.industryDataArry[index] as! String
            if str == str1 {
                return true
            }else{
                isShaixuan = false
            }
        }
        return isShaixuan
    }

    
}
class DSSecreenIndustryCollectionDelegate: DSBaseCollectionDelegate {
    
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
