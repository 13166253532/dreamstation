//
//  DSHttpSMSVerifyTest.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/5.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

class DSHttpSMSVerifyTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSMSVerify() {
        
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:HttpCommand = DSHttpSMSVerifyCmd.httpCommandWithVersion(PHttpVersion_v1)
        let dict:NSMutableDictionary = NSMutableDictionary()
        dict[kHttpParamKey_SMSVerify_phone] = "18111111126"
        dict[kHttpParamKey_SMSVerify_captcha] = "1"
        
        cmd.requestInfo = dict as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        
        let r:DSHttpSMSVerifyResult = cmd.result as! DSHttpSMSVerifyResult
        
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
