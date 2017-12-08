//
//  DSHttpMyActivityTest.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/8.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

@testable import DreamStation

class DSHttpMyActivityTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMyActivity() {
       
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpMyActivityCmd = DSHttpMyActivityCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpMyActivityCmd
        
        print("url == %@",cmd.getUrl())
        cmd.completeDelegate = completeDelegate
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpMyActivityResult = cmd.result as! DSHttpMyActivityResult
        if r.isOk() {
            let arr = r.getAllContent()
            for index in 0..<arr.count {
                let aa:DSMyActivityInfo = arr[index] as! DSMyActivityInfo
                print(aa.id)
            }
        }else{
            print("++failed")
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
