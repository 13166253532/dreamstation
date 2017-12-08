//
//  DSHttpProductsDetailsTest.swift
//  DreamStation
//
//  Created by xjb on 16/8/15.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

@testable import DreamStation

class DSHttpProductsDetailsTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testProductsDetails() {
       //HTHttpConfig.sharedInstance().isout=true
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpProductsDetailsCmd = DSHttpProductsDetailsCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpProductsDetailsCmd
        let dic:NSMutableDictionary = NSMutableDictionary()


        dic[kHttpParamKey_productsDetails_id] = "2c92808656d4bd1a0156da72ebfd001e"

       // dic[kHttpParamKey_productsDetails_id] = "2c92808656c665800156d3f9a190000b"


        //dic[kHttpParamKey_productsDetails_id] = "2c92808656c665800156d3f9a190000b"

        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        
        let r:DSHttpProductsDetailsResult = cmd.result as! DSHttpProductsDetailsResult
        if r.isOk() {
            let arr = r.getAllContent()
            let aa:DSProductsDetailsInfo = arr[0] as! DSProductsDetailsInfo
            print(aa.cat)
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
