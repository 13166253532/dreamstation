//
//  DSHttpSMSSendTest.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/5.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

class DSHttpSMSSendTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSMSSend() {
    
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:HttpCommand = DSHttpSMSSendCmd.httpCommandWithVersion(PHttpVersion_v1)
        
        let dict:NSMutableDictionary = NSMutableDictionary()
        dict[kHttpParamKey_SMSSend_phone] = "13022151215"
        dict[kHttpParamKey_SMSSend_templateId] = "PASSWORD"
       
        cmd.requestInfo = dict as [NSObject:AnyObject]
        
        cmd.completeDelegate = completeDelegate
        
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        
        let r:DSHttpSMSSendResult = cmd.result as! DSHttpSMSSendResult
       
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










