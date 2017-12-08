//
//  DSHttpParkCityListCmd.m
//  DreamStation
//
//  Created by xjb on 16/9/8.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpParkCityListCmd.h"
#import "DSHttpParkCityListResult.h"
static NSString *kActionUrl = @"/accounts/park/address";
@implementation DSHttpParkCityListCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpParkCityListCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpParkCityListResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    NSString *url = [NSString stringWithFormat:@"%@?address＝%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_ParkCityList_address]];
    return url;
}

@end
NSString *const kHttpParamKey_ParkCityList_address = @"address";