//
//  DSHttpPerProgramsTest.swift
//  DreamStation
//
//  Created by xjb on 16/8/24.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

@testable import DreamStation

class DSHttpPerProgramsTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPerPrograms() {
       HTHttpConfig.sharedInstance().isout=true
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpPerProductsCmd = DSHttpPerProductsCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpPerProductsCmd
        
        let dict:NSMutableDictionary = NSMutableDictionary()
        dict[kHttpParamKey_PerProducts_id] = "2c92808656d4bd1a0156da72ebfd001e"
        //2c92808558bedb070158f0c8771b020a
        cmd.requestInfo = dict as [NSObject : AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpPerProductsResult = cmd.result as! DSHttpPerProductsResult
        if r.isOk() {
            let arr = r.getAllContent()
            for index in 0..<arr.count {
                let info = arr[index] as! DSProductsInfo
                //print(info.companyName!+info.brief!)
              
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
