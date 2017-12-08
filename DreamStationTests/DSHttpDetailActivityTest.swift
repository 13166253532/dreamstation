//
//  DSHttpDetailActivityTest.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/8.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

@testable import DreamStation

class DSHttpDetailActivityTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDetailActivity() {
       
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpDetailActivityCmd = DSHttpDetailActivityCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpDetailActivityCmd
        
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_DetailActivity_id] = "2c92808656599a62015659cac78c0002"
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        
        let r:DSHttpDetailActivityResult = cmd.result as! DSHttpDetailActivityResult
        if r.isOk() {
            
            let arr = r.getAllData()
            print(arr.name)
            
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
