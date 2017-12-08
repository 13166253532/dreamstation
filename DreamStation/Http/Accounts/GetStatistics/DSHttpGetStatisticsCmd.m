//
//  DSHttpGetStatisticsCmd.m
//  DreamStation
//
//  Created by xjb on 16/9/13.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpGetStatisticsCmd.h"
#import "DSHttpGetStrtisticsResult.h"
static NSString *kActionUrl = @"/accounts/statistics";
@implementation DSHttpGetStatisticsCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpGetStatisticsCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpGetStrtisticsResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    return kActionUrl;
}

@end
NSString *const kHttpParamKey_GetStatistics_targetId = @"targetId";