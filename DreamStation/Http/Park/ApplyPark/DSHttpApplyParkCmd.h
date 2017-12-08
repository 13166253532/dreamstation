//
//  DSHttpApplyParkCmd.h
//  DreamStation
//
//  Created by xjb on 16/8/29.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBasePostCmd.h"

@interface DSHttpApplyParkCmd : SNHttpBasePostCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_ApplyPark_name;
extern NSString *const kHttpParamKey_ApplyPark_parkName;
extern NSString *const kHttpParamKey_ApplyPark_job;
extern NSString *const kHttpParamKey_ApplyPark_phoneNum;
extern NSString *const kHttpParamKey_ApplyPark_mail;