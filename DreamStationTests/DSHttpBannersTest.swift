//
//  DSHttpBannersTest.swift
//  DreamStation
//
//  Created by QPP on 16/8/4.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

@testable import DreamStation

class DSHttpBannersTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testHttpBanners() {
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:HttpCommand = DSHttpBannerCmd.httpCommandWithVersion(PHttpVersion_v1)
        cmd.completeDelegate = completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpBannerResult = cmd.result as! DSHttpBannerResult
        if r.isOk(){
            let config:HTHttpConfig = HTHttpConfig.sharedInstance()
            let baseImageUrl:String = config.getServerAddress("")
            let arr=r.getBannerList()
            for index in 0..<arr.count{
                let aa:DSBannerInfo = arr[index] as! DSBannerInfo
                 aa.image = baseImageUrl.stringByAppendingFormat("/resource/view/"+aa.image!)
                //print("videourl:"+aa.video!)
                //print("image:"+aa.image!)
                print("imageUrl:"+aa.image!)
            }
        }else{
            print(r.errMsg)
        }
  
        
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
