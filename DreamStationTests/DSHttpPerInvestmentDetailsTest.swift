//
//  DSHttpPerInvestmentDetailsTest.swift
//  DreamStation
//
//  Created by xjb on 16/8/10.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest
@testable import DreamStation


class DSHttpPerInvestmentDetailsTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPerInvestmentDetails() {
    
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:HttpCommand=DSHttpPerInvestmentDetailsCmd.httpCommandWithVersion(PHttpVersion_v1)
        let dict:NSMutableDictionary=NSMutableDictionary()
        dict[kHttpParamKey_PerInvestmentDetails_user_id]="2c928086570874c40157089cfdef000a"
        cmd.requestInfo=dict as [NSObject:AnyObject]
        cmd.completeDelegate=completeDelegate
        
        print("url==%@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r = cmd.result as! DSHttpPerInvestmentDetailsResult
        if r.isOk() {
//            let arr = r.getAllContent()
//            let ar:DSPerInvestmentListInfo = arr[0] as! DSPerInvestmentListInfo
//            print("个人投资者的ID＝"+ar.id!)
            
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
