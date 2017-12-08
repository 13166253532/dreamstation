//
//  DSHttpActivitiesListTest.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/5.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

@testable import DreamStation

class DSHttpActivitiesListTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testActivitiesList() {
     HTHttpConfig.sharedInstance().isout=true
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:HttpCommand = DSHttpActivitiesListCmd.httpCommandWithVersion(PHttpVersion_v1)
//
        let dic = NSMutableDictionary()
        dic[kHttpParamKey_ActivitiesList_sortType] = "ASC"
        dic[kHttpParamKey_ActivitiesList_sortItem] = "sortNumber"
        dic[kHttpParamKey_ActivitiesList_page] = "0"
        cmd.requestInfo = dic as [NSObject:AnyObject]
        
        cmd.completeDelegate = completeDelegate
        
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        
        let r:DSHttpActivitiesListResule = cmd.result as! DSHttpActivitiesListResule
        if r.isOk() {
            
            let arr = r.getAllContent()
            for index in 0..<arr.count {
                let aa:DSActivitiesListInfo = arr[index] as! DSActivitiesListInfo
                print(aa.sortNumber,aa.name)
                
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
