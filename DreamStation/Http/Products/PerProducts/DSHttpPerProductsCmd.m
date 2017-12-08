//
//  DSHttpPerProductsCmd.m
//  DreamStation
//
//  Created by xjb on 16/8/24.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpPerProductsCmd.h"
#import "DSHttpPerProductsResult.h"
static NSString *kActionUrl = @"/products/user/";
@implementation DSHttpPerProductsCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpPerProductsCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpPerProductsResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    NSString *url = [NSString stringWithFormat:@"%@%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_PerProducts_id]];
    return url;
}

@end
NSString *const kHttpParamKey_PerProducts_id = @"id";
