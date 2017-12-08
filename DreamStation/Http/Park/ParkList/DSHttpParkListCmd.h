//
//  DSHttpParkListCmd.h
//  DreamStation
//
//  Created by xjb on 16/8/22.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpParkListCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_ParkList_page;
extern NSString *const kHttpParamKey_ParkList_size;
extern NSString *const kHttpParamKey_ParkList_park;