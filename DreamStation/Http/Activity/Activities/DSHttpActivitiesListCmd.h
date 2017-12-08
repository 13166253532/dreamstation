//
//  DSHttpActivitiesListCmd.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/5.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpActivitiesListCmd : SNHttpBaseGetCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;

@end

extern NSString *const kHttpParamKey_ActivitiesList_page;
extern NSString *const kHttpParamKey_ActivitiesList_size;
extern NSString *const kHttpParamKey_ActivitiesList_sortType;
extern NSString *const kHttpParamKey_ActivitiesList_sortItem;
