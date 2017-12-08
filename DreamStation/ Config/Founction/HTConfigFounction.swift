//
//  HTConfigFounction.swift
//  HiTeacher
//
//  Created by QPP on 16/4/12.
//  Copyright © 2016年 QPP. All rights reserved.
//  存放一些常用函数

import UIKit


/**
 从tableView缓存中取出对应类型的Cell
 如果缓存中没有，则重新创建一个
 
 - parameter tableView: tableView
 - parameter cell:      要返回的Cell类型
 - parameter indexPath: 位置
 
 - returns: 传入Cell类型的 实例对象
 */
func getCell<T: UITableViewCell>(tableView:UITableView ,cell: T.Type ,indexPath:NSIndexPath) -> T {
    return tableView.dequeueReusableCellWithIdentifier("\(cell)", forIndexPath: indexPath) as! T ;
}

func getCollectionViewCell<T: UICollectionViewCell>(collectionView:UICollectionView ,cell: T.Type ,indexPath:NSIndexPath) -> T {
    
    return collectionView.dequeueReusableCellWithReuseIdentifier("\(cell)", forIndexPath: indexPath) as! T ;
}

func registerCollectinViewCell<T: UICollectionViewCell>(collectionView:UICollectionView,cell:T.Type){
    collectionView .registerNib(UINib.init(nibName: "\(cell)", bundle: nil), forCellWithReuseIdentifier: "\(cell)")
}

func registerCell<T: UITableViewCell>(tableView:UITableView,cell:T.Type){
    tableView .registerNib(UINib.init(nibName: "\(cell)", bundle: nil), forCellReuseIdentifier: "\(cell)")
}

func swiftClassFromString(className: String) -> AnyClass! {
    //method1
    //方法 NSClassFromString 在Swift中已经不起作用了no effect，需要适当更改
    if  let appName: String? = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String? {
        
        let classStringName = "_TtC\(appName!.utf16.count)\(appName!)\(className.characters.count)\(className)"
        
        
        //let classStringName = "_TtC\(appName?.characters.count))\(appName!)\(className.characters.count))\(className)"
        let  cls: AnyClass? = NSClassFromString(classStringName)
        assert(cls != nil, "class not found,please check className")
        return cls
        
    }
    return nil;
}

//隐藏多余线
func setExtraCellLineHidden(tableView:UITableView){
    let view:UIView=UIView.init()
    view.backgroundColor=UIColor.clearColor()
    tableView.tableFooterView=view
    tableView.tableHeaderView=view
}
//MARK: - 获取字符长度
func getTextRectSize(text:NSString,font:UIFont,size:CGSize) -> CGRect {
    
    let attributes = [NSFontAttributeName: font]
    
    let option = NSStringDrawingOptions.UsesLineFragmentOrigin
    
    let rect:CGRect = text.boundingRectWithSize(size, options: option, attributes: attributes, context: nil)
    
    //        println("rect:\(rect)");
    
    return rect;
}


public func loadString(resId:String, tableId:String?)->String{
    let str=FGLanguageTool.sharedInstance().getStringForKey(resId, withTable: tableId)
    return str;
    
}

func showAlert(title:String,message:String,titleCancelBtn:String,titleSecondBtn:String,blockOtherBtn:selectBlock){
    let alertController = UIAlertController(title: title,
                                            message: message, preferredStyle: .Alert)
    
    let cancelAction = UIAlertAction(title: titleCancelBtn, style: .Cancel, handler: nil)
    let okAction = UIAlertAction(title: titleSecondBtn, style: .Default,
                                 handler: {
                                    action in
                                    blockOtherBtn()
    })
    
    alertController.addAction(cancelAction)
    alertController.addAction(okAction)
    AppRootViewController()!.presentViewController(alertController, animated: true, completion: nil)
}


func showAlertRefresh(title:String,message:String,titleCancelBtn:String,titleSecondBtn:String, blockCancelBtn:selectBlock,blockSureBtn:selectBlock){
    let alertController = UIAlertController(title: title,
                                            message: message, preferredStyle: .Alert)
    
    let cancelAction = UIAlertAction(title: titleCancelBtn, style: .Cancel, handler: {
        action in
        blockCancelBtn()
    })
    let okAction = UIAlertAction(title: titleSecondBtn, style: .Default,
                                 handler: {
                                    action in
                                    blockSureBtn()
    })
    
    alertController.addAction(cancelAction)
    alertController.addAction(okAction)
    AppRootViewController()!.presentViewController(alertController, animated: true, completion: nil)
}


func AppRootViewController() -> UIViewController? {
    var topVC = UIApplication.sharedApplication().keyWindow?.rootViewController
    while topVC?.presentedViewController != nil {
        topVC = topVC?.presentedViewController
    }
    return topVC
}



