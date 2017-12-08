//
//  DSMessageTableViewDelegate.swift
//  DreamStation
//
//  Created by xjb on 16/7/25.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSMessageTableViewDelegate: NSObject ,UITableViewDataSource,UITableViewDelegate{

    
    var dataSource:NSMutableArray!
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arr=self.dataSource[section] as! NSMutableArray
        return arr.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return self.tableViewSectionZero(tableView, cellForRowAtIndexPath: indexPath)
        
    }
    
    func tableViewSectionZero(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        let arr=self.dataSource[indexPath.section] as! NSMutableArray
        let info:HTBaseCellModel=arr.objectAtIndex(indexPath.row) as! HTBaseCellModel
        let cellClass=swiftClassFromString(info.className) as! HTBaseTableViewCell.Type
        let cell=getCell(tableView, cell: cellClass.self, indexPath: indexPath)
        cell.configurateTheCell(info)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.dataSource.count-1 ==  section{
            return 0
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let arr=self.dataSource[indexPath.section] as! NSMutableArray
        let info = arr.objectAtIndex(indexPath.row) as! DSMessageCellModel
        if info.type == JPUSHTYPE.PRODUCTS_WECHAT_GROUP.rawValue || info.type == JPUSHTYPE.INVESTORS_WECHAT_GROUP.rawValue {
            return 65
        }else{
            return 99
        }  
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let arr=self.dataSource[indexPath.section] as! NSMutableArray
        let info = arr.objectAtIndex(indexPath.row) as! DSMessageCellModel
        info.block()
    }
    
    
    
    //mark 设置可以进行编辑
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        return true
    }
    // mark 设置编辑的样式
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle{
        return UITableViewCellEditingStyle.Delete
    }
    //删除cell
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == UITableViewCellEditingStyle.Delete{
            let arr=self.dataSource[indexPath.section] as! NSMutableArray
            let info = arr.objectAtIndex(indexPath.row) as! DSMessageCellModel
            info.blockParam(indexPath)
           
        }
    }
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor=UIColor.clearColor()
    }
    
}
