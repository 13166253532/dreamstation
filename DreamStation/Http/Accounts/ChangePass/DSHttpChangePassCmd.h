//
//  DSHttpChangePassCmd.h
//  DreamStation
//
//  Created by xjb on 16/8/17.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBasePutCmd.h"

@interface DSHttpChangePassCmd : SNHttpBasePutCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_ChangePass_phone;
extern NSString *const kHttpParamKey_ChangePass_password;
extern NSString *const kHttpParamKey_ChangePass_captcha;