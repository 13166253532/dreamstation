//
//  DSHttpProjectStatusCmd.m
//  DreamStation
//
//  Created by xjb on 16/9/20.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpProjectStatusCmd.h"
#import "DSHttpProjectStatusResult.h"
static NSString *kActionUrl = @"/apply/project";
@implementation DSHttpProjectStatusCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpProjectStatusCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpProjectStatusResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    NSString *url = [NSString stringWithFormat:@"%@/%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_ProjectStatus_user_id]];
    return url;
}

@end
NSString *const kHttpParamKey_ProjectStatus_user_id = @"user_id";
