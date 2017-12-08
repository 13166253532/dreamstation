//
//  DSHttpFollowNumCmd.m
//  DreamStation
//
//  Created by xjb on 16/8/8.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpFollowNumCmd.h"
#import "DSHttpFollowNumResule.h"
static NSString *kActionUrl;

@implementation DSHttpFollowNumCmd


+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{

    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpFollowNumCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpFollowNumResule alloc]init];
    }
    return self;
}
- (NSString *)getActionUrl{
    NSString *str = [NSString stringWithFormat:@"/follow/interview/product/%@",[self.requestInfo objectForKey:kHttpParamKey_Follow_Project_id]];
    return str;
}
@end
NSString * const kHttpParamKey_Follow_Project_id = @"id";