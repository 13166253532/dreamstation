//
//  DSHttpIsCollectionsTest.swift
//  DreamStation
//
//  Created by xjb on 16/8/11.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest
@testable import DreamStation
class DSHttpIsCollectionsTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testIsCollections() {
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:HttpCommand=DSHttpIsCollectionsCmd.httpCommandWithVersion(PHttpVersion_v1)
        let dict:NSMutableDictionary=NSMutableDictionary()
        //dict[kHttpParamKey_IsCollections_groupId]="2c928085566e335501566e341e660000"
        dict[kHttpParamKey_IsCollections_collections]="111"
        dict[kHttpParamKey_IsCollections_type]="PARK"
        
        cmd.requestInfo=dict as [NSObject:AnyObject]
        cmd.completeDelegate=completeDelegate
        
        print("url==%@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r = cmd.result as! DSHttpIsCollectionsResult
        if r.isOk() {
        
            let arr = r.getTheContent()
            let listInfo:DSHttpCollectionsListInfo = arr.lastObject as! DSHttpCollectionsListInfo
           print("收藏状态＝"+listInfo.status!)
            
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
