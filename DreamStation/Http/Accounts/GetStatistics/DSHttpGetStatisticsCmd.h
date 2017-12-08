//
//  DSHttpGetStatisticsCmd.h
//  DreamStation
//
//  Created by xjb on 16/9/13.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpGetStatisticsCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_GetStatistics_targetId;