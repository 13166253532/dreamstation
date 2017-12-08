//
//  DSHttpInvestorsFollowListCmd.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpInvestorsFollowListCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end

extern NSString *const kHttpParamKey_InvestorsFollowList_model;
extern NSString *const kHttpParamKey_InvestorsFollowList_page;
extern NSString *const kHttpParamKey_InvestorsFollowList_size;