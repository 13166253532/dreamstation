//
//  DSHttpMyActivityCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/8.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpMyActivityCmd.h"
#import "DSHttpMyActivityResult.h"

static NSString *kActionUrl = @"/activities/self";

@implementation DSHttpMyActivityCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{

    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpMyActivityCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpMyActivityResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{

    return kActionUrl;
    
}

@end
