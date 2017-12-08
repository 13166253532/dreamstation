//
//  HTCitiesListInfo.h
//  HiTeacher
//
//  Created by dmshi on 16/5/24.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"
@interface HTCitiesListInfo : NSObject
@property NSString *id;
@property NSString *cityEnglish;
@property NSString *cityChinese;
@property NSString *cityCode;
@end

@interface NSObject(PrintCitiesListSQL)
+(NSString*)getCitiesListSQL;
@end