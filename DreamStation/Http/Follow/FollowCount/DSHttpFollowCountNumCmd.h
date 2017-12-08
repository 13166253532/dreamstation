//
//  DSHttpFollowCountNumCmd.h
//  DreamStation
//
//  Created by xjb on 16/9/21.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpFollowCountNumCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString * const kHttpParamKey_FollowCountNum_role;
extern NSString * const kHttpParamKey_FollowCountNum_id;