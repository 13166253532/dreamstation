//
//  DSHttpAccountsInstituListTest.swift
//  DreamStation
//
//  Created by xjb on 16/8/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest
@testable import DreamStation
class DSHttpAccountsInstituListTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAccountsInstituList() {
         HTHttpConfig.sharedInstance().isout=true
        let completeDelegate:SMCommandComplete=SMCommandComplete.init()
        let cmd:HttpCommand=DSHttpAccountsInstituListCmd.httpCommandWithVersion(PHttpVersion_v1)
        let dic:NSMutableDictionary = NSMutableDictionary()
        let list:NSMutableArray = NSMutableArray()
        
        let dic1:NSMutableDictionary = NSMutableDictionary()
        dic1[kHttpParamKey_AccountsInstituList_Name] = "投资领域"
        dic1[kHttpParamKey_AccountsInstituList_description] = "全部"
        list .addObject(dic1)
//        
//        let jsonData = try! NSJSONSerialization.dataWithJSONObject(list, options: NSJSONWritingOptions.PrettyPrinted)
//        let jsonString:String = String(data: jsonData,encoding: NSUTF8StringEncoding)!
//        let str = jsonString.stringByReplacingOccurrencesOfString(" ", withString: "")
//        let str1 = str.stringByReplacingOccurrencesOfString("\n", withString: "")
        //dic[kHttpParamKey_AccountsInstituList_query] = jsonString
        //dic[kHttpParamKey_AccountsInstituList_page] = "0"
        //dic[kHttpParamKey_AccountsInstituList_sortType] = "DESC"
        //dic[kHttpParamKey_AccountsInstituList_sortItem] = "followCount"
        
        cmd.requestInfo = dic as [NSObject:AnyObject]
        
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r = cmd.result as! DSHttpAccountsInatituListResule
        if r.isOk() {
             let arr = r.getAllContent()
            for index in 0..<arr.count {
                let ar:DSAccountsInstituListInfo = arr[index] as! DSAccountsInstituListInfo
                //print("公司的ID＝"+ar.interviewNum!)
//                for i in 0..<(ar.cats?.count)! {
//                    //let cats:DSAccountsInstituListCatsInfo = ar.cats?[i] as! DSAccountsInstituListCatsInfo
//                    //print(cats.catName!+"  "+cats.descriptions!)
//                }
            }
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
