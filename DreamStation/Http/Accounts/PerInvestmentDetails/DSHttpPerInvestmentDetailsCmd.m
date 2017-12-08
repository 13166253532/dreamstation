//
//  DSHttpPerInvestmentDetailsCmd.m
//  DreamStation
//
//  Created by xjb on 16/8/10.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpPerInvestmentDetailsCmd.h"
#import "DSHttpPerInvestmentDetailsResult.h"
static NSString *kActionUrl = @"/accounts/individuals/";
@implementation DSHttpPerInvestmentDetailsCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpPerInvestmentDetailsCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}
- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpPerInvestmentDetailsResult alloc]init];
    }
    return self;
}
- (NSString *)getActionUrl{
   // NSString *url = [NSString stringWithFormat:@"%@%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_PerInvestmentDetails_user_id]];
    return kActionUrl;
}
@end
NSString *const kHttpParamKey_PerInvestmentDetails_user_id = @"user_id";