//
//  DSHttpParkApplyCmd.m
//  DreamStation
//
//  Created by xjb on 16/9/14.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpParkApplyCmd.h"
#import "DSHttpParkApplyResult.h"

static NSString *kActionUrl = @"/accounts/park/apply";
@implementation DSHttpParkApplyCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpParkApplyCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpParkApplyResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    return kActionUrl;
}

@end
NSString *const kHttpParamKey_ParkApply_phone = @"phone";
NSString *const kHttpParamKey_ParkApply_name = @"name";
NSString *const kHttpParamKey_ParkApply_company = @"company";
NSString *const kHttpParamKey_ParkApply_title = @"title";
NSString *const kHttpParamKey_ParkApply_parkId = @"parkId";
NSString *const kHttpParamKey_ParkApply_projectId = @"projectId";