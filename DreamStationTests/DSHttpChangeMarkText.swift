//
//  DSHttpChangeMarkText.swift
//  DreamStation
//
//  Created by xjb on 2016/12/27.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

@testable import DreamStation

class DSHttpChangeMarkText: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testChangeMark() {
        HTHttpConfig.sharedInstance().isout=true
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:HttpCommand = DSHttpChangeMarkCmd.httpCommandWithVersion(PHttpVersion_v1)
        cmd.completeDelegate = completeDelegate
        
        
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_ChangeMark_id] = "2c92808458f71dbd0158f78ad7c000a2"
        dic[kHttpParamKey_ChangeMark_mark] = "18221630793"
    //2c92808458f71dbd0158f78ad7c000a2
        //2c92808458f71dbd0158f73558e50006
        cmd.requestInfo = dic as [NSObject:AnyObject]
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpChangeMarkRecule  = cmd.result as! DSHttpChangeMarkRecule
        if r.isOk() {
            
        }
            
    }

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
    }
    
}
