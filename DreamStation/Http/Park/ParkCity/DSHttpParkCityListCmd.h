//
//  DSHttpParkCityListCmd.h
//  DreamStation
//
//  Created by xjb on 16/9/8.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpParkCityListCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_ParkCityList_address;