//
//  DSHttpSMSVerifyCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/5.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpSMSVerifyCmd.h"
#import "DSHttpSMSVerifyResult.h"

static NSString *kActionUrl = @"/sms/verify/captcha";

@implementation DSHttpSMSVerifyCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{

    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpSMSVerifyCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpSMSVerifyResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{

    return kActionUrl;
}

@end

NSString *const kHttpParamKey_SMSVerify_phone=@"phone";
NSString *const kHttpParamKey_SMSVerify_captcha=@"captcha";


