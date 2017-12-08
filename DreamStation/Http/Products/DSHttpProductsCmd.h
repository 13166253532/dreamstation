//
//  DSHttpProductsCmd.h
//  DreamStation
//
//  Created by QPP on 16/8/5.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpProductsCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end

extern NSString *const kHttpParamKey_products_page;
extern NSString *const kHttpParamKey_products_size;

extern NSString *const kHttpParamKey_products_query;
extern NSString *const kHttpParamKey_products_Name;
extern NSString *const kHttpParamKey_products_description;
extern NSString *const kHttpParamKey_products_opertor;

extern NSString *const kHttpParamKey_products_amountMin;
extern NSString *const kHttpParamKey_products_amountMax;

extern NSString *const kHttpParamKey_products_sortType;
extern NSString *const kHttpParamKey_products_sortItem;