//
//  DSHttpMessageListTest.swift
//  DreamStation
//
//  Created by xjb on 16/9/1.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

@testable import DreamStation

class DSHttpMessageListTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testMessageList() {
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpMessageListCmd = DSHttpMessageListCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpMessageListCmd
        
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpMessageListResult = cmd.result as! DSHttpMessageListResult
        if r.isOk() {
            let arr = r.getTheAllData()
            for index in 0..<arr.count {
                let info = arr[index] as! DSMessageListInfo
                print(info.title)
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
