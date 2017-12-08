//
//  DSHttpCollectionsListTest.swift
//  DreamStation
//
//  Created by xjb on 16/8/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

@testable import DreamStation

class DSHttpCollectionsListTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCollectionsList() {
        let completeDelegate:SMCommandComplete=SMCommandComplete.init()
        let cmd:HttpCommand=DSHttpCollectionsListCmd.httpCommandWithVersion(PHttpVersion_v1)
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r = cmd.result as! DSHttpCollectionListResule
        //2c92808656e362db0156e3ce5a620014
        if r.isOk() {
            let arr = r.getTheContent()
            for index in 0..<arr.count {
             let aa:DSHttpCollectionsListInfo = arr[index] as! DSHttpCollectionsListInfo
            //print("收藏内容＝"+aa.collections!)
            }
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
