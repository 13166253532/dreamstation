//
//  DSHttpPostStatisticsTest.swift
//  DreamStation
//
//  Created by xjb on 16/9/13.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest
@testable import DreamStation
class DSHttpPostStatisticsTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPostStatistics() {
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:HttpCommand = DSHttpPostStatisticsCmd.httpCommandWithVersion(PHttpVersion_v1)
        cmd.completeDelegate = completeDelegate
        
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_PostStatistics_userId] = "2c928084568c06db01568c281fae000d"
        dic[kHttpParamKey_PostStatistics_targetId] = "2c928086570874c40157089cfdef000a"
        cmd.requestInfo = dic as [NSObject:AnyObject]
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpPostStatisticsResult  = cmd.result as! DSHttpPostStatisticsResult
        if r.isOk() {
            
        }


    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
