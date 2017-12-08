//
//  DSHttpProductsDetailsCmd.m
//  DreamStation
//
//  Created by xjb on 16/8/15.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpProductsDetailsCmd.h"
#import "DSHttpProductsDetailsResult.h"

static NSString *kActionUrl = @"/products/";
@implementation DSHttpProductsDetailsCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpProductsDetailsCmd alloc]initWithAuthorizationState:AuthorizationNull];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpProductsDetailsResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    NSString *url = [NSString stringWithFormat:@"%@%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_productsDetails_id]];
    return url;
}

@end
NSString *const kHttpParamKey_productsDetails_id = @"id";