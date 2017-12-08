//
//  DSHttpApplyParkChangeTest.swift
//  DreamStation
//
//  Created by xjb on 16/9/19.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

@testable import DreamStation

class DSHttpApplyParkChangeTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testApplyParkChange() {
        
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpApplyParkChangeCmd = DSHttpApplyParkChangeCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpApplyParkChangeCmd
        

        //cmd.requestInfo = dict as [NSObject : AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpApplyParkChangeResult = cmd.result as! DSHttpApplyParkChangeResult
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
