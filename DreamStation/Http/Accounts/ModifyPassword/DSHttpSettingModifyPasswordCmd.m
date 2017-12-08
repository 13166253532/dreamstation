//
//  DSHttpSettingModifyPasswordCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/26.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpSettingModifyPasswordCmd.h"
#import "DSHttpSettingModifyPasswordResult.h"

static NSString *kActionUrl = @"/accounts/persons/modify/password";

@implementation DSHttpSettingModifyPasswordCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpSettingModifyPasswordCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}
- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpSettingModifyPasswordResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    return kActionUrl;
}

@end

NSString *const kHttpParamKey_SettingModifyPassword_password = @"password";
