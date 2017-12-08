//
//  DSHttpSecreenParkCityListTest.swift
//  DreamStation
//
//  Created by xjb on 2016/11/28.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

class DSHttpSecreenParkCityListTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSecreenParkCityList() {
        HTHttpConfig.sharedInstance().isout=true
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:HttpCommand = DSParkScreenCityListCmd.httpCommandWithVersion(PHttpVersion_v1)
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSParkScreenCityListResult  = cmd.result as! DSParkScreenCityListResult
        if r.isOk() {
            let arr:NSMutableArray = r.getScreenCityList()
            for index in 0..<arr.count {
                print(arr[index])
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        //self.measure {
            // Put the code you want to measure the time of here.
        //}
    }
    
}
