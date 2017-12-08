//
//  DSHttpProductFollowListTest.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/15.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest
@testable import DreamStation

class DSHttpProductFollowListTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testProductFollowList() {
       
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpProductFollowListCmd = DSHttpProductFollowListCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpProductFollowListCmd
        let dic:NSMutableDictionary = NSMutableDictionary()
        //dic[kHttpParamKey_ProductFollowList_userId] = "2c928086570874c4015708968c270007"
        dic[kHttpParamKey_ProductFollowList_userId] = "2c928086570874c40157088fd2660004"
        
        
        
        //dic[kHttpParamKey_ProductFollowList_userId] = "2c928084568c06db01568c281fae000d"//项目方id
        //dic[kHttpParamKey_ProductFollowList_userId] = "2c928084568c06db01568c281fae000d"//项目id
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        
        let r:DSHttpProductFollowListResult = cmd.result as! DSHttpProductFollowListResult
        if r.isOk() {
            let arr = r.getAllContent()
            for index in 0..<arr.count {
                let aa:DSProductFollowListInfo = arr[index] as! DSProductFollowListInfo
                
            }
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
