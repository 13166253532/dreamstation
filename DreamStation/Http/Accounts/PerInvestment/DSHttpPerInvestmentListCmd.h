//
//  DSHttpPerInvestmentListCmd.h
//  DreamStation
//
//  Created by xjb on 16/8/10.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpPerInvestmentListCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_PerInvestmentList_page;
extern NSString *const kHttpParamKey_PerInvestmentList_size;

extern NSString *const kHttpParamKey_PerInvestmentList_query;

extern NSString *const kHttpParamKey_PerInvestmentList_Name;
extern NSString *const kHttpParamKey_PerInvestmentList_description;
extern NSString *const kHttpParamKey_PerInvestmentList_opertor;
extern NSString *const kHttpParamKey_PerInvestmentList_investMin;
extern NSString *const kHttpParamKey_PerInvestmentList_investMax;

extern NSString *const kHttpParamKey_PerInvestmentList_sortType;
extern NSString *const kHttpParamKey_PerInvestmentList_sortItem;
