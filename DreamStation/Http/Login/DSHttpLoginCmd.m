//
//  DSHttpLoginCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/14.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpLoginCmd.h"
#import "DSHttpLoginResult.h"

static NSString *kActionUrl = @"/accounts/login";

@implementation DSHttpLoginCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpLoginCmd alloc]initWithAuthorizationState:AuthorizationNull];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{

    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpLoginResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{

    
    return kActionUrl;
}


@end



NSString *const kHttpParamKey_login_login = @"login";
NSString *const kHttpParamKey_login_password = @"password";



