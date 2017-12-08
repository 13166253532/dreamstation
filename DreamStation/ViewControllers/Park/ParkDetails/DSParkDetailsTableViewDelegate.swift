//
//  DSParkDetailsTableViewDelegate.swift
//  DreamStation
//
//  Created by xjb on 16/7/27.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSParkDetailsTableViewDelegate: NSObject,UITableViewDataSource,UITableViewDelegate {
    let bizhi = Double(UIScreen.mainScreen().bounds.height)/568
    var dataSource:NSMutableArray!
    var details:CGFloat!
    var inCase:CGFloat!
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
        if section == 0 {
            return 10
        }else if section == 4 {
            return 0.01
        }
        return 15
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return 0.01
    }
    
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor=UIColor.clearColor()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let ary = self.dataSource[indexPath.section] as? NSMutableArray
        let info:DSParkDetailsCellModel = ary![indexPath.row] as! DSParkDetailsCellModel
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 150
            }else if indexPath.row == 1{
                return 44
            }else if indexPath.row == 2 || indexPath.row == (ary?.count)!-1 {
                return 32
            }else  {
                return 26
            }
        }else if indexPath.section == 1{
            if indexPath.row == 2 {
                if self.details != nil {
                    return info.cellHeight!+self.details
                }else{
                    return info.cellHeight!
                }
            }else if indexPath.row == 1 {
                if info.image != nil{
                    return 174*CGFloat(bizhi)
                }
                return 0
            }
        }else if indexPath.section == 3 || indexPath.section == 2{
            if indexPath.row == 1{
                let rect=self.getSizeFromString(info.title!)
                return rect.height+20
            }
        }else if indexPath.section == 4{
            return 49
        }
    return 44
    }
    
    private func getSizeFromString(str:String)->CGRect{
        let par = NSMutableParagraphStyle.init()
        par.lineSpacing = 9
        
        let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(14),NSParagraphStyleAttributeName:par]
        
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        
        let rect:CGRect = str.boundingRectWithSize(CGSizeMake(SCREEN_WHIDTH()-30, 1000), options: option, attributes: attributes, context: nil)
        return rect
    }
 
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
 

}
