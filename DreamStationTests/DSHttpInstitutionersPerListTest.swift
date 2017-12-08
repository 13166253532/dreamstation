//
//  DSHttpInstitutionersPerListTest.swift
//  DreamStation
//
//  Created by xjb on 16/8/10.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest
@testable import DreamStation


class DSHttpInstitutionersPerListTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInstitutionersPerList() {
       
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:HttpCommand=DSHttpInstitutionersPerListCmd.httpCommandWithVersion(PHttpVersion_v1)
        let dict:NSMutableDictionary=NSMutableDictionary()
    dict[kHttpParamKey_InstitutionersPerList_institutionId]="2c928084564e03a101564e2e1e23000f"
        cmd.requestInfo=dict as [NSObject:AnyObject]
        cmd.completeDelegate=completeDelegate
        
        print("url==%@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r = cmd.result as! DSHttpInstitutionersPerListResult
        if r.isOk() {

            
        }else{
            print("出错信息"+cmd.result.errMsg)
        }
        
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
