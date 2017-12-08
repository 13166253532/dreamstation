//
//  HTBaseTableViewDelegate.swift
//  HiTeacher
//
//  Created by QPP on 16/4/20.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class HTBaseTableViewDelegate: NSObject,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate {
    //MARK:- tableView delegate datasource
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
        return 1
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
