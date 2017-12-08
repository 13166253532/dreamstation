//
//  DSHttpActivitySignupTest.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

class DSHttpActivitySignupTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testActivitySignup() {
    
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpActivitySignupCmd = DSHttpActivitySignupCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpActivitySignupCmd
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_ActivitySignup_id] = "2c92808656691f010156695c1e080017"
        dic[kHttpParamKey_ActivitySignup_name] = "小明"
        dic[kHttpParamKey_ActivitySignup_phone] = "13211111111"
        dic[kHttpParamKey_ActivitySignup_company] = "顺丰"
        dic[kHttpParamKey_ActivitySignup_landLine] = "122222"
        dic[kHttpParamKey_ActivitySignup_position] = "ddd"
        
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpActivitySignupResult = cmd.result as! DSHttpActivitySignupResult
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
