//
//  DSHttpApplyAccountChangeTest.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/31.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

class DSHttpApplyAccountChangeTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testApplyAccountChange() {
       
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpApplyAccountChangeCmd = DSHttpApplyAccountChangeCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpApplyAccountChangeCmd
        
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_ApplyAccountChange_user_id] = "2c92808557412ff1015741433d250021"
        dic[kHttpParamKey_ApplyAccountChange_role_name] = "INDIVIDUAL"
        dic[kHttpParamKey_ApplyAccountChange_applyLogin] = "18221730786"
        
        let tionDic:NSMutableDictionary = NSMutableDictionary()
        tionDic[kHttpParamKey_ApplyAccountChange_institution_id] = "2c92808557412ff1015741433d250021"
        tionDic[kHttpParamKey_ApplyAccountChange_institution_name] = "谢伟东"
        tionDic[kHttpParamKey_ApplyAccountChange_institution_idCardFrontUrl] = "a0b8568d-dc65-4bb4-aabe-c9b09edcfe22.jpg"
        tionDic[kHttpParamKey_ApplyAccountChange_institution_idCardBackUrl] = "a0b8568d-dc65-4bb4-aabe-c9b09edcfe22.jpg"
        tionDic[kHttpParamKey_ApplyAccountChange_institution_individualPropertyUrl] = "a0b8568d-dc65-4bb4-aabe-c9b09edcfe22.jpg"
        tionDic[kHttpParamKey_ApplyAccountChange_institution_card_no] = "a0b8568d-dc65-4bb4-aabe-c9b09edcfe22.jpg"
        tionDic[kHttpParamKey_ApplyAccountChange_institution_investMin] = "1"
        tionDic[kHttpParamKey_ApplyAccountChange_institution_investMax] = "5"
        tionDic[kHttpParamKey_ApplyAccountChange_institution_introduction] = "简介"
        tionDic[kHttpParamKey_ApplyAccountChange_institution_wechat] = "谢微信"
        tionDic[kHttpParamKey_ApplyAccountChange_institution_avatar] = ""
        tionDic[kHttpParamKey_ApplyAccountChange_institution_cases] = "1过往案例"
        let list:NSMutableArray = NSMutableArray()
        tionDic[kHttpParamKey_ApplyAccountChange_institution_cats] = list
        dic[kHttpParamKey_ApplyAccountChange_institution] = tionDic
        cmd.requestInfo = dic as [NSObject:AnyObject]
        
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpApplyAccountChangeResult = cmd.result as! DSHttpApplyAccountChangeResult
        if r.isOk() {
            print("success")
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
