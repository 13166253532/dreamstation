//
//  DSHttpSearchInvestorCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpSearchInvestorCmd.h"
#import "DSHttpSearchInvestorResult.h"

static NSString *kActionUrl = @"/accounts/individuals/name";

@implementation DSHttpSearchInvestorCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpSearchInvestorCmd alloc]initWithAuthorizationState:AuthorizationNull];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpSearchInvestorResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    NSString *url = [NSString stringWithFormat:@"%@?page=%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_SearchInvestor_page]];
    return url;
}

@end


NSString *const kHttpParamKey_SearchInvestor_page = @"page";
NSString *const kHttpParamKey_SearchInvestor_size = @"size";
NSString *const kHttpParamKey_SearchInvestor_name = @"name";