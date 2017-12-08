//
//  DSHttpParkApplyCmd.h
//  DreamStation
//
//  Created by xjb on 16/9/14.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBasePostCmd.h"

@interface DSHttpParkApplyCmd : SNHttpBasePostCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_ParkApply_phone;
extern NSString *const kHttpParamKey_ParkApply_name;
extern NSString *const kHttpParamKey_ParkApply_company;
extern NSString *const kHttpParamKey_ParkApply_title;
extern NSString *const kHttpParamKey_ParkApply_parkId;
extern NSString *const kHttpParamKey_ParkApply_projectId;