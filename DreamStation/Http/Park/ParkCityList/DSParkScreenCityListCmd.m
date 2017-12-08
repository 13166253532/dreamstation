//
//  DSParkScreenCityListCmd.m
//  DreamStation
//
//  Created by xjb on 2016/11/28.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSParkScreenCityListCmd.h"
#import "DSParkScreenCityListResult.h"
static NSString *kActionUrl = @"/accounts/park/city";
@implementation DSParkScreenCityListCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSParkScreenCityListCmd alloc]initWithAuthorizationState:AuthorizationNull];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSParkScreenCityListResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    
    return kActionUrl;
}

@end
