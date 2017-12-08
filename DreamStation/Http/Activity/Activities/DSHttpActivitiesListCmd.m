//
//  DSHttpActivitiesListCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/5.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpActivitiesListCmd.h"
#import "DSHttpActivitiesListResule.h"

static NSString *kActionUrl = @"/activities/";

@implementation DSHttpActivitiesListCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{

    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpActivitiesListCmd alloc]initWithAuthorizationState:AuthorizationNull];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{

    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpActivitiesListResule alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    NSString *url = [NSString stringWithFormat:@"%@?page=%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_ActivitiesList_page]];
    return url;
}

@end


NSString *const kHttpParamKey_ActivitiesList_page = @"page";
NSString *const kHttpParamKey_ActivitiesList_size = @"size";
NSString *const kHttpParamKey_ActivitiesList_sortType = @"sortType";
NSString *const kHttpParamKey_ActivitiesList_sortItem = @"sortItem";
