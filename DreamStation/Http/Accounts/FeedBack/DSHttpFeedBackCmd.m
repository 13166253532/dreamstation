//
//  DSHttpFeedBackCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/29.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpFeedBackCmd.h"
#import "DSHttpFeedBackResult.h"

static NSString *kActionUrl = @"/feedback";

@implementation DSHttpFeedBackCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpFeedBackCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpFeedBackResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    return kActionUrl;
}

@end


NSString *const kHttpParamKey_FeedBack_fromId = @"fromId";
NSString *const kHttpParamKey_FeedBack_fromName = @"fromName";
NSString *const kHttpParamKey_FeedBack_message = @"message";