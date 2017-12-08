//
//  DSHttpSearchParkCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/13.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpSearchParkCmd.h"
#import "DSHttpSearchParkResult.h"

static NSString *kActionUrl = @"/accounts/park/address";

@implementation DSHttpSearchParkCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpSearchParkCmd alloc]initWithAuthorizationState:AuthorizationNull];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpSearchParkResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    //NSString *url = [NSString stringWithFormat:@"%@?address=%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_SearchPark_address]];
    return kActionUrl;
}

@end

NSString *const kHttpParamKey_SearchPark_address = @"address";