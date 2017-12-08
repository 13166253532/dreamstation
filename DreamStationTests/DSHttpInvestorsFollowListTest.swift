//
//  DSHttpInvestorsFollowListTest.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest
@testable import DreamStation

class DSHttpInvestorsFollowListTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInvestorsFollowList() {
    
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:HttpCommand = DSHttpInvestorsFollowListCmd.httpCommandWithVersion(PHttpVersion_v1)
        cmd.completeDelegate = completeDelegate
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_InvestorsFollowList_model] = "INTERVIEW"
        dic[kHttpParamKey_InvestorsFollowList_page] = "0"
        cmd.requestInfo = dic as [NSObject:AnyObject]
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpInvestorsFollowListResult = cmd.result as! DSHttpInvestorsFollowListResult
        if r.isOk(){
            let arr = r.getAllContent()
            //print(arr.count )
            for index in 0..<arr.count {
                let aa:DSInvestorsFollowListInfo = arr[index] as! DSInvestorsFollowListInfo
                //print(aa.productName )
                for index in 0..<aa.categories.count {
                    let info = aa.categories[index] as! DSInvestorsCategoriesInfo
                    print(info.descriptio)
                }
    
                
            }
        }else{
        
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
