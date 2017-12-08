//
//  DSHttpSMSSendCmd.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/5.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBasePostCmd.h"

@interface DSHttpSMSSendCmd : SNHttpBasePostCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;

@end

extern NSString *const kHttpParamKey_SMSSend_phone;
extern NSString *const kHttpParamKey_SMSSend_templateId;
extern NSString *const kHttpParamKey_SMSSend_model;
