//
//  DSHttpIsCollectionsCmd.h
//  DreamStation
//
//  Created by xjb on 16/8/11.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpIsCollectionsCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_IsCollections_groupId;
extern NSString *const kHttpParamKey_IsCollections_collections;
extern NSString *const kHttpParamKey_IsCollections_type;