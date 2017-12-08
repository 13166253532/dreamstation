//
//  DSHttpRequestFollowCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpRequestFollowCmd.h"
#import "DSHttpRequestFollowResult.h"

static NSString *kActionUrl = @"/follow/";

@implementation DSHttpRequestFollowCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpRequestFollowCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpRequestFollowResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    
    NSString *stringUrl = [NSString stringWithFormat:@"%@%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_RequestFollow_model]];
    return stringUrl;
}


@end

NSString *const kHttpParamKey_RequestFollow_model = @"MODEL";
NSString *const kHttpParamKey_RequestFollow_items = @"items";
NSString *const kHttpParamKey_RequestFollow_provider = @"provider";
NSString *const kHttpParamKey_RequestFollow_individual = @"individual";
NSString *const kHttpParamKey_RequestFollow_institutioner = @"institutioner";


NSString *const kHttpParamKey_RequestFollow_items_productName = @"productName";
NSString *const kHttpParamKey_RequestFollow_items_categories = @"categories";
NSString *const kHttpParamKey_RequestFollow_items_investmentUserId = @"investmentUserId";
NSString *const kHttpParamKey_RequestFollow_items_productUrl = @"productUrl";
NSString *const kHttpParamKey_RequestFollow_items_productId = @"productId";
NSString *const kHttpParamKey_RequestFollow_items_productUserId = @"productUserId";
NSString *const kHttpParamKey_RequestFollow_items_userGroupId = @"userGroupId";
NSString *const kHttpParamKey_RequestFollow_items_account = @"account";
NSString *const kHttpParamKey_RequestFollow_items_userName = @"userName";
NSString *const kHttpParamKey_RequestFollow_items_avaterUrl = @"avaterUrl";
NSString *const kHttpParamKey_RequestFollow_items_domain = @"domain";
NSString *const kHttpParamKey_RequestFollow_items_phase = @"phase";
NSString *const kHttpParamKey_RequestFollow_items_videoUrl = @"videoUrl";
NSString *const kHttpParamKey_RequestFollow_items_wechat = @"wechat";
NSString *const kHttpParamKey_RequestFollow_items_address = @"address";
NSString *const kHttpParamKey_RequestFollow_items_introduceImgUrl = @"introduceImgUrl";
NSString *const kHttpParamKey_RequestFollow_items_introduceDesc = @"introduceDesc";
NSString *const kHttpParamKey_RequestFollow_items_companyName = @"companyName";
