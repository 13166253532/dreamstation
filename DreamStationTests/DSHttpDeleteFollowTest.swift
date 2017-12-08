//
//  DSHttpDeleteFollowTest.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

class DSHttpDeleteFollowTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDeleteFollow() {
     
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:HttpCommand = DSHttpDeleteFollowCmd.httpCommandWithVersion(PHttpVersion_v1)
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_DeleteFollow_id] = "2c928084567da6bc01567db5a5320002"
        dic[kHttpParamKey_DeleteFollow_itemId] = "2c928084567da6bc01567db5a5320003"
        
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r = cmd.result as! DSHttpDeleteFollowResult
        if r.isOk() {
            
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
