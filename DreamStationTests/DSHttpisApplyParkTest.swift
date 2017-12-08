//
//  DSHttpisApplyParkTest.swift
//  DreamStation
//
//  Created by xjb on 16/9/14.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

class DSHttpisApplyParkTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testsisApplyPark() {
        
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpisApplyParkCmd = DSHttpisApplyParkCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpisApplyParkCmd
        let dic = NSMutableDictionary()
        dic[kHttpParamKey_isApplyPark_projectId] = "2c92808456e406e30156e49b335c000e"//项目id
        dic[kHttpParamKey_isApplyPark_parkId] = "2c928085570e6d1a01570e7388830000"//园区id
        cmd.requestInfo = dic as [NSObject : AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpisApplyParkResult = cmd.result as! DSHttpisApplyParkResult
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
