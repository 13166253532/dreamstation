//
//  DSScreeningTableViewDelegate.swift
//  DreamStation
//
//  Created by xjb on 16/8/2.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSScreeningTableViewDelegate: NSObject,UITableViewDelegate,UITableViewDataSource {
    var dataSource:NSMutableArray!
    var firstHeigh:CGFloat!
    var industryHeigh:CGFloat!
    var stageHeigh:CGFloat!
    var cityHeigh:CGFloat!
    var pageType:PageType = PageType.ProjectPage
    
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
            return 0
        }
        return 10
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch self.pageType {
        case .ProjectPage:
            if indexPath.row == 0 {
                return firstHeigh
            }else if indexPath.row == 1{
                return 80
            }else if indexPath.row == 4{
                if self.industryHeigh != nil {
                    return 106+self.industryHeigh
                }
            }else if indexPath.row == 5{
                if self.stageHeigh != nil {
                    return 116+self.stageHeigh
                }else{
                    return 116
                }
            }else if indexPath.row == 6{
                if self.cityHeigh != nil {
                    return 106+self.cityHeigh
                }
            }
            break
        case .InvestorsPage:
            if indexPath.row == 2{
                if self.industryHeigh != nil {
                    return 106+self.industryHeigh
                }
            }else if indexPath.row == 3{
                if self.stageHeigh != nil {
                    return 116+self.stageHeigh
                }else{
                    return 116
                }
            }else if indexPath.row == 4{
                if self.cityHeigh != nil {
                    return 106+self.cityHeigh
                }
            }
            break
        }
        return 106
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
class DSBaseCollectionDelegate: NSObject ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var dataSource:NSMutableArray!
    var updateBlock:passParameterBlock!
    let wide = UIScreen.mainScreen().bounds.width/375
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 40)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        return collectionViewSectionZero(collectionView, cellForRowAtIndexPath: indexPath)
    }
    
    
    func collectionViewSectionZero(collectionView:UICollectionView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let info:HTBaseCollectionViewCellModel = self.dataSource.objectAtIndex(indexPath.row) as! HTBaseCollectionViewCellModel
        let cellClass = swiftClassFromString(info.className) as! HTBaseCollectionViewCell.Type
        let cell = getCollectionViewCell(collectionView, cell: cellClass.self, indexPath: indexPath)
        cell.configurateTheCell(info)
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let info:DSScreenCollectionCellModel=self.dataSource.objectAtIndex(indexPath.row) as! DSScreenCollectionCellModel
        info.isSelect = !info.isSelect
        self.updateBlock(info.title)
    }
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
    }

    
    // MARK:- UICollectionViewDelegateFlowLayout
    // 设置cell和视图边的间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(25, 15, 15, 15)
    }
    
    // 设置每一个cell最小行间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 15
    }
    
    // 设置每一个cell的列间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 14
    }

}
