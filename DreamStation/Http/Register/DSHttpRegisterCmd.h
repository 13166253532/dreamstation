//
//  DSHttpRegisterCmd.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/13.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBasePostCmd.h"

@interface DSHttpRegisterCmd : SNHttpBasePostCmd

+(HttpCommand *)httpCommandWithVersion:(NSString *)version;

@end

extern NSString *const kHttpParamKey_register_login;
extern NSString *const kHttpParamKey_register_password;
extern NSString *const kHttpParamKey_register_role;
extern NSString *const kHttpParamKey_register_captcha;
