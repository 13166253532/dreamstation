//
//  DSHttpPerInvestmentListTest.swift
//  DreamStation
//
//  Created by xjb on 16/8/10.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest
@testable import DreamStation

class DSHttpPerInvestmentListTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPerInvestmentList() {
        
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpPerInvestmentListCmd = DSHttpPerInvestmentListCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpPerInvestmentListCmd

        
        
        let dic:NSMutableDictionary = NSMutableDictionary()
        let list:NSMutableArray = NSMutableArray()
        
        let dic1:NSMutableDictionary = NSMutableDictionary()
        dic1[kHttpParamKey_PerInvestmentList_Name] = "投资币种"
        dic1[kHttpParamKey_PerInvestmentList_description] = "美元"
        list .addObject(dic1)
        
        let jsonData = try! NSJSONSerialization.dataWithJSONObject(list, options: NSJSONWritingOptions.PrettyPrinted)
        let jsonString:String = String(data: jsonData,encoding: NSUTF8StringEncoding)!
        //dic[kHttpParamKey_PerInvestmentList_query] = jsonString
        dic[kHttpParamKey_PerInvestmentList_page] = "0"
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r = cmd.result as! DSHttpPerInvestmentListResule
        if r.isOk() {
            let arr = r.getAllContent()
            for index in 0..<arr.count {
                let ar:DSPerInvestmentListInfo = arr[index] as! DSPerInvestmentListInfo
//                for index in 0..<ar.cats.count {
//                    let info = ar.cats[index] as! DSAccountsInstituListCatsInfo
//                    print(info.descriptions)
//                }
                print(ar.followNum)
            }
            let list = arr.sortedArrayUsingComparator { (info1, info2) -> NSComparisonResult in
                let info3 = info1
                let info4 = info2
                if info3.followNum < info4.followNum{
                    return NSComparisonResult.OrderedDescending
                }else if info3.followNum > info4.followNum{
                    return NSComparisonResult.OrderedAscending
                }
                return NSComparisonResult.OrderedSame
            }
            for index in 0..<list.count {
                let ar:DSPerInvestmentListInfo = list[index] as! DSPerInvestmentListInfo
                print(ar.followNum)
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
