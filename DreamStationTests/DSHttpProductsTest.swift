//
//  DSHttpProductsTest.swift
//  DreamStation
//
//  Created by QPP on 16/8/5.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

@testable import DreamStation

class DSHttpProductsTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testHttpProducts() {
       // HTHttpConfig.sharedInstance().isout=true
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:HttpCommand = DSHttpProductsCmd.httpCommandWithVersion(PHttpVersion_v1)
        
        let dic:NSMutableDictionary = NSMutableDictionary()
        let list:NSMutableArray = NSMutableArray()
        
        let dic1:NSMutableDictionary = NSMutableDictionary()
        dic1[kHttpParamKey_products_Name] = "所属行业"
        dic1[kHttpParamKey_products_description] = "020"
        list .addObject(dic1)
        
        let jsonData = try! NSJSONSerialization.dataWithJSONObject(list, options: NSJSONWritingOptions.PrettyPrinted)
        let jsonString:String = String(data: jsonData,encoding: NSUTF8StringEncoding)!
        let str = jsonString.stringByReplacingOccurrencesOfString(" ", withString: "")
        let str1 = str.stringByReplacingOccurrencesOfString("\n", withString: "")
        //dic[kHttpParamKey_AccountsInstituList_query] = str1
        
        
        dic[kHttpParamKey_products_page] = "0"
        dic[kHttpParamKey_products_sortType] = "ASC"
        dic[kHttpParamKey_products_sortItem] = "interviewCount"
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpProductsResult = cmd.result as! DSHttpProductsResult
        if r.isOk(){
            let arr:NSMutableArray = r.getAllContent() as NSMutableArray
            print(arr.count)
            for index in 0..<arr.count {
                let info:DSProductsInfo = arr[index] as! DSProductsInfo
                print(info.interviewNum!)
            }
//            //从大到小
//            let list = arr.sortedArrayUsingComparator { (info1, info2) -> NSComparisonResult in
//                let info3 = info1
//                let info4 = info2
//                if info3.interviewNum < info4.interviewNum{
//                    return NSComparisonResult.OrderedDescending
//                }else if info3.interviewNum > info4.interviewNum{
//                    return NSComparisonResult.OrderedAscending
//                }else{
//                    return NSComparisonResult.OrderedSame
//                }
//            }
//            print("------")
//            for index in 0..<list.count {
//                let info:DSProductsInfo = list[index] as! DSProductsInfo
//                print(info.interviewNum!)
//            }
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
