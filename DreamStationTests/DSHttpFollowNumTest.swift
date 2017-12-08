//
//  DSHttpFollowNumTest.swift
//  DreamStation
//
//  Created by xjb on 16/8/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

class DSHttpFollowNumTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testFollowNum() {
        let completeDelegate:SMCommandComplete=SMCommandComplete.init()
        let cmd:HttpCommand=DSHttpFollowNumCmd.httpCommandWithVersion(PHttpVersion_v1)
        let dict:NSMutableDictionary=NSMutableDictionary()
        
        dict[kHttpParamKey_Follow_Project_id]="2c92808456e406e30156e49b335c000e"
        cmd.requestInfo=dict as [NSObject:AnyObject]
        cmd.completeDelegate=completeDelegate
        
        print("url==%@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        if (cmd.result.isOk()){
            let r=cmd.result as! DSHttpFollowNumResule
            print("num:"+r.getTheCount())
        }else{
            print("出错信息"+cmd.result.errMsg)
        }

    
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
