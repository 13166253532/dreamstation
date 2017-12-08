//
//  DSHttpPostStatisticsCmd.m
//  DreamStation
//
//  Created by xjb on 16/9/13.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpPostStatisticsCmd.h"
#import "DSHttpPostStatisticsResult.h"
static NSString *kActionUrl = @"/accounts/statistics";
@implementation DSHttpPostStatisticsCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpPostStatisticsCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpPostStatisticsResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    return kActionUrl;
}

@end
NSString *const kHttpParamKey_PostStatistics_userId = @"userId";
NSString *const kHttpParamKey_PostStatistics_targetId = @"targetId";
