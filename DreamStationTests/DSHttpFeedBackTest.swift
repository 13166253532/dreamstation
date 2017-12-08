//
//  DSHttpFeedBackTest.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/29.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

class DSHttpFeedBackTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFeedBack() {
        
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpFeedBackCmd = DSHttpFeedBackCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpFeedBackCmd
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_FeedBack_fromId] = "2c92808456bc188a0156c0cea4030022"
        dic[kHttpParamKey_FeedBack_fromName] = "13022151215"
        dic[kHttpParamKey_FeedBack_message] = "意见反馈"
        
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        
        let r:DSHttpFeedBackResult = cmd.result as! DSHttpFeedBackResult
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
