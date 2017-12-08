//
//  DSHttpGetPersonAccountTest.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/30.
//  Copyright © 2016年 QPP. All rights reserved.
//

import XCTest

@testable import DreamStation

class DSHttpGetPersonAccountTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetPersonAccount() {
        let completeDelegate:SMCommandComplete = SMCommandComplete.init()
        let cmd:DSHttpGetPersonAccountCmd = DSHttpGetPersonAccountCmd.httpCommandWithVersion(PHttpVersion_v1) as! DSHttpGetPersonAccountCmd
        
        let dic:NSMutableDictionary = NSMutableDictionary()
        //dic[kHttpParamKey_GetPersonAccount_person_id] = "2c928086570874c40157089cfdef000a"
        dic[kHttpParamKey_GetPersonAccount_person_id] = "2c928086593a086301593a4d839b0015"
        cmd.requestInfo = dic as [NSObject:AnyObject]
        cmd.completeDelegate = completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
        completeDelegate.waitForComplete()
        XCTAssert(cmd.result.isOk())
        let r:DSHttpGetPersonAccountResult = cmd.result as! DSHttpGetPersonAccountResult
        if r.isOk(){
            let arr = r.getAllData()
            let info:DSGetPersonAccountInfo = arr.lastObject as! DSGetPersonAccountInfo
            //print(info.park?.introducePic)
            //let imageArray = info.park?.introducePic?.componentsSeparatedByString(";")
//            for index in 0..<imageArray!.count {
//                //print(imageArray![index])
//            }
            
            
//            let list = self.imageArray(info.park?.introducePic)
//            for index in 0..<list!.count {
//                print(list![index])
//            }
            
//            for index in 0...(info.institution?.cats?.count)!-1 {
//               let cat = info.institution?.cats![index] as! DSGetPersonAccountCatsInfo
//                //print(cat.catName)
//            }
//            let list = info.institution?.partners
//            
//            if list?.count != 0 {
//                for index in 0...(list?.count)!-1 {
//                    let cat = info.institution?.partners![index] as! DSGetPersonAccountPartnersInfo
//                    print(cat.name)
//                }
//            }

//            let sss = self.getDomainPhase(info.institutioner?.cats, shaiString: "投资地域")
//            print(sss)
           
            
        }else{
            print("failed")
        }
    }
    func imageArray(httpStr:String?)->(NSMutableArray?){
        let list = NSMutableArray()
        
        if self.isIncludeChineseIn(httpStr!) != true {
            let imageArray = httpStr!.componentsSeparatedByString(";")
            for index in 0..<imageArray.count {
                let imageUrl = HTHttpConfig.sharedInstance().getServerAddress("").stringByAppendingFormat("/resource/view/"+imageArray[index])
                list .addObject(imageUrl)
            }
            return list
        }else{
            return nil
        }
    }
    
    func getDomainPhase(catList:NSMutableArray?,shaiString:String!) -> (String) {
        var str:String?
        for index in 0...(catList?.count)!-1 {
            let catInfo = catList![index] as! DSGetPersonAccountCatsInfo
            if catInfo.catName == shaiString {
                if str != nil {
                    str = str!+" "+catInfo.descriptions!
                }else{
                    str = catInfo.descriptions!
                }
            }
        }
        return str!
    }
    //MARK:是否有汉字
    func isIncludeChineseIn(string: String) -> Bool {
        for (_, value) in string.characters.enumerate() {
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
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
