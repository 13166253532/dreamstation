//
//  DSHttpPerInvestmentListCmd.m
//  DreamStation
//
//  Created by xjb on 16/8/10.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpPerInvestmentListCmd.h"
#import "DSHttpPerInvestmentListResule.h"
static NSString *kActionUrl = @"/accounts/individuals";

@implementation DSHttpPerInvestmentListCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpPerInvestmentListCmd alloc]initWithAuthorizationState:AuthorizationNull];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpPerInvestmentListResule alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    NSString *url1 = [NSString stringWithFormat:@"%@?page=%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_PerInvestmentList_page]];
    if ([self.requestInfo objectForKey:kHttpParamKey_PerInvestmentList_query] != nil) {
        url1 = [NSString stringWithFormat:@"%@&query=%@",url1,[self.requestInfo objectForKey:kHttpParamKey_PerInvestmentList_query]];
    }
    if ([self.requestInfo objectForKey:kHttpParamKey_PerInvestmentList_investMin] != nil) {
        url1 = [NSString stringWithFormat:@"%@&investMin=%@&investMax=%@",url1,[self.requestInfo objectForKey:kHttpParamKey_PerInvestmentList_investMin],[self.requestInfo objectForKey:kHttpParamKey_PerInvestmentList_investMax]];
    }
    return url1;
}
@end
NSString *const kHttpParamKey_PerInvestmentList_page = @"page";
NSString *const kHttpParamKey_PerInvestmentList_size = @"size";

NSString *const kHttpParamKey_PerInvestmentList_query = @"query";

NSString *const kHttpParamKey_PerInvestmentList_Name = @"name";
NSString *const kHttpParamKey_PerInvestmentList_description = @"description";
NSString *const kHttpParamKey_PerInvestmentList_opertor = @"opertor";

NSString *const kHttpParamKey_PerInvestmentList_investMin = @"investMin";
NSString *const kHttpParamKey_PerInvestmentList_investMax = @"investMax";

 NSString *const kHttpParamKey_PerInvestmentList_sortType = @"sortType";
 NSString *const kHttpParamKey_PerInvestmentList_sortItem = @"sortItem";
