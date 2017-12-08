//
//  DSHttpChangeParkPerInfoTest.swift
//  DreamStation
//
//  Created by xjb on 16/9/21.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

class DSHttpChangeParkPerInfoTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testChangeParkPerInfo() {
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:HttpCommand = DSHttpChangeParkPerInfoCmd.httpCommandWithVersion(PHttpVersion_v1)
        cmd.completeDelegate = completeDelegate
        
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_ChangeParkPerInfo_user_id] = "2c92808557213a19015721434fc80000"
        dic[kHttpParamKey_ChangeParkPerInfo_parkName] = "青青园区"
        dic[kHttpParamKey_ChangeParkPerInfo_parkLogo] = "园区logo"
        dic[kHttpParamKey_ChangeParkPerInfo_licence] = "11"
        dic[kHttpParamKey_ChangeParkPerInfo_officeRent] = false
        dic[kHttpParamKey_ChangeParkPerInfo_investService] = false
        dic[kHttpParamKey_ChangeParkPerInfo_address] = "益达园区地址"
        dic[kHttpParamKey_ChangeParkPerInfo_introducePic] = "222"
        dic[kHttpParamKey_ChangeParkPerInfo_introductionText] = "333"
        dic[kHttpParamKey_ChangeParkPerInfo_incubationCase] = "qqq"
        dic[kHttpParamKey_ChangeParkPerInfo_joinCondition] = "ddd"
        dic[kHttpParamKey_ChangeParkPerInfo_briefIntroduction] = "rrrr"
        dic[kHttpParamKey_ChangeParkPerInfo_vedioUrl] = "www"
        dic[kHttpParamKey_ChangeParkPerInfo_vedioTitle] = "www"
        dic[kHttpParamKey_ChangeParkPerInfo_vedioImg] = "www"
        dic[kHttpParamKey_ChangeParkPerInfo_name] = "hhh"
        dic[kHttpParamKey_ChangeParkPerInfo_job] = "555"
        dic[kHttpParamKey_ChangeParkPerInfo_phone] = ""
        dic[kHttpParamKey_ChangeParkPerInfo_wechat] = "111"
        dic[kHttpParamKey_ChangeParkPerInfo_email] = "222"
        dic[kHttpParamKey_ChangeParkPerInfo_linkdin] = "eee"
        dic[kHttpParamKey_ChangeParkPerInfo_card] = "eee"
        cmd.requestInfo = dic as [NSObject:AnyObject]
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpChangeParkPerInfoResult  = cmd.result as! DSHttpChangeParkPerInfoResult
        if r.isOk() {
           
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
