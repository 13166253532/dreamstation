//
//  DSHttpSettingModifyPasswordTest.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/26.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

class DSHttpSettingModifyPasswordTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSettingModifyPassword() {
       
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpSettingModifyPasswordCmd = DSHttpSettingModifyPasswordCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpSettingModifyPasswordCmd
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_SettingModifyPassword_password] = "123456"
        cmd.requestInfo = dic as [NSObject:AnyObject]
        
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpSettingModifyPasswordResult = cmd.result as! DSHttpSettingModifyPasswordResult
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
