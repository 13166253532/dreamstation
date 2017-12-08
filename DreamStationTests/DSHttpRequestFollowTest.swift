//
//  DSHttpRequestFollowTest.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

class DSHttpRequestFollowTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequestFollow() {
       
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpRequestFollowCmd = DSHttpRequestFollowCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpRequestFollowCmd
        let dic:NSMutableDictionary = NSMutableDictionary()
        let diction:NSMutableDictionary = NSMutableDictionary()
        let list:NSMutableArray = NSMutableArray()
        dic[kHttpParamKey_RequestFollow_model] = "FOLLOW"
        let providerDic:NSMutableDictionary = NSMutableDictionary()
        providerDic[kHttpParamKey_RequestFollow_items_productName] = "月夜项目1"

        providerDic[kHttpParamKey_RequestFollow_items_categories] = "[{\"catName\":\"所属行业\",\"description\":\"广告营销\"},{\"catName\":\"融资阶段\",\"description\":\"PE阶段-C轮\"},{\"catName\":\"所在地区\",\"description\":\"辽宁\"},{\"catName\":\"投资币种\",\"description\":\"人民币\"},{\"catName\":\"投资币种\",\"description\":\"美元\"}]"//项目 分类
        providerDic[kHttpParamKey_RequestFollow_items_companyName] = "月夜项目1"
        
        providerDic[kHttpParamKey_RequestFollow_items_productUrl] = "月夜项目1"//项目视频地址
        providerDic[kHttpParamKey_RequestFollow_items_productId] = "2c92808656e362db0156e3c9ab6a0011"//项目id
        providerDic[kHttpParamKey_RequestFollow_items_productUserId] = "2c92808656e362db0156e3c5ff61000e"//项目方 卖方id

        let individualDic:NSMutableDictionary = NSMutableDictionary()
        individualDic[kHttpParamKey_RequestFollow_items_investmentUserId] = "2c92808656e362db0156e3ce5a620014"//投资人id
        individualDic[kHttpParamKey_RequestFollow_items_account] = "18221630903"//投资人账号
        individualDic[kHttpParamKey_RequestFollow_items_userName] = "林静"//投资人名字
        individualDic[kHttpParamKey_RequestFollow_items_avaterUrl] = "dcd5d0fe-60f3-40a5-8ff9-dd2bd681a2c5.jpeg"//投资人头像
        individualDic[kHttpParamKey_RequestFollow_items_domain] = "军工 交通运输 "//所属行业
        individualDic[kHttpParamKey_RequestFollow_items_phase] = "PE阶段-B轮 VC阶段-PreA轮"//融资阶段
        individualDic[kHttpParamKey_RequestFollow_items_videoUrl] = "http://v.youku.com/v_show/id_XMTY4OTc5MzI4MA==.html?from=s1.8-1-1.2&spm=0.0.0.0.tFP0ha"//介绍视频地址
        individualDic[kHttpParamKey_RequestFollow_items_wechat] = "wei"//微信号
        individualDic[kHttpParamKey_RequestFollow_items_introduceImgUrl] = "image"//介绍缩略图
        individualDic[kHttpParamKey_RequestFollow_items_introduceDesc] = "biaoti"//介绍标题,描述
        
        let institutionerDic = NSMutableDictionary()
        institutionerDic[kHttpParamKey_RequestFollow_items_investmentUserId] = "2c92808456d910a80156d925a7040008"//投资人id
        institutionerDic[kHttpParamKey_RequestFollow_items_userGroupId] = "2c92808456d910a80156d925a7040008"//投资机构id
        institutionerDic[kHttpParamKey_RequestFollow_items_account] = "2"//投资人账号
        institutionerDic[kHttpParamKey_RequestFollow_items_userName] = "3"//投资人名字
        institutionerDic[kHttpParamKey_RequestFollow_items_avaterUrl] = "q"//投资机构头像
        institutionerDic[kHttpParamKey_RequestFollow_items_domain] = "6"//所属行业
        institutionerDic[kHttpParamKey_RequestFollow_items_phase] = "8"//融资阶段
        institutionerDic[kHttpParamKey_RequestFollow_items_videoUrl] = "9"//机构介绍视频地址
        institutionerDic[kHttpParamKey_RequestFollow_items_wechat] = "6"//微信号
        institutionerDic[kHttpParamKey_RequestFollow_items_companyName] = "6"//公司名字
        institutionerDic[kHttpParamKey_RequestFollow_items_introduceImgUrl] = "6"//介绍缩略图
        institutionerDic[kHttpParamKey_RequestFollow_items_introduceDesc] = "6"//介绍标题,描述
        
        
        diction[kHttpParamKey_RequestFollow_individual] = individualDic
        diction[kHttpParamKey_RequestFollow_provider] = providerDic
        
        //diction[kHttpParamKey_RequestFollow_institutioner] = institutionerDic
        list.addObject(diction)
        
//        let data = try! NSJSONSerialization.dataWithJSONObject(list, options: NSJSONWritingOptions.PrettyPrinted)
//        let strJson = String(data: data,encoding: NSUTF8StringEncoding)
        
        dic[kHttpParamKey_RequestFollow_items] = list
        
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        
        let r:DSHttpRequestFollowResult = cmd.result as! DSHttpRequestFollowResult
        if r.isOk() {
            print()
        }else{
            print()
        }
    }
    

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
