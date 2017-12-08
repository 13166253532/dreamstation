//
//  DSHttpSearchAgencyCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/7.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpSearchAgencyCmd.h"
#import "DSHttpSearchAgencyResult.h"

static NSString *kActionUrl = @"/accounts/institutions/name";

@implementation DSHttpSearchAgencyCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpSearchAgencyCmd alloc]initWithAuthorizationState:AuthorizationNull];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpSearchAgencyResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    NSString *url = [NSString stringWithFormat:@"%@?page=%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_SearchAgency_page]];
    return url;
}


@end


NSString *const kHttpParamKey_SearchAgency_page = @"page";
NSString *const kHttpParamKey_SearchAgency_size = @"size";
NSString *const kHttpParamKey_SearchAgency_name = @"name";