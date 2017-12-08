//
//  DSHttpInstitutionsPutTest.swift
//  DreamStation
//
//  Created by xjb on 16/10/10.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

class DSHttpInstitutionsPutTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInstitutionsPut() {
//       HTHttpConfig.sharedInstance().isout=true
//        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
//        let cmd:HttpCommand = DSHttpInstitutionsPutCmd.httpCommandWithVersion(PHttpVersion_v1)
//        cmd.completeDelegate = completeDelegate
//        
//        //let dic:NSMutableDictionary = NSMutableDictionary()
//     
//        let dic:NSMutableDictionary = NSMutableDictionary()
//        dic[kHttpParamKey_InstitutionsPut_id] = "2c92808456d910a80156d925a7040008"
//        dic[kHttpParamKey_InstitutionsPut_name] = "1"
//        dic[kHttpParamKey_InstitutionsPut_institutionId] = "2"
//        dic[kHttpParamKey_InstitutionsPut_cases] = "3"
//        dic[kHttpParamKey_InstitutionsPut_investMin] = "4"
//        dic[kHttpParamKey_InstitutionsPut_investMax] = "5"
//        
//        dic[kHttpParamKey_InstitutionsPut_cardUrl] = "6"
//        dic[kHttpParamKey_InstitutionsPut_mail] = "7"
//        dic[kHttpParamKey_InstitutionsPut_phone] = "8"
//        dic[kHttpParamKey_InstitutionsPut_wechat] = "9"
//        //dic[kHttpParamKey_InstitutionsPut_linedIn] = "10"
//        dic[kHttpParamKey_InstitutionsPut_job] = "11"
//        
//        
//        cmd.requestInfo = dic as [NSObject:AnyObject]
//        print("url == %@",cmd.getUrl())
//        cmd.execute()
//        completeDelegate.waitForComplete()
//        XCTAssert(cmd.result.isOk())
//        let r:DSHttpInstitutionsPutResult  = cmd.result as! DSHttpInstitutionsPutResult
//        if r.isOk() {
//            
//        }
 
        
        if self.isIncludeChineseIn(nil) {
            print("1")
        }else{
            print("2")
        }
        
    }

    
   
    //MARK:判断是否有汉字
    func isIncludeChineseIn(string: String?) -> Bool {
        if string != nil {
            for (_, value) in string!.characters.enumerate() {
                if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                    return true
                }
            }
        }
        return false
    }
    
    
    
    
    
    
    
    
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
