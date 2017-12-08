//
//  DSSecreenCityTableViewCell.swift
//  DreamStation
//
//  Created by xjb on 2016/11/24.
//  Copyright © 2016 QPP. All rights reserved.
//

import UIKit


let DEFAULTCITYARRAYKEY="DEFAULTCITYARRAYKEY"
let DEFAULTPROJECTCITYARRAYKEY="DEFAULTPROJECTCITYARRAYKEY"


class DSSecreenCityTableViewCell: HTBaseTableViewCell {

    @IBOutlet weak var myCollectionView: UICollectionView!
  
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var isAnButton: UIButton!
    
    @IBOutlet weak var isAnImage: UIImageView!
   
    
    var info:DSScreeningCellModel!
    var heigh:CGFloat!
    var defaultKey="default"
    var collectionDelegate:DSSecreenIndustryCollectionDelegate!
    var dataSource = NSMutableArray()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.initCollectionView()
        self.isAnImage.image = UIImage.init(named: "Inves_down")
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func configurateTheCell(xinfo:HTBaseCellModel){
        info = xinfo as! DSScreeningCellModel
        self.titleLabel.text = info.title
        self.addIsAnImageButn()
        if info.needUpdate==true{
            self.updateCollectionView()
            info.needUpdate=false
        }
    }
    func updateCollectionView(){
        self.defaultKey=info.defaultKey!
        self.initDataSource()
        self.collectionDelegate.dataSource = self.dataSource
        self.myCollectionView.reloadData()
    }
    func addIsAnImageButn(){
        if info.isSelected==false {
            self.isAnImage.image = UIImage.init(named: "Inves_down")
        }else{
            self.isAnImage.image = UIImage.init(named: "Inves_upward")
        }
    }
    @IBAction func action(sender: UIButton) {
        info.isSelected = !info.isSelected
        self.addIsAnImageButn()
        if info.isSelected==false {
            self.heigh = 0
        }else{
            let index = (UIScreen.mainScreen().bounds.width-30)/info.sizeMake.width
            self.heigh = CGFloat(self.dataSource.count)*(info.sizeMake.height+15)/index+15
        }
        self.myCollectionView.reloadData()
        info.isAnBlock(self.heigh)
    }
    func initCollectionView(){
        registerCollectinViewCell(self.myCollectionView, cell: DSScreeningCollectionViewCell.self)
        self.myCollectionView.backgroundColor = UIColor.whiteColor()
        self.collectionDelegate = DSSecreenIndustryCollectionDelegate()
        self.collectionDelegate.sizeMake =  CGSizeMake((SCREEN_WHIDTH()-30-45)/4, 29)
        self.initDataSource()
        self.collectionDelegate.dataSource = self.dataSource
        self.myCollectionView.delegate = self.collectionDelegate
        self.myCollectionView.dataSource = self.collectionDelegate
        self.myCollectionView.scrollEnabled = false
        self.collectionDelegate.updateBlock = {
            [weak self](str:AnyObject)->()in
            self?.myCollectionView .reloadData()
            let normalDataArry = NSMutableArray()
            for index in 0...self!.dataSource.count-1 {
                let info = self?.dataSource[index] as! DSScreenCollectionCellModel
                if info.isSelect == true{
                    normalDataArry .addObject(info.title)
                }
            }
            self!.info.arrayBlock(normalDataArry)
        }
    }
    func initDataSource(){
        self.dataSource.removeAllObjects()
        let prefs=NSUserDefaults.standardUserDefaults()
        let mutabeArryCopy=prefs.objectForKey(defaultKey)
        let list:NSMutableArray = self.inPlistData("DSScreeningRegional.plist")
        for index in 0..<list.count {
            let str=list[index] as! String
            let info = DSScreenCollectionCellModel()
            info.className = "DSScreeningCollectionViewCell"
            if let mutableArr=mutabeArryCopy{
                let mutableArr2=mutableArr as! NSArray
                if mutableArr2.containsObject(str){
                    info.isSelect=true
                }
            }
            info.title = str
            self.dataSource .addObject(info)
        }
    }
    func resetCollectionView(){
        let prefs=NSUserDefaults.standardUserDefaults()
        let mutabeArryCopy=NSMutableArray()
        prefs.setObject(mutabeArryCopy, forKey: DEFAULTCITYARRAYKEY)
        self.updateCollectionView()
    }
    func inPlistData(plistString:String)->(NSMutableArray){
        let string:String = NSBundle.mainBundle().pathForResource(plistString, ofType: nil)!
        let plistArray:NSMutableArray = NSMutableArray.init(contentsOfFile: string)!
        return plistArray
    }
}
