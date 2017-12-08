//
//  DSHttpIsFollowTest.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

class DSHttpIsFollowTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIsFollow() {
        
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:HttpCommand = DSHttpIsFollowCmd.httpCommandWithVersion(PHttpVersion_v1)
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_IsFollow_model] = "FOLLOW"
        
        //dic[kHttpParamKey_IsFollow_investorId] = "2c92808456e406e30156e4c101b10025"//投资者ID
       dic[kHttpParamKey_IsFollow_investmentId] = "2c92808456e406e30156e4d1dedf002e"//投资机构
       dic[kHttpParamKey_IsFollow_productUserId] = "2c92808456e406e30156e496b8f0000c"//项目UserId
       dic[kHttpParamKey_IsFollow_productId] = "2c92808456e406e30156e49b335c000e"//项目ID
        
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpIsFollowResult = cmd.result as! DSHttpIsFollowResult
        if r.isOk() {
            print(r.getAllContent())
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
