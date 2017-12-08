//
//  DSHttpCollectionsListCmd.h
//  DreamStation
//
//  Created by xjb on 16/8/8.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpCollectionsListCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_CollectionList_page;
extern NSString *const kHttpParamKey_CollectionList_size;