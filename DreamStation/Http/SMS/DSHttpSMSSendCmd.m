//
//  DSHttpSMSSendCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/5.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpSMSSendCmd.h"
#import "DSHttpSMSSendResult.h"

static NSString *kActionUrl = @"/sms/send/captcha";

@implementation DSHttpSMSSendCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{

    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpSMSSendCmd alloc]initWithAuthorizationState:AuthorizationNull];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{

    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpSMSSendResult alloc]init];
    }
    return self;
    
}

- (NSString *)getActionUrl{
    return kActionUrl;
}

@end

NSString *const kHttpParamKey_SMSSend_phone=@"phone";
NSString *const kHttpParamKey_SMSSend_templateId=@"templateId";
NSString *const kHttpParamKey_SMSSend_model = @"model";
