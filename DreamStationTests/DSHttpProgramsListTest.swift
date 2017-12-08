//
//  DSHttpProgramsListTest.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest
@testable import DreamStation

class DSHttpProgramsListTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testProgramsList() {
       //HTHttpConfig.sharedInstance().isout=true
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpProgramsListCmd = DSHttpProgramsListCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpProgramsListCmd
       
        let dic:NSMutableDictionary = NSMutableDictionary()
        //dic[kHttpParamKey_ProgramsList_type] = "HOME"
        dic[kHttpParamKey_ProgramsList_type] = "PARK"
        dic[kHttpParamKey_ProgramsList_page] = "0"
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        
        let r:DSHttpProgramsListResult = cmd.result as! DSHttpProgramsListResult
        if r.isOk() {
            let arr = r.getAllContent()
            for index in 0..<arr.count {
                let aa:DSProgramsListInfo = arr[index] as! DSProgramsListInfo
                print(aa.text)
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
