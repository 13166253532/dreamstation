//
//  DSHttpAccountStatusCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/13.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpAccountStatusCmd.h"
#import "DSHttpAccountStatusResult.h"

static NSString *kActionUrl = @"/apply/account/";

@implementation DSHttpAccountStatusCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpAccountStatusCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpAccountStatusResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",kActionUrl,self.requestInfo[kHttpParamKey_AccountStatus_user_id]];
    return urlString;
}

@end

NSString *const kHttpParamKey_AccountStatus_user_id = @"user_id";
