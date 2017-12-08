//
//  DSHttpAddMessageTest.swift
//  DreamStation
//
//  Created by xjb on 16/9/1.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest
@testable import DreamStation
class DSHttpAddMessageTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAddMessage() {
       
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpAddMessageCmd = DSHttpAddMessageCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpAddMessageCmd
        
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_AddMessage_id] = "2c92808656c5aeb60156c5b4f959000b"
        dic[kHttpParamKey_AddMessage_title] = "MMMMM"
        dic[kHttpParamKey_AddMessage_message] = "444444"
        dic[kHttpParamKey_AddMessage_sort] = "4"
        cmd.requestInfo = dic as [NSObject:AnyObject]
        
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpAddMessageResult = cmd.result as! DSHttpAddMessageResult
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
