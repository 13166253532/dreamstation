//
//  DSHttpAddApplyProjectTest.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/15.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest
@testable import DreamStation

class DSHttpAddApplyProjectTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddApplyProject() {
        HTHttpConfig.sharedInstance().isout=true
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpAddApplyProjectCmd = DSHttpAddApplyProjectCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpAddApplyProjectCmd
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_AddApplyProject_user_id] = "2c928085566d8ed701566db4bacf0000"
        dic[kHttpParamKey_AddApplyProject_role_name] = "PROVIDER"
        dic[kHttpParamKey_AddApplyProject_applyLogin] = "项目方007"
        
        let projectDic:NSMutableDictionary = NSMutableDictionary()
        
        let companyDic:NSMutableDictionary = NSMutableDictionary()
        companyDic[kHttpParamKey_AddApplyProject_project_company_companyName] = "xyz公司"
        companyDic[kHttpParamKey_AddApplyProject_project_company_licenceUrl] = "xyz.com/licence.png"
        companyDic[kHttpParamKey_AddApplyProject_project_company_address] = "上海浦东张江高科"
        companyDic[kHttpParamKey_AddApplyProject_project_company_myName] = "jack"
        companyDic[kHttpParamKey_AddApplyProject_project_company_homePage] = "www.xyz.com"
        companyDic[kHttpParamKey_AddApplyProject_project_company_weichatPublic] = "微信公众号"
        companyDic[kHttpParamKey_AddApplyProject_project_company_businessCard] = "名片"
        companyDic[kHttpParamKey_AddApplyProject_project_company_job] = "职务"
        companyDic[kHttpParamKey_AddApplyProject_project_company_individualMail] = "个人邮箱"
        companyDic[kHttpParamKey_AddApplyProject_project_company_weichat] = "微信"
        companyDic[kHttpParamKey_AddApplyProject_project_company_linkedin] = "linkedin"
        companyDic[kHttpParamKey_AddApplyProject_project_company_isOnShow] = "是"
        projectDic[kHttpParamKey_AddApplyProject_project_company] = companyDic
        
        let detailDic:NSMutableDictionary = NSMutableDictionary()
        detailDic[kHttpParamKey_AddApplyProject_project_detail_amount] = "300"
        detailDic[kHttpParamKey_AddApplyProject_project_detail_ratio] = "8"
        detailDic[kHttpParamKey_AddApplyProject_project_detail_brief] = "测试项目B"
        detailDic[kHttpParamKey_AddApplyProject_project_detail_videoUrl] = "www.xyz.com/video/v.html"
        detailDic[kHttpParamKey_AddApplyProject_project_detail_needMoreService] = "true"
        detailDic[kHttpParamKey_AddApplyProject_project_detail_needShow] = "true"
        detailDic[kHttpParamKey_AddApplyProject_project_detail_needIncubator] = "true"
        detailDic[kHttpParamKey_AddApplyProject_project_detail_extractionCode] = "123456"
        projectDic[kHttpParamKey_AddApplyProject_project_detail] = detailDic
        
        let catsDic1:NSMutableDictionary = NSMutableDictionary()
        catsDic1[kHttpParamKey_AddApplyProject_project_cats_catName] = "投资币种"
        catsDic1[kHttpParamKey_AddApplyProject_project_cats_description] = "美元"
        let catsDic2:NSMutableDictionary = NSMutableDictionary()
        catsDic2[kHttpParamKey_AddApplyProject_project_cats_catName] = "所属行业"
        catsDic2[kHttpParamKey_AddApplyProject_project_cats_description] = "电子商务"
        let catsDic3:NSMutableDictionary = NSMutableDictionary()
        catsDic3[kHttpParamKey_AddApplyProject_project_cats_catName] = "融资阶段"
        catsDic3[kHttpParamKey_AddApplyProject_project_cats_description] = "天使轮"
        let catsDic4:NSMutableDictionary = NSMutableDictionary()
        catsDic4[kHttpParamKey_AddApplyProject_project_cats_catName] = "所在地区"
        catsDic4[kHttpParamKey_AddApplyProject_project_cats_description] = "上海"
        let catsDic5:NSMutableDictionary = NSMutableDictionary()
        catsDic5[kHttpParamKey_AddApplyProject_project_cats_catName] = "上过节目"
        catsDic5[kHttpParamKey_AddApplyProject_project_cats_description] = "是"
        let catsDic6:NSMutableDictionary = NSMutableDictionary()
        catsDic6[kHttpParamKey_AddApplyProject_project_cats_catName] = "投资偏好"
        catsDic6[kHttpParamKey_AddApplyProject_project_cats_description] = "深度推荐"
        
        let catsList:NSMutableArray = NSMutableArray()
        catsList.addObject(catsDic1)
        catsList.addObject(catsDic2)
        catsList.addObject(catsDic3)
        catsList.addObject(catsDic4)
        catsList.addObject(catsDic5)
        catsList.addObject(catsDic6)
        projectDic[kHttpParamKey_AddApplyProject_project_cats] = catsList
        
        dic[kHttpParamKey_AddApplyProject_project] = projectDic
        
        
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        
        let r:DSHttpAddApplyProjectResult = cmd.result as! DSHttpAddApplyProjectResult
        if r.isOk() {
            
            let arr = r.getData()
            let aa:DSAddApplyProjectInfo = arr.lastObject as! DSAddApplyProjectInfo
            print(aa.id)
            print(aa.user_id)
            print(aa.status)
            
        }else{
        
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
