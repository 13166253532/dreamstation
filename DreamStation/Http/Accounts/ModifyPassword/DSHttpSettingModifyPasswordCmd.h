//
//  DSHttpSettingModifyPasswordCmd.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/26.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBasePutCmd.h"

@interface DSHttpSettingModifyPasswordCmd : SNHttpBasePutCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end

extern NSString *const kHttpParamKey_SettingModifyPassword_password;
