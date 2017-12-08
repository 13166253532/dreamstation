//
//  DSHttpUploadFileTest.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/24.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

class DSHttpUploadFileTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUploadFile() {
    
        let completeDelegate:SMCommandComplete=SMCommandComplete.init()
        let cmd:DSHttpUploadFileCmd=DSHttpUploadFileCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpUploadFileCmd
        
        let image=UIImage(named: "homePage_activityImage")
        cmd.fileName="test.jpg"
        cmd.keyName="file"
        cmd.fileData=UIImagePNGRepresentation(image!)
        
        
        cmd.completeDelegate=completeDelegate
        
        print("url==%@",cmd.getUrl())
        cmd.execute()
        completeDelegate .waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpUploadFileResult=cmd.result as! DSHttpUploadFileResult
        if (cmd.result.isOk()){
            print("success")
            print(r.getAvatarUrl())
            print(r.getSuffix())
            print(r.getUuid())
            
        }

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
