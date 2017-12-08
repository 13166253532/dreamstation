//
//  DSHttpFollowCountNumCmd.m
//  DreamStation
//
//  Created by xjb on 16/9/21.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpFollowCountNumCmd.h"
#import "DSHttpFollowCountNumResule.h"
static NSString *kActionUrl = @"/follow/count";
@implementation DSHttpFollowCountNumCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpFollowCountNumCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpFollowCountNumResule alloc]init];
    }
    return self;
}
- (NSString *)getActionUrl{
    NSString *str = [NSString stringWithFormat:@"%@/%@/%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_FollowCountNum_role],[self.requestInfo objectForKey:kHttpParamKey_FollowCountNum_id]];
    return str;
}

@end
NSString * const kHttpParamKey_FollowCountNum_role = @"role";
NSString * const kHttpParamKey_FollowCountNum_id = @"id";