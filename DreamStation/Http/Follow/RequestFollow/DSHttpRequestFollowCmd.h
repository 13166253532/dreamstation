//
//  DSHttpRequestFollowCmd.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBasePostCmd.h"

@interface DSHttpRequestFollowCmd : SNHttpBasePostCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end

extern NSString *const kHttpParamKey_RequestFollow_model;
extern NSString *const kHttpParamKey_RequestFollow_items;
extern NSString *const kHttpParamKey_RequestFollow_provider;
extern NSString *const kHttpParamKey_RequestFollow_individual;
extern NSString *const kHttpParamKey_RequestFollow_institutioner;


extern NSString *const kHttpParamKey_RequestFollow_items_productName;
extern NSString *const kHttpParamKey_RequestFollow_items_categories;
extern NSString *const kHttpParamKey_RequestFollow_items_investmentUserId;
extern NSString *const kHttpParamKey_RequestFollow_items_productUrl;
extern NSString *const kHttpParamKey_RequestFollow_items_productId;
extern NSString *const kHttpParamKey_RequestFollow_items_productUserId;
extern NSString *const kHttpParamKey_RequestFollow_items_userGroupId;
extern NSString *const kHttpParamKey_RequestFollow_items_account;
extern NSString *const kHttpParamKey_RequestFollow_items_userName;
extern NSString *const kHttpParamKey_RequestFollow_items_avaterUrl;
extern NSString *const kHttpParamKey_RequestFollow_items_domain;
extern NSString *const kHttpParamKey_RequestFollow_items_phase;
extern NSString *const kHttpParamKey_RequestFollow_items_videoUrl;
extern NSString *const kHttpParamKey_RequestFollow_items_wechat;
extern NSString *const kHttpParamKey_RequestFollow_items_address;
extern NSString *const kHttpParamKey_RequestFollow_items_introduceImgUrl;
extern NSString *const kHttpParamKey_RequestFollow_items_introduceDesc;
extern NSString *const kHttpParamKey_RequestFollow_items_companyName;
