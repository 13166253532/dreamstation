//
//  DSHttpCollectionTest.swift
//  DreamStation
//
//  Created by xjb on 16/8/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

@testable import DreamStation

class DSHttpCollectionTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCollection() {
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpCollectionCmd = DSHttpCollectionCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpCollectionCmd
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_Collection_userGroupId] = "1112"
        dic[kHttpParamKey_Collection_collections] = "11112"
        dic[kHttpParamKey_Collection_collectionsType] = "PARK"
        dic[kHttpParamKey_Collection_username] = "sssss"
        let contentDic:NSMutableDictionary = NSMutableDictionary()
        contentDic[kHttpParamKey_Collection_collectionsContent_id] = "111";
        contentDic[kHttpParamKey_Collection_collectionsContent_titleName] = "22";
        contentDic[kHttpParamKey_Collection_collectionsContent_typeTag] = "33";
        contentDic[kHttpParamKey_Collection_collectionsContent_videoUrl] = "44";
        contentDic[kHttpParamKey_Collection_collectionsContent_favoriteNotes] = "55";
        contentDic[kHttpParamKey_Collection_collectionsContent_level] = "66";
        let data = try! NSJSONSerialization.dataWithJSONObject(contentDic, options: NSJSONWritingOptions.PrettyPrinted)
        let strJson = String(data: data,encoding: NSUTF8StringEncoding)
        print(strJson!)
        dic[kHttpParamKey_Collection_collectionsContent]=strJson!
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpCollectionResult = cmd.result as! DSHttpCollectionResult
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
