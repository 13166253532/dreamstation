//
//  DSHttpAddApplyAccountTest2.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

class DSHttpAddApplyAccountTest2: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddAgencyApplyAccount() {
        
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpAddApplyAccountCmd = DSHttpAddApplyAccountCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpAddApplyAccountCmd
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_AddApplyAccount_user_id] = "2c928085566d8ed701566db4bacf0000"
        dic[kHttpParamKey_AddApplyAccount_role_name] = "PROVIDER"
        dic[kHttpParamKey_AddApplyAccount_applyLogin]="项目方007"
        
        let institutionDic:NSMutableDictionary = NSMutableDictionary()
        institutionDic[kHttpParamKey_AddApplyAccount_institution_company] = "abc公司"
        institutionDic[kHttpParamKey_AddApplyAccount_institution_logo] = "公司LOGO"
        institutionDic[kHttpParamKey_AddApplyAccount_institution_licence] = "abc.com/licence.png"
        institutionDic[kHttpParamKey_AddApplyAccount_institution_phone] = "总机"
        institutionDic[kHttpParamKey_AddApplyAccount_institution_mail] = "邮箱"
        institutionDic[kHttpParamKey_AddApplyAccount_institution_address] = "地址"
        institutionDic[kHttpParamKey_AddApplyAccount_institution_companyInvestMax] = "最大单笔投资"
        institutionDic[kHttpParamKey_AddApplyAccount_institution_companyInvestMin] = "最小单笔投资"
        institutionDic[kHttpParamKey_AddApplyAccount_institution_name] = "投资者名字"
        institutionDic[kHttpParamKey_AddApplyAccount_institution_introduction] = "简介"
        institutionDic[kHttpParamKey_AddApplyAccount_institution_cases] = "过往案例"
        institutionDic[kHttpParamKey_AddApplyAccount_institution_job] = "职务"
        institutionDic[kHttpParamKey_AddApplyAccount_institution_mobilePhone] = "手机"
        institutionDic[kHttpParamKey_AddApplyAccount_institution_individualMail] = "邮箱"
        institutionDic[kHttpParamKey_AddApplyAccount_institution_bussinessCard] = "名片"
        institutionDic[kHttpParamKey_AddApplyAccount_institution_investMin] = "100"
        institutionDic[kHttpParamKey_AddApplyAccount_institution_investMax] = "10000"
        
        let arr=NSMutableArray()
        let catsDic1=NSMutableDictionary()
        catsDic1[kHttpParamKey_AddApplyAccount_institution_cats_catName]="投资币种"
        catsDic1[kHttpParamKey_AddApplyAccount_institution_cats_description]="美元"
        let catsDic2=NSMutableDictionary()
        catsDic2[kHttpParamKey_AddApplyAccount_institution_cats_catName]="所属行业"
        catsDic2[kHttpParamKey_AddApplyAccount_institution_cats_description]="电子商务"
        let catsDic3=NSMutableDictionary()
        catsDic3[kHttpParamKey_AddApplyAccount_institution_cats_catName]="融资阶段"
        catsDic3[kHttpParamKey_AddApplyAccount_institution_cats_description]="天使轮"
        let catsDic4=NSMutableDictionary()
        catsDic4[kHttpParamKey_AddApplyAccount_institution_cats_catName]="所在地区"
        catsDic4[kHttpParamKey_AddApplyAccount_institution_cats_description]="上海"
        let catsDic5=NSMutableDictionary()
        catsDic5[kHttpParamKey_AddApplyAccount_institution_cats_catName]="上过节目"
        catsDic5[kHttpParamKey_AddApplyAccount_institution_cats_description]="是"
        let catsDic6=NSMutableDictionary()
        catsDic6[kHttpParamKey_AddApplyAccount_institution_cats_catName]="投资偏好"
        catsDic6[kHttpParamKey_AddApplyAccount_institution_cats_description]="深度推荐"
        
        arr.addObject(catsDic1)
        arr.addObject(catsDic2)
        arr.addObject(catsDic3)
        arr.addObject(catsDic4)
        arr.addObject(catsDic5)
        arr.addObject(catsDic6)
        
        institutionDic[kHttpParamKey_AddApplyAccount_institution_cats]=arr
        dic[kHttpParamKey_AddApplyAccount_institution]=institutionDic
        
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        
        let r:DSHttpAddApplyAccountResult = cmd.result as! DSHttpAddApplyAccountResult
        if r.isOk() {
            print("success")
        }else{
            print("failed")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
