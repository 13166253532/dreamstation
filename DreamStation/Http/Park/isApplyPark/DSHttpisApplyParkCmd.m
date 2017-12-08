//
//  DSHttpisApplyParkCmd.m
//  DreamStation
//
//  Created by xjb on 16/9/14.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpisApplyParkCmd.h"
#import "DSHttpisApplyParkResult.h"
static NSString *kActionUrl = @"/accounts/park/apply/exists/";
@implementation DSHttpisApplyParkCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpisApplyParkCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpisApplyParkResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    NSString *url = [NSString stringWithFormat:@"%@%@/%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_isApplyPark_projectId],[self.requestInfo objectForKey:kHttpParamKey_isApplyPark_parkId]];
    return url;
}

@end
NSString *const kHttpParamKey_isApplyPark_projectId = @"projectId";
NSString *const kHttpParamKey_isApplyPark_parkId = @"parkId";