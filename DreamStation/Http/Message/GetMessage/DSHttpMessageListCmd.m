//
//  DSHttpMessageListCmd.m
//  DreamStation
//
//  Created by xjb on 16/9/1.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpMessageListCmd.h"
#import "DSHttpMessageListResult.h"
static NSString *kActionUrl = @"/message/";

@implementation DSHttpMessageListCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpMessageListCmd alloc]initWithAuthorizationState:AuthorizationNull];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpMessageListResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    
    return kActionUrl;
}
@end
