//
//  DSHttpPleasefocuListTest.swift
//  DreamStation
//
//  Created by xjb on 16/8/25.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

@testable import DreamStation

class DSHttpPleasefocuListTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPleasefocuList() {
        HTHttpConfig.sharedInstance().isout=true
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpPleasefocuListCmd = DSHttpPleasefocuListCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpPleasefocuListCmd
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_PleasefocuList_individualId] = "2c9280845a5eb062015a5f8996660035"//个人投资者
        //dic[kHttpParamKey_PleasefocuList_institutionId] = "2c928085581dc1db01581f3c68c30051"//投资机构
        
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        
        let r:DSHttpPleasefocuListResult = cmd.result as! DSHttpPleasefocuListResult
        if r.isOk() {
            let arr = r.getAllContent()
            for index in 0..<arr.count {
                let info = arr[index] as! DSPleasefocuListInfo
               // print(info.catArray)
                for indexs in 0..<info.catArray.count {
                    let catInfo = info.catArray[indexs] as! DSPleasefocuListCatInfo
                   // print(catInfo.name)
                }
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
