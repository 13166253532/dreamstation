//
//  DSHttpSMSVerifyCmd.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/5.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBasePostCmd.h"

@interface DSHttpSMSVerifyCmd : SNHttpBasePostCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;

@end

extern NSString *const kHttpParamKey_SMSVerify_phone;
extern NSString *const kHttpParamKey_SMSVerify_captcha;

