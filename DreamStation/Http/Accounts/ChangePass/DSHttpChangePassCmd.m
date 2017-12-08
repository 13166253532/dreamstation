//
//  DSHttpChangePassCmd.m
//  DreamStation
//
//  Created by xjb on 16/8/17.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpChangePassCmd.h"
#import "DSHttpChangePassResult.h"

static NSString *kActionUrl = @"/accounts/persons/password";
@implementation DSHttpChangePassCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpChangePassCmd alloc]initWithAuthorizationState:AuthorizationNull];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}
- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpChangePassResult alloc]init];
    }
    return self;
}
- (NSString *)getActionUrl{
    return kActionUrl;
}

@end
NSString *const kHttpParamKey_ChangePass_phone = @"phone";
NSString *const kHttpParamKey_ChangePass_password = @"password";
NSString *const kHttpParamKey_ChangePass_captcha = @"captcha";