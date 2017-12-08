//
//  DSHttpProductFollowListCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/15.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpProductFollowListCmd.h"
#import "DSHttpProductFollowListResult.h"

static NSString *kActionUrl = @"/follow/product/FOLLOW/";

@implementation DSHttpProductFollowListCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpProductFollowListCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpProductFollowListResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    
    NSString *uslSring = [NSString stringWithFormat:@"%@%@?page=%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_ProductFollowList_userId],[self.requestInfo objectForKey:kHttpParamKey_ProductFollowList_page]];
    return uslSring;
}

@end

NSString *const kHttpParamKey_ProductFollowList_userId = @"userId";
NSString *const kHttpParamKey_ProductFollowList_page = @"page";
NSString *const kHttpParamKey_ProductFollowList_size = @"size";
