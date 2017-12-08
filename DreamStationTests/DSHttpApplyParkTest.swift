//
//  DSHttpApplyParkTest.swift
//  DreamStation
//
//  Created by xjb on 16/8/29.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest
@testable import DreamStation
class DSHttpApplyParkTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testApplyPark() {
  
        
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpApplyParkCmd = DSHttpApplyParkCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpApplyParkCmd
        let dic = NSMutableDictionary()
        dic[kHttpParamKey_ApplyPark_name] = "2"
        dic[kHttpParamKey_ApplyPark_parkName] = "2"
        dic[kHttpParamKey_ApplyPark_job] = "2"
        dic[kHttpParamKey_ApplyPark_phoneNum] = "2"
        dic[kHttpParamKey_ApplyPark_mail] = "2"
        cmd.requestInfo = dic as [NSObject : AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpApplyParkResult = cmd.result as! DSHttpApplyParkResult
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
