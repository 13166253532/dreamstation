//
//  DSHttpActivitySignupCmd.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/8.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBasePostCmd.h"

@interface DSHttpActivitySignupCmd : SNHttpBasePostCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end

extern NSString *const kHttpParamKey_ActivitySignup_id;

extern NSString *const kHttpParamKey_ActivitySignup_name;
extern NSString *const kHttpParamKey_ActivitySignup_account;
extern NSString *const kHttpParamKey_ActivitySignup_phone;
extern NSString *const kHttpParamKey_ActivitySignup_company;
extern NSString *const kHttpParamKey_ActivitySignup_position;
extern NSString *const kHttpParamKey_ActivitySignup_landLine;