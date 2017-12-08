//
//  DSHttpChangePassTest.swift
//  DreamStation
//
//  Created by xjb on 16/8/17.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

class DSHttpChangePassTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testChangePass() {
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpChangePassCmd = DSHttpChangePassCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpChangePassCmd
        
        let dict:NSMutableDictionary = NSMutableDictionary()
        dict[kHttpParamKey_ChangePass_phone] = "13022151215"
        dict[kHttpParamKey_ChangePass_password] = "123321"
        dict[kHttpParamKey_ChangePass_captcha] = "547692"
        cmd.requestInfo = dict as [NSObject : AnyObject]
        
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpChangePassResult = cmd.result as! DSHttpChangePassResult
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
