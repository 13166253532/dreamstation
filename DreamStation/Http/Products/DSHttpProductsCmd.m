//
//  DSHttpProductsCmd.m
//  DreamStation
//
//  Created by QPP on 16/8/5.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpProductsCmd.h"
#import "DSHttpProductsResult.h"

static NSString *kActionUrl = @"/products/";


@implementation DSHttpProductsCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpProductsCmd alloc]initWithAuthorizationState:AuthorizationNull];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpProductsResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
//    NSString *url = [NSString stringWithFormat:@"%@?page=%@&sortType=%@&sortItem=%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_products_page],[self.requestInfo objectForKey:kHttpParamKey_products_sortType],[self.requestInfo objectForKey:kHttpParamKey_products_sortItem]];
    NSString *url = [NSString stringWithFormat:@"%@?page=%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_products_page]];
    
    
    if ([self.requestInfo objectForKey:kHttpParamKey_products_query] != nil) {
        url = [NSString stringWithFormat:@"%@&query=%@",url,[self.requestInfo objectForKey:kHttpParamKey_products_query]];
    }
    if ([self.requestInfo objectForKey:kHttpParamKey_products_amountMin] != nil) {
        url = [NSString stringWithFormat:@"%@&amountMin=%@&amountMax=%@",url,[self.requestInfo objectForKey:kHttpParamKey_products_amountMin],[self.requestInfo objectForKey:kHttpParamKey_products_amountMax]];
    }
    return url;
}

@end

NSString *const kHttpParamKey_products_page=@"page";
NSString *const kHttpParamKey_products_size=@"size";
NSString *const kHttpParamKey_products_query = @"query";

NSString *const kHttpParamKey_products_Name = @"name";
NSString *const kHttpParamKey_products_description = @"description";
NSString *const kHttpParamKey_products_opertor = @"opertor";
 NSString *const kHttpParamKey_products_amountMin = @"amountMin";
 NSString *const kHttpParamKey_products_amountMax = @"amountMax";
 NSString *const kHttpParamKey_products_sortType = @"sortType";
 NSString *const kHttpParamKey_products_sortItem = @"sortItem";
