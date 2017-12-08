//
//  DSHttpRegisterTest.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/14.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

@testable import DreamStation


class DSHttpRegisterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testHttpRegisterTest() {
        
//        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
//        let cmd:HttpCommand = DSHttpRegisterCmd.httpCommandWithVersion(PHttpVersion_v1)
//        let dict:NSMutableDictionary=NSMutableDictionary()
//        dict[kHttpParamKey_register_login] = "18111111029"
//        dict[kHttpParamKey_register_password] = "123456"
//        dict[kHttpParamKey_register_role] = "PROVIDER"
//        dict[kHttpParamKey_register_captcha] = "658294"
//        cmd.requestInfo = dict as [NSObject:AnyObject]
//        cmd.completeDelegate = completeDelegate
//        print("url==%@",cmd.getUrl())
//        cmd.execute()
//        completeDelegate.waitForComplete()
//        
//        XCTAssert(cmd.result.isOk())
//        let r:DSHttpRegisterResult = cmd.result as! DSHttpRegisterResult
//        if r.isOk() {
//            
//            print("accessToken:"+r.getAccessToken())
//            //print("tokenType:"+r.getTokenType())
//            //print("refreshToken:"+r.getPersonPhone())
//            print("id:"+r.getId())
//            
//        }else{
//            print(cmd.result.errMsg)
//        }
       
        let dict = NSMutableDictionary()
        let array = NSMutableArray()
        dict["catName"] = "关注领域"
        dict["description"] = "企业服务,电子商务,金融"
        array .addObject(dict)
        array .addObject(dict)
        let cats = DSCatsArray()
        print(cats.updateCats(array))
}

    func updateCats(catsArray:NSMutableArray)->(NSMutableArray){
        let newArray = NSMutableArray()
        for index in 0..<catsArray.count {
            let dict:NSMutableDictionary = catsArray[index] as! NSMutableDictionary
            let deacArray:NSArray = self.strArray(dict["description"] as! String)
            for indext in 0..<deacArray.count {
                let newDict = NSMutableDictionary()
                newDict["catName"] = dict["catName"]
                newDict["description"] = deacArray[indext] as! String
                newArray .addObject(newDict)
            }
        }
        return newArray
    }
    
    func strArray(str:String) -> (NSArray) {
        let array:NSArray = str.componentsSeparatedByString(",")
        return array
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
