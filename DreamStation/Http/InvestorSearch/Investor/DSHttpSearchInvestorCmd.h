//
//  DSHttpSearchInvestorCmd.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpSearchInvestorCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end

extern NSString *const kHttpParamKey_SearchInvestor_page;
extern NSString *const kHttpParamKey_SearchInvestor_size;
extern NSString *const kHttpParamKey_SearchInvestor_name;