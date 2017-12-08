//
//  DSAccountStatusTest.swift
//  DreamStation
//
//  Created by xjb on 16/9/14.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

class DSAccountStatusTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAccountStatus() {
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:HttpCommand = DSHttpAccountStatusCmd.httpCommandWithVersion(PHttpVersion_v1)
                cmd.completeDelegate = completeDelegate
        
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_AccountStatus_user_id] = "2c928086570874c40157088fd2660004"
        cmd.requestInfo = dic as [NSObject:AnyObject]
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpAccountStatusResult  = cmd.result as! DSHttpAccountStatusResult
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
