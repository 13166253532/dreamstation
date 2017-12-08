//
//  DSHttpApplyParkCmd.m
//  DreamStation
//
//  Created by xjb on 16/8/29.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpApplyParkCmd.h"
#import "DSHttpApplyParkResult.h"
static NSString *kActionUrl = @"/apply/park";
@implementation DSHttpApplyParkCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpApplyParkCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpApplyParkResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    return kActionUrl;
}

@end
NSString *const kHttpParamKey_ApplyPark_name = @"name";
NSString *const kHttpParamKey_ApplyPark_parkName = @"parkName";
NSString *const kHttpParamKey_ApplyPark_job = @"job" ;
NSString *const kHttpParamKey_ApplyPark_phoneNum = @"phoneNum";
NSString *const kHttpParamKey_ApplyPark_mail = @"mail";