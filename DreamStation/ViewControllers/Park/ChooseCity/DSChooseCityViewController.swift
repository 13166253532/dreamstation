//
//  DSChooseCityViewController.swift
//  DreamStation
//
//  Created by xjb on 16/7/26.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSChooseCityViewController: HTBaseViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBOutlet weak var titltLabel: UILabel!
    let wide = UIScreen.mainScreen().bounds.width-30
    var cityName:String?
    var dataSource = NSMutableArray()
    var cityBlock:passParameterBlock!
    var cityArray = NSMutableArray()
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "DSChooseCityViewController", bundle: nil)
        let vc:DSChooseCityViewController=storyboard.instantiateViewControllerWithIdentifier("DSChooseCityViewController")as! DSChooseCityViewController
        vc.createArgs=createArgs
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationController()
        initTitleBar()
        initLabel()
        httpScreenParkCityListRequire()
        initCollectionView()
    }

    override func initTitleBar() {
        super.initTitleBar()
        self.title=loadString("DSChooseCityTitle", tableId: TITLESTRINGTABLEID)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    func initLabel(){
        titltLabel.text = "  选择极客出发合作园区已覆盖的城市"
    }
    
    func initNavigationController(){
        let rightItem = UIBarButtonItem.init(title: "确定", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(DSChooseCityViewController.goToMessage))
         self.navigationItem.rightBarButtonItem = rightItem
    }
    //MARK:确定
    func goToMessage(){
        if cityName == nil {
            SMToast("请选择城市")
        }else{
            
            let  controllers = self.navigationController!.viewControllers;
            
            for vc in controllers{
                
                if (vc.isKindOfClass(DSParkViewController)){
                    
                    let parkVC=vc as! DSParkViewController
                    parkVC.cityName=cityName
                    self.navigationController?.popToViewController(parkVC, animated: true)
                    
                }
                
            }
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    func initCollectionView(){
        self.dataSource = NSMutableArray()
        registerCollectinViewCell(self.myCollectionView, cell: DSChooseCityCell.self)
        initdataSource()
        self.myCollectionView.delegate = self
        self.myCollectionView.dataSource = self
    }

    func initdataSource(){
//        var cityNameArr = NSMutableArray()
//        let list:NSMutableArray = self.inPlistData("DSScreeningRegional.plist")
//        cityNameArr = list
        
        for index in 0..<self.cityArray.count {
            self.initCell(self.cityArray[index] as! String)
        }
    }
    func inPlistData(plistString:String)->(NSMutableArray){
        let string:String = NSBundle.mainBundle().pathForResource(plistString, ofType: nil)!
        let plistArray:NSMutableArray = NSMutableArray.init(contentsOfFile: string)!
        return plistArray
    }
    func initCell(cityName:String){
        let info = DSChooseCityModel()
        info.className = "DSChooseCityCell"
        info.title = cityName
        if self.cityName != nil {
            if self.cityName == cityName {
                info.isSelect = true
            }
        }
        self.dataSource .addObject(info)
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
     
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
     
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake((self.wide-30)/3, 40)
    }
     
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
         
        return collectionViewSectionZero(collectionView, cellForRowAtIndexPath: indexPath)
    }
     
     
    func collectionViewSectionZero(collectionView:UICollectionView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
         
        let info:HTBaseCellModel = self.dataSource.objectAtIndex(indexPath.row) as! HTBaseCellModel
        let cellClass = swiftClassFromString(info.className) as! DSChooseCityCell.Type
        let cell = getCollectionViewCell(collectionView, cell: cellClass.self, indexPath: indexPath)
        cell.configurateTheCell(info)
        return cell
         
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        for index in 0..<self.dataSource.count {
            let info:DSChooseCityModel=self.dataSource.objectAtIndex(index) as! DSChooseCityModel
            info.isSelect = false
        }
        let info:DSChooseCityModel=self.dataSource.objectAtIndex(indexPath.row) as! DSChooseCityModel
        cityName = info.title
        info.isSelect = !info.isSelect
        myCollectionView.reloadData()
    }
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let info:DSChooseCityModel=self.dataSource.objectAtIndex(indexPath.row) as! DSChooseCityModel
        info.isSelect = !info.isSelect
        myCollectionView.reloadData()
    }
    
    // MARK:- UICollectionViewDelegateFlowLayout
    // 设置cell和视图边的间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(15, 15, 15, 15)
    }
        
    // 设置每一个cell最小行间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 15
    }
        
    // 设置每一个cell的列间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 15
    }
        
        


}
