//
//  DSHttpAccountsInstituListCmd.h
//  DreamStation
//
//  Created by xjb on 16/8/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpAccountsInstituListCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_AccountsInstituList_page;
extern NSString *const kHttpParamKey_AccountsInstituList_size;
extern NSString *const kHttpParamKey_AccountsInstituList_query;

extern NSString *const kHttpParamKey_AccountsInstituList_Name;
extern NSString *const kHttpParamKey_AccountsInstituList_description;
extern NSString *const kHttpParamKey_AccountsInstituList_opertor;

extern NSString *const kHttpParamKey_AccountsInstituList_investMin;
extern NSString *const kHttpParamKey_AccountsInstituList_investMax;

extern NSString *const kHttpParamKey_AccountsInstituList_sortType;
extern NSString *const kHttpParamKey_AccountsInstituList_sortItem;
