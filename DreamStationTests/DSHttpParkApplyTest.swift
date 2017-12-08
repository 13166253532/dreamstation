//
//  DSHttpParkApplyTest.swift
//  DreamStation
//
//  Created by xjb on 16/9/14.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

@testable import DreamStation

class DSHttpParkApplyTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParkApply() {
        
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpParkApplyCmd = DSHttpApplyParkCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpParkApplyCmd
        let dic = NSMutableDictionary()
        dic[kHttpParamKey_ParkApply_phone] = "18221630904"//手机号
        dic[kHttpParamKey_ParkApply_name] = "林海荣"//姓名
        dic[kHttpParamKey_ParkApply_company] = "上海房真真信息技术有限公司1"//公司名字
        dic[kHttpParamKey_ParkApply_title] = "小项目"//项目名字
        dic[kHttpParamKey_ParkApply_parkId] = "2c928085570e6d1a01570e7388830000"//园区id
        dic[kHttpParamKey_ParkApply_projectId] = "2c92808456e406e30156e49b335c000e"//项目id

        cmd.requestInfo = dic as [NSObject : AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpParkApplyResult = cmd.result as! DSHttpParkApplyResult
        if r.isOk() {
            
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
