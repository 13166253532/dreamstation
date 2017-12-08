//
//  HTCalendarOrdersInfo.h
//  HiTeacher
//
//  Created by QPP on 16/6/2.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"
@interface HTCalendarOrdersInfo : NSObject
@property NSString *date;
@property NSString *time;
@property NSString *month;
@property NSString *day;
@property NSString *name;
@property NSString *location;
@property NSString *cid;
@property NSString *image;
@property BOOL isAccepted;
@end
@interface NSObject(PrintCalendarOrdersSQL)
+(NSString*)getCalendarOrdersSQL;
@end