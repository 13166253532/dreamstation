//
//  DSHttpSearchAgencyTest.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/7.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest


@testable import DreamStation

class DSHttpSearchAgencyTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchAgencyTest() {
       
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:HttpCommand = DSHttpSearchAgencyCmd.httpCommandWithVersion(PHttpVersion_v1)
        cmd.completeDelegate = completeDelegate
        
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_SearchAgency_name] = "投资机构"
        dic[kHttpParamKey_SearchAgency_page] = "0"
        cmd.requestInfo = dic as [NSObject:AnyObject]
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpSearchAgencyResult = cmd.result as! DSHttpSearchAgencyResult
        if r.isOk() {
            let list:NSMutableArray = r.getAllAgencyData()
            
            for index in 0..<list.count {
                let ar:DSSearchAgencyInfo = list[index] as! DSSearchAgencyInfo
                for i in 0..<ar.cats!.count {
                    let cats:DSSearchAgencyCats = ar.cats?[i] as! DSSearchAgencyCats
                    if cats.catName == "投资地域" {
                        print(cats.descriptions)
                    }
                }
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
