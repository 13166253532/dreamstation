//
//  DSHttpApplyProjectChangeTest.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/8.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

class DSHttpApplyProjectChangeTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testApplyProjectChange() {
        
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpApplyProjectChangeCmd = DSHttpApplyProjectChangeCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpApplyProjectChangeCmd
        cmd.completeDelegate = completeDelegate
        
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_ApplyProjectChange_user_id] = "2c928084568c06db01568c281fae000d"
        dic[kHttpParamKey_ApplyProjectChange_role_name] = "PROVIDER"
        dic[kHttpParamKey_ApplyProjectChange_projectId] = "2c928084568c06db01568c3a0f680011"
        
        let projectDic:NSMutableDictionary = NSMutableDictionary()
        let companyDic:NSMutableDictionary = NSMutableDictionary()
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_myName] = "myName"
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_companyName] = "公司"
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_address] = "address"
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_homePage] = "homePage"
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_weichatPublic] = "weichatPublic"
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_job] = "job"
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_individualMail] = "individualMail"
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_weichat] = "weichat"
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_linkedin] = "linkedin"
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_businessCard] = "businessCard"
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_licenceUrl] = "licenceUrl"
        companyDic[kHttpParamKey_ApplyProjectChange_project_company_isOnShow] = true
        projectDic[kHttpParamKey_ApplyProjectChange_project_company] = companyDic
        
        let detailDic:NSMutableDictionary = NSMutableDictionary()
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_amount] = "amount"
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_ratio] = "ratio"
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_brief] = "brief"
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_videoUrl] = "videoUrl"
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_needMoreService] = true
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_needShow] = true
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_needIncubator] = true
        
        detailDic[kHttpParamKey_ApplyProjectChange_project_detail_extractionCode] = "123456"
        projectDic[kHttpParamKey_ApplyProjectChange_project_detail] = detailDic
        
        let catList:NSMutableArray = NSMutableArray()
        let catDic:NSMutableDictionary = NSMutableDictionary()
        catDic[kHttpParamKey_ApplyProjectChange_project_cats_catName] = "catName"
        catDic[kHttpParamKey_ApplyProjectChange_project_cats_description] = "description"
        catList.addObject(catDic)
        projectDic[kHttpParamKey_ApplyProjectChange_project_cats] = catList
        
        projectDic[kHttpParamKey_ApplyProjectChange_project_type] = "PROJECT"
        dic[kHttpParamKey_ApplyProjectChange_project] = projectDic
        
        cmd.requestInfo = dic as [NSObject:AnyObject]
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpApplyProjectChangeResult = cmd.result as! DSHttpApplyProjectChangeResult
        if r.isOk() {
            print("success")
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
