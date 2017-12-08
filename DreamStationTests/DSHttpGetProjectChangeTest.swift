//
//  DSHttpGetProjectChangeTest.swift
//  DreamStation
//
//  Created by xjb on 2016/12/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

@testable import DreamStation

class DSHttpGetProjectChangeTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetProjectChange() {
        HTHttpConfig.sharedInstance().isout=true
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:HttpCommand = DSHttpGetProjectChangeCmd.httpCommandWithVersion(PHttpVersion_v1)
        cmd.completeDelegate = completeDelegate
        
        
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_GetProjectChange_status] = "CHECKING"
        dic[kHttpParamKey_GetProjectChange_login] = "18221630793"
        dic[kHttpParamKey_GetProjectChange_type] = "PROJECT"
        
        cmd.requestInfo = dic as [NSObject:AnyObject]
        
        
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpGetProjectChangeResule  = cmd.result as! DSHttpGetProjectChangeResule
        if r.isOk() {
            let arr:NSMutableArray = r.getProjectData()
            for index in 0..<arr.count {
                let info:DSGetProjectChangeInfo = arr[index] as! DSGetProjectChangeInfo
                print(info.message.cats.count)
            }
            
        }

        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
       
    }
    
}
