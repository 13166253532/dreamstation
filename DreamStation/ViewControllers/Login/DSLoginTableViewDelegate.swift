//
//  DSLoginTableViewDelegate.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/19.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSLoginTableViewDelegate: NSObject,UITableViewDelegate,UITableViewDataSource {

    var dataSource:NSMutableArray!
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return self.tableViewSectionZero(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    func tableViewSectionZero(tableView:UITableView,cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell{
    
        let info:HTBaseCellModel = self.dataSource.objectAtIndex(indexPath.row) as! HTBaseCellModel
        let cellClass = swiftClassFromString(info.className) as! HTBaseTableViewCell.Type
        let cell = getCell(tableView, cell: cellClass.self, indexPath: indexPath)
        cell.configurateTheCell(info)
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if (section==0){
            return 15
        }
        return 10
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) { //ios8
        tableView.tableFooterView = UIView(frame: CGRectZero)
        if cell.respondsToSelector(Selector("setSeparatorInset:"))
        {
            cell.separatorInset = UIEdgeInsetsZero
            tableView.separatorInset = UIEdgeInsetsZero //cell.separatorInset.left = 5
        }
        if cell.respondsToSelector(Selector("setLayoutMargins:")){
            cell.layoutMargins = UIEdgeInsetsZero
            tableView.layoutMargins = UIEdgeInsetsZero //cell.separatorInset.left = 5
        }
    }
//    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
//        view.backgroundColor = UIColor.clearColor()
//    }
//    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        view.tintColor=UIColor.clearColor()
//    }
    
}


