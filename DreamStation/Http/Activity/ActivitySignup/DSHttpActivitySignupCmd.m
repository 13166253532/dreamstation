//
//  DSHttpActivitySignupCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/8.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpActivitySignupCmd.h"
#import "DSHttpActivitySignupResult.h"

static NSString *kActionUrl = @"/activities/";

@implementation DSHttpActivitySignupCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpActivitySignupCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpActivitySignupResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
   
    NSString *stringUrl = [NSString stringWithFormat:@"%@%@/sign-up",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_ActivitySignup_id]];
    return stringUrl;
}

@end

NSString *const kHttpParamKey_ActivitySignup_id = @"id";

NSString *const kHttpParamKey_ActivitySignup_name = @"name";
NSString *const kHttpParamKey_ActivitySignup_account = @"account";
NSString *const kHttpParamKey_ActivitySignup_phone = @"phone";
NSString *const kHttpParamKey_ActivitySignup_company = @"company";
NSString *const kHttpParamKey_ActivitySignup_position = @"position";
NSString *const kHttpParamKey_ActivitySignup_landLine = @"landLine";
