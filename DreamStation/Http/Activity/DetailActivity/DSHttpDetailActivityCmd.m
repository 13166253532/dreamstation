//
//  DSHttpDetailActivityCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/8.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpDetailActivityCmd.h"
#import "DSHttpDetailActivityResult.h"

static NSString *kActionUrl = @"/activities/";

@implementation DSHttpDetailActivityCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{

    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpDetailActivityCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{

    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpDetailActivityResult alloc]init];
    }
    return self;
    
}

- (NSString *)getActionUrl{

    NSString *str=[NSString stringWithFormat:@"%@%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_DetailActivity_id]];
    return str;
}

@end

NSString *const kHttpParamKey_DetailActivity_id = @"id";

