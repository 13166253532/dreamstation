//
//  DSHttpParkListTest.swift
//  DreamStation
//
//  Created by xjb on 16/8/22.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest
@testable import DreamStation

class DSHttpParkListTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testParkList() {

        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpParkListCmd = DSHttpParkListCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpParkListCmd
        
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpParkListResult = cmd.result as! DSHttpParkListResult
        if r.isOk() {
            let arr = r.getAllContents()
            
            print(arr.count)
            for index in 0..<arr.count {
                let info = arr[index] as! DSParkListinfo
                print(info.address)
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
