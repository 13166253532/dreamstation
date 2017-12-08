//
//  DSHttpisApplyParkCmd.h
//  DreamStation
//
//  Created by xjb on 16/9/14.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpisApplyParkCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_isApplyPark_projectId;
extern NSString *const kHttpParamKey_isApplyPark_parkId;