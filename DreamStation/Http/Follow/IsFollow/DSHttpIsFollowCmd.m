//
//  DSHttpIsFollowCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpIsFollowCmd.h"
#import "DSHttpIsFollowResult.h"

static NSString *kActionUrl = @"/follow/status/";

@implementation DSHttpIsFollowCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpIsFollowCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpIsFollowResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_IsFollow_model]];
    return  urlString;
}

@end

NSString *const kHttpParamKey_IsFollow_model = @"model";
NSString *const kHttpParamKey_IsFollow_investorId = @"investorId";
NSString *const kHttpParamKey_IsFollow_investmentId = @"investmentId";
NSString *const kHttpParamKey_IsFollow_productId = @"productId";
NSString *const kHttpParamKey_IsFollow_productUserId = @"productUserId";
