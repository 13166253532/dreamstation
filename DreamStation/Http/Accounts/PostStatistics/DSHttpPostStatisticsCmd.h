//
//  DSHttpPostStatisticsCmd.h
//  DreamStation
//
//  Created by xjb on 16/9/13.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBasePostCmd.h"

@interface DSHttpPostStatisticsCmd : SNHttpBasePostCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_PostStatistics_userId;
extern NSString *const kHttpParamKey_PostStatistics_targetId;