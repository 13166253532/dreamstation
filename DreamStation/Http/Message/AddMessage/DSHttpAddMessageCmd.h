//
//  DSHttpAddMessageCmd.h
//  DreamStation
//
//  Created by xjb on 16/9/1.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBasePostCmd.h"

@interface DSHttpAddMessageCmd : SNHttpBasePostCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_AddMessage_id;
extern NSString *const kHttpParamKey_AddMessage_title;
extern NSString *const kHttpParamKey_AddMessage_message;
extern NSString *const kHttpParamKey_AddMessage_sort;