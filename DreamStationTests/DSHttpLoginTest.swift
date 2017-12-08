//
//  DSHttpLoginTest.swift
//  DreamStation
//
//  Created by QPP on 16/6/16.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

@testable import DreamStation

class DSHttpLoginTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHttpLogin() {
        HTHttpConfig.sharedInstance().isout=true
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:HttpCommand = DSHttpLoginCmd.httpCommandWithVersion(PHttpVersion_v1)
        let dict:NSMutableDictionary = NSMutableDictionary()
        //dict[kHttpParamKey_login_login] = "13022151215"
        // dict[kHttpParamKey_login_password] = "11"
        //dict[kHttpParamKey_login_login] = "投资机构_测试角色_NO_1"
        //dict[kHttpParamKey_login_login] = "13022151215"
        //dict[kHttpParamKey_login_login] = "18221730781"
        ///dict[kHttpParamKey_login_login] = "18221730782"
        dict[kHttpParamKey_login_login] = "18221630903"
        //dict[kHttpParamKey_login_login] = "18221630905"
        dict[kHttpParamKey_login_password] = "123456"
        
        cmd.requestInfo = dict as [NSObject : AnyObject]
        cmd.completeDelegate = completeDelegate
        //print("url==%@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpLoginResult = cmd.result as! DSHttpLoginResult
        if r.isOk(){
            
            print("accessToken:"+r.getAccess_token())
            print("tokenType:"+r.getToken_type())
            print("phone:"+r.getLoginPhone())
            print("id:"+r.getId())
            
            DSAccountInfo.sharedInstance().access_token = r.getAccess_token()
//            DSAccountInfo.sharedInstance().access_type = r.getToken_type()
            
        }else{
            print("failed")
        }
        
        //2c92808656c665800156c66af3070002   2c92808656c665800156c66af3070002
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
