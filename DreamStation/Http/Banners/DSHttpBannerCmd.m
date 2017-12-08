//
//  DSHttpBannerCmd.m
//  DreamStation
//
//  Created by QPP on 16/8/4.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpBannerCmd.h"
#import "DSHttpBannerResult.h"
static NSString *kActionUrl = @"/home/banners";

@implementation DSHttpBannerCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpBannerCmd alloc]initWithAuthorizationState:AuthorizationNull];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpBannerResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    
    
    return kActionUrl;
}

@end
