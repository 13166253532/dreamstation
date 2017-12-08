//
//  DSHttpSearchProductTest.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/6.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

class DSHttpSearchProductTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchProduct() {
      
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:HttpCommand = DSHttpSearchProductCmd.httpCommandWithVersion(PHttpVersion_v1)
        cmd.completeDelegate = completeDelegate
        
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_SearchProduct_name] = "堵车宝典"
        cmd.requestInfo = dic as [NSObject:AnyObject]
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpSearchProductResult = cmd.result as! DSHttpSearchProductResult
        if r.isOk() {
            
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
