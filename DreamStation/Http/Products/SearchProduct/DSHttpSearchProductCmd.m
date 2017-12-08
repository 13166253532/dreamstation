//
//  DSHttpSearchProductCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/6.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpSearchProductCmd.h"
#import "DSHttpSearchProductResult.h"

static NSString *kActionUrl = @"/products/name";

@implementation DSHttpSearchProductCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpSearchProductCmd alloc]initWithAuthorizationState:AuthorizationNull];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpSearchProductResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    
    return kActionUrl;
}
@end

NSString *const kHttpParamKey_SearchProduct_page = @"page";
NSString *const kHttpParamKey_SearchProduct_size = @"size";
NSString *const kHttpParamKey_SearchProduct_name = @"name";
