//
//  DSHttpLoginCmd.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/14.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBasePostCmd.h"

@interface DSHttpLoginCmd : SNHttpBasePostCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;

@end

extern NSString *const kHttpParamKey_login_login;
extern NSString *const kHttpParamKey_login_password;

