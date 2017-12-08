//
//  DSHttpPleasefocuListCmd.h
//  DreamStation
//
//  Created by xjb on 16/8/25.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpPleasefocuListCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString * const kHttpParamKey_PleasefocuList_page;
extern NSString * const kHttpParamKey_PleasefocuList_size;
extern NSString * const kHttpParamKey_PleasefocuList_individualId;
extern NSString * const kHttpParamKey_PleasefocuList_institutionId;