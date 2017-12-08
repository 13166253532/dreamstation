//
//  HTCountryListInfo.h
//  HiTeacher
//
//  Created by QPP on 16/6/21.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"
@interface HTCountryListInfo : NSObject
@property NSString *countryCode;
@property NSString *countryChinese;
@property NSString *countryEnglish;
@end
@interface NSObject(PrintCountryListSQL)
+(NSString*)getCountryListSQL;
@end