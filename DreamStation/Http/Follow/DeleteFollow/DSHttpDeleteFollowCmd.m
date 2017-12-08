//
//  DSHttpDeleteFollowCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpDeleteFollowCmd.h"
#import "DSHttpDeleteFollowResult.h"

static NSString *kActionUrl = @"/follow/";

@implementation DSHttpDeleteFollowCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpDeleteFollowCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpDeleteFollowResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    
    NSString *str=[NSString stringWithFormat:@"%@%@/%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_DeleteFollow_id],[self.requestInfo objectForKey:kHttpParamKey_DeleteFollow_itemId]];
    return str;
}


@end

NSString *const kHttpParamKey_DeleteFollow_id = @"id";
NSString *const kHttpParamKey_DeleteFollow_itemId = @"itemId";