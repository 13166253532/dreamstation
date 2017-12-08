//
//  DSHttpProgramsListCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpProgramsListCmd.h"
#import "DSHttpProgramsListResult.h"

static NSString *kActionUrl = @"/home/programs/type";

@implementation DSHttpProgramsListCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{

    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpProgramsListCmd alloc]initWithAuthorizationState:AuthorizationNull];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpProgramsListResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    NSString *url = [NSString stringWithFormat:@"%@?page=%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_ProgramsList_page]];
    return url;
}

@end

NSString *const kHttpParamKey_ProgramsList_page = @"page";
NSString *const kHttpParamKey_ProgramsList_size = @"size";
NSString *const kHttpParamKey_ProgramsList_type = @"type";
NSString *const kHttpParamKey_ProgramsList_showOnlyPublish = @"showOnlyPublish";
