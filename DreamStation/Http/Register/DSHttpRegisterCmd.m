//
//  DSHttpRegisterCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/13.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpRegisterCmd.h"
#import "DSHttpRegisterResult.h"


static NSString *kActionUrl = @"/accounts/register";

@implementation DSHttpRegisterCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{

    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpRegisterCmd alloc]initWithAuthorizationState:AuthorizationNull];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{

    self = [super initWithAuthorizationState: state];
    if (self != nil) {
        self.result = [[DSHttpRegisterResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    return kActionUrl;
}

@end

NSString *const kHttpParamKey_register_login = @"login";
NSString *const kHttpParamKey_register_password = @"password";
NSString *const kHttpParamKey_register_role = @"role";
NSString *const kHttpParamKey_register_captcha = @"captcha";

