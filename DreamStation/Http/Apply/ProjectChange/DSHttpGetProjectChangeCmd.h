//
//  DSHttpGetProjectChangeCmd.h
//  DreamStation
//
//  Created by xjb on 2016/12/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpGetProjectChangeCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_GetProjectChange_status;
extern NSString *const kHttpParamKey_GetProjectChange_login;
extern NSString *const kHttpParamKey_GetProjectChange_type;
extern NSString *const kHttpParamKey_GetProjectChange_sortType;
