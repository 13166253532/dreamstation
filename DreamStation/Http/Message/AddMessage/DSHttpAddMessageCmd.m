//
//  DSHttpAddMessageCmd.m
//  DreamStation
//
//  Created by xjb on 16/9/1.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpAddMessageCmd.h"
#import "DSHttpAddMessageResult.h"
static NSString *kActionUrl = @"/message/";
@implementation DSHttpAddMessageCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpAddMessageCmd alloc]initWithAuthorizationState:AuthorizationNull];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpAddMessageResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    
    return kActionUrl;
}
@end
NSString *const kHttpParamKey_AddMessage_id = @"id";
NSString *const kHttpParamKey_AddMessage_title = @"title";
NSString *const kHttpParamKey_AddMessage_message = @"message";
NSString *const kHttpParamKey_AddMessage_sort = @"sort";