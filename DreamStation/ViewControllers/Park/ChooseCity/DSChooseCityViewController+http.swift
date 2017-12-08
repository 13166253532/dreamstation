//
//  DSChooseCityViewController+http.swift
//  DreamStation
//
//  Created by xjb on 2016/11/28.
//  Copyright © 2016年 QPP. All rights reserved.
//
import UIKit
extension DSChooseCityViewController {
    //MARK:-------请求数据-------
    func httpScreenParkCityListRequire(){
        let cmd:DSParkScreenCityListCmd=DSParkScreenCityListCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSParkScreenCityListCmd
        let block:httpBlock = {[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self!.httpScreenParkCityListResponse(result)
        }
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
    }
    func httpScreenParkCityListResponse(result:RequestResult){
        let r:DSParkScreenCityListResult = result as! DSParkScreenCityListResult
        if r.isOk() {
           self.cityArray = r.getScreenCityList()
           self.initCollectionView()
           self.myCollectionView.reloadData()
        }else{
            SMToast("请查看当前网络状态！")
        }
    }
}
























