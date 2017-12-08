//
//  DSInvesDetailsTableViewDelegate.swift
//  DreamStation
//
//  Created by xjb on 16/8/1.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSInvesDetailsTableViewDelegate: NSObject,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    var dataSource:NSMutableArray!
    var introd:CGFloat!
    var inCase:CGFloat!
    var partner:CGFloat!
    var cellHeight:CGFloat!
    
    var invesPageType:InvesPageType = .PersonPage
    var slidingBlock:selectBlock!
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.slidingBlock()
    }
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
        if section == self.dataSource.count {
            return 15
        }
        return 10
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func headerHeight(height:CGFloat) -> (CGFloat) {
        if height == 0 {
            return 0
        }else{
            return 5
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let ary = self.dataSource[indexPath.section] as! NSMutableArray
        let info = ary.objectAtIndex(indexPath.row) as! DSInvesDetailsHeadCellModel
        
        if indexPath.section == 0 {
            return 250
        }else if indexPath.section == 1 {
            if indexPath.row == 1 {
                if self.introd != nil {
                    return info.cellHeight!+self.introd
                }else{
                    return info.cellHeight!
                }
            }else{
                return self.cellHeightCell()
            }
        }else if indexPath.section == 2{
            return 53
        }else if indexPath.section == 3{
            if indexPath.row == 1 {
                return self.inCase
            }else{
                return self.inCaseCell()
            }
        }else if self.invesPageType != .PersonPage{
            if indexPath.section == 4{
                if indexPath.row != 0 {
                    return 145
                }else{
                    return self.partner
                }
            }
        }
        return 44
    }
    func cellHeightCell()->(CGFloat){
        if self.cellHeight == 0 {
            return self.cellHeight
        }else{
            return 44
        }
    }
    func inCaseCell()->(CGFloat){
        if self.inCase == 0 {
            return self.inCase
        }else{
            return 44
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) { //ios8
        
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
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor=UIColor.clearColor()
        view.backgroundColor = UIColor.clearColor()
    }
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor=UIColor.clearColor()
    }
    
}
