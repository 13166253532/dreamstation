//
//  DSCatsArray.swift
//  DreamStation
//
//  Created by xjb on 2016/11/24.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSCatsArray: NSObject {

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
        var array = NSArray()
        if str.containsString(",") {
            array = str.componentsSeparatedByString(",")
        }else{
           array = [str]
        }
        return array
    }
    
    
}
