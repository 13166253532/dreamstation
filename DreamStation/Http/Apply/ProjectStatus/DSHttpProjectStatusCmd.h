//
//  DSHttpProjectStatusCmd.h
//  DreamStation
//
//  Created by xjb on 16/9/20.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpProjectStatusCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_ProjectStatus_user_id;
