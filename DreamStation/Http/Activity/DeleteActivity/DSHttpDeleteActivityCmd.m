//
//  DSHttpDeleteActivityCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpDeleteActivityCmd.h"
#import "DSHttpDeleteActivityResult.h"

static NSString *kActionUrl = @"/activities/";

@implementation DSHttpDeleteActivityCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpDeleteActivityCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpDeleteActivityResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    
    NSString *str=[NSString stringWithFormat:@"%@%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_DeleteActivity_id]];
    return str;
}

@end

NSString *const kHttpParamKey_DeleteActivity_id = @"id";
