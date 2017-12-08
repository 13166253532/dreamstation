//
//  HTConfigTimeFounction.swift
//  HiTeacher
//
//  Created by QPP on 16/5/24.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

//时间戳转换
func timeStampToString(timeStamp:String)->String {
    
    let string = NSString(string: timeStamp)
    
    let timeSta:NSTimeInterval = string.doubleValue/1000
    let dfmatter = NSDateFormatter()
    dfmatter.dateFormat="M/d HH:mm"
    dfmatter.locale = NSLocale(localeIdentifier: "en_US")
    
    let date = NSDate(timeIntervalSince1970: timeSta)
    
    print(dfmatter.stringFromDate(date))
    return dfmatter.stringFromDate(date)
}

func yearTimeStampToString(timeStamp:String)->String {
    
    let string = NSString(string: timeStamp)
    
    let timeSta:NSTimeInterval = string.doubleValue/1000
    let dfmatter = NSDateFormatter()
    dfmatter.dateFormat="yyyy-MM-dd"
    dfmatter.locale = NSLocale(localeIdentifier: "en_US")
    
    let date = NSDate(timeIntervalSince1970: timeSta)
    
    print(dfmatter.stringFromDate(date))
    return dfmatter.stringFromDate(date)
}





func hourStampToString(timeStamp:String)->String {
    
    let string = NSString(string: timeStamp)
    
    let timeSta:NSTimeInterval = string.doubleValue/1000
    let dfmatter = NSDateFormatter()
    dfmatter.dateFormat="HH:mm"
    dfmatter.locale = NSLocale(localeIdentifier: "en_US")
    let date = NSDate(timeIntervalSince1970: timeSta)
    
    print(dfmatter.stringFromDate(date))
    return dfmatter.stringFromDate(date)
}

func getNowDateWithWeek()->String{
    let date: NSDate = NSDate()
    let matter = NSDateFormatter()
    matter.dateFormat = "MM-dd EEEE"
    matter.locale = NSLocale(localeIdentifier: "en_US")
    let nowTime = "Today, "+matter.stringFromDate(date) as String
    
    return nowTime
}


func getDateString(date:NSDate)->String{
    let matter = NSDateFormatter()
    matter.dateFormat = "yyyy-MM-dd"
    matter.locale = NSLocale(localeIdentifier: "en_US")
    let nowTime = matter.stringFromDate(date) as String
    
    return nowTime
}

func getMonth(date:NSDate)->String{
    let matter = NSDateFormatter()
    matter.dateFormat = "MMMM"
    matter.locale = NSLocale(localeIdentifier: "en_US")
    let nowTime = matter.stringFromDate(date) as String
    
    return nowTime
}




func getNowDate()->String{
    let date: NSDate = NSDate()
    let matter = NSDateFormatter()
    matter.dateFormat = "yyyy-MM-dd"
    let nowTime = matter.stringFromDate(date) as String
    return nowTime
}



func getFetureDate(count:Int)->String{
    let now = NSDate()
    let calendar = NSCalendar.currentCalendar()
    let startComponents = calendar.components([NSCalendarUnit.Year,.Month,.Day,.Weekday], fromDate: now)
    startComponents.day += count
    let weekendDate = calendar.dateFromComponents(startComponents)
    let matter = NSDateFormatter()
    matter.dateFormat = "yyyy-MM-dd"
    let nowTime = matter.stringFromDate(weekendDate!) as String
    return nowTime;
}

func getTodayYearAndMonth()->String {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy.MM"
    return dateFormatter.stringFromDate(NSDate())
}



