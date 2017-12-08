//
//  DSHttpInvestorsFollowListCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpInvestorsFollowListCmd.h"
#import "DSHttpInvestorsFollowListResult.h"

static NSString *kActionUrl = @"/follow/";

@implementation DSHttpInvestorsFollowListCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpInvestorsFollowListCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpInvestorsFollowListResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    NSString *urlString = [NSString stringWithFormat:@"%@%@?page=%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_InvestorsFollowList_model],[self.requestInfo objectForKey:kHttpParamKey_InvestorsFollowList_page]];
    return  urlString;
}

@end


NSString *const kHttpParamKey_InvestorsFollowList_model = @"model";
NSString *const kHttpParamKey_InvestorsFollowList_page = @"page";
NSString *const kHttpParamKey_InvestorsFollowList_size = @"size";