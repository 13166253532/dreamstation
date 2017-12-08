//
//  DSParkViewController+TableView.swift
//  DreamStation
//
//  Created by QPP on 16/11/16.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

extension DSParkViewController{
    
    func initTableView(){
        self.myTableView.backgroundColor = grayBgColor
        self.layout.constant = 0
        self.tixingImage.hidden = true
        self.tixingLabel.hidden = true
        self.addHeaderFooter()
        delegate = DSParkTableViewDelegate()
        registerCell(self.myTableView, cell: DSParkApplyMessageCell.self)
        registerCell(self.myTableView, cell: DSParkChooseCityCell.self)
        registerCell(self.myTableView, cell: DSParkPageCell.self)
        self.initDataSource()
        delegate.dataSource = self.dataSource
        self.myTableView.delegate = delegate
        self.myTableView.dataSource = delegate
        
    }
    
    func initDataSource(){
        initFirstRow()
        self.buildSecondSection()
        bulidHeadView()
        //initSecondRow()
    }
    func buildSecondSection(){
        let arr=NSMutableArray()
        self.dataSource.addObject(arr)
    }

    func initFirstRow(){
        let arr=NSMutableArray()
        let info = DSParkCellModel()
        info.className = "DSParkApplyMessageCell"
        info.block = {
            [weak self] in
            let vc:DSParkMessageViewController=DSParkMessageViewController.createViewController(nil) as! DSParkMessageViewController
            vc.hidesBottomBarWhenPushed = true
            self!.pushViewController(vc, animated: true)
            
        }
        info.goBlock = {
            [weak self](str:AnyObject)->()in
            self!.initShutdown(true)
            self!.addTime()
        }
        arr.addObject(info)
        self.dataSource .addObject(arr)
        
    }
    func initShutdown(isShutdown:Bool){
        self.Shutdown = isShutdown
        delegate.Shutdown = self.Shutdown
        self.myTableView .reloadData()
    }


    
    func initParkCell(parkHeadImage:String?,parkName:String?,parkSub:String?,parkCity:String?,parkVideoImage:String?,parkVideoSub:String?,block:selectBlock,goBlock:passParameterBlock){
        let info = DSParkCellModel()
        info.className = "DSParkPageCell"
        info.headImage = parkHeadImage
        if parkHeadImage != nil {
            info.headImage = self.changeImgUrl(parkHeadImage!)
        }
        info.parkName = parkName
        info.parkSub = parkSub
        info.cityName = parkCity
        if parkHeadImage != nil {
            info.videoImage = self.changeImgUrl(parkVideoImage!)
        }
        info.videoSub = parkVideoSub
        info.block = block
        info.goBlock = goBlock
        self.dataSource .addObject(info)
    }
    
    
    //MARK:- 添加上拉加载 下拉刷新
    func addHeaderFooter(){
        self.header.setRefreshingTarget(self, refreshingAction: #selector(DSParkViewController.upPullLoadData))
        self.header.lastUpdatedTimeLabel.hidden = true
        self.header.stateLabel.hidden = true
        self.footer.setRefreshingTarget(self, refreshingAction: #selector(DSParkViewController.downPlullLoadData))
        self.footer.stateLabel.hidden = true
        self.footer.refreshingTitleHidden = true
        self.myTableView.mj_header = self.header
        self.myTableView.mj_footer = self.footer
    }
    
    //MARK:- 下拉刷新
    func upPullLoadData(){
        self.page = 0
        self.cleanData()
        self.parkHttpRequire()
        self.myTableView.reloadData()
    }
    
    
    //MARK:- 上拉加载
    func downPlullLoadData(){
        self.parkHttpRequire()
    }
   
    
    //之前是tableview中的cell，现在是tableview中的headview
    func buildSecondRow(){
        //let arr=NSMutableArray()
        self.cityCellInfo = DSParkCellModel()
        cityCellInfo.className = "DSParkChooseCityCell"
        cityCellInfo.cityName = self.cityName
        cityCellInfo.goBlock = {
            [weak self](str:AnyObject)->()in
            
            let vc:DSChooseCityViewController=DSChooseCityViewController.createViewController(nil) as! DSChooseCityViewController
            vc.cityName = self?.cityName
            vc.hidesBottomBarWhenPushed = true
            self!.pushViewController(vc, animated: true)
            
        }
    }
    func bulidHeadView(){
        self.buildSecondRow()
        self.delegate.cityCellInfo=cityCellInfo
    }
    func cleanData(){
        let arr=self.dataSource[1] as! NSMutableArray
        arr.removeAllObjects()
        self.delegate.dataSource = self.dataSource
        self.myTableView .reloadData()
    }

}
